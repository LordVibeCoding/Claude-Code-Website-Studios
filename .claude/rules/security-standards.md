---
path:
  - "src/**"
---

# Security Standards

## No Private Keys in Code

NEVER hardcode private keys, seed phrases, or API secrets. This is a BLOCKING rule enforced by the `validate-commit` hook.

```tsx
// WRONG: Hardcoded private key (WILL BE BLOCKED)
const DEPLOYER_KEY = "0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80";
const MNEMONIC = "test test test test test test test test test test test junk";
const ALCHEMY_KEY = "sk_live_abc123def456";

// CORRECT: Environment variables
const DEPLOYER_KEY = process.env.DEPLOYER_PRIVATE_KEY;
const RPC_URL = process.env.NEXT_PUBLIC_RPC_URL;

// CORRECT: Runtime validation
function getRequiredEnv(key: string): string {
  const value = process.env[key];
  if (!value) {
    throw new Error(`Missing required environment variable: ${key}`);
  }
  return value;
}

const rpcUrl = getRequiredEnv("RPC_URL");
```

## Environment Variables

Use `.env.local` for secrets. Only `NEXT_PUBLIC_` prefixed variables are exposed to the browser.

```bash
# .env.local (NEVER committed)
DEPLOYER_PRIVATE_KEY=0x...
ALCHEMY_API_KEY=abc123
DATABASE_URL=postgresql://...

# .env.example (committed — no real values)
DEPLOYER_PRIVATE_KEY=
ALCHEMY_API_KEY=
DATABASE_URL=
NEXT_PUBLIC_CHAIN_ID=8453
NEXT_PUBLIC_SITE_URL=https://example.com
```

```tsx
// CORRECT: Server-side only
// src/lib/server/rpc.ts (never imported in client code)
const apiKey = process.env.ALCHEMY_API_KEY!;

// CORRECT: Public variables for client
const chainId = Number(process.env.NEXT_PUBLIC_CHAIN_ID);
```

## Content Security Policy

Configure CSP headers to prevent XSS, clickjacking, and data injection attacks.

```tsx
// next.config.js
const securityHeaders = [
  {
    key: "Content-Security-Policy",
    value: [
      "default-src 'self'",
      "script-src 'self' 'unsafe-eval'",           // unsafe-eval needed for some Web3 libs
      "style-src 'self' 'unsafe-inline'",           // Tailwind needs inline styles
      "img-src 'self' data: https: ipfs:",          // Allow IPFS images
      "font-src 'self'",
      "connect-src 'self' https://*.alchemyapi.io https://*.infura.io wss://*.alchemyapi.io", // RPC endpoints
      "frame-ancestors 'none'",                     // Prevent clickjacking
      "base-uri 'self'",
      "form-action 'self'",
    ].join("; "),
  },
  { key: "X-Frame-Options", value: "DENY" },
  { key: "X-Content-Type-Options", value: "nosniff" },
  { key: "Referrer-Policy", value: "strict-origin-when-cross-origin" },
  { key: "Permissions-Policy", value: "camera=(), microphone=(), geolocation=()" },
];
```

## CORS Configuration

Restrict CORS to known origins. Never use `*` in production.

```tsx
// CORRECT: Specific origins
// src/app/api/[...route]/route.ts
const ALLOWED_ORIGINS = [
  "https://yourdomain.com",
  "https://www.yourdomain.com",
  process.env.NODE_ENV === "development" ? "http://localhost:3000" : "",
].filter(Boolean);

export function corsHeaders(request: Request): HeadersInit {
  const origin = request.headers.get("origin") ?? "";
  const isAllowed = ALLOWED_ORIGINS.includes(origin);

  return {
    "Access-Control-Allow-Origin": isAllowed ? origin : "",
    "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
    "Access-Control-Allow-Headers": "Content-Type, Authorization",
    "Access-Control-Max-Age": "86400",
  };
}

// WRONG: Open CORS
headers["Access-Control-Allow-Origin"] = "*"; // NEVER in production
```

## Input Sanitization

Sanitize all user input before rendering or storing. Especially critical for Web3 where addresses and transaction data come from user input.

```tsx
// CORRECT: Validate address input
import { getAddress, isAddress } from "ethers";

function sanitizeAddress(input: string): `0x${string}` | null {
  const trimmed = input.trim();
  if (!isAddress(trimmed)) return null;
  return getAddress(trimmed) as `0x${string}`; // Checksummed
}

// CORRECT: Sanitize search queries
function sanitizeQuery(input: string): string {
  return input
    .trim()
    .slice(0, 200)               // Limit length
    .replace(/[<>"'&]/g, "");    // Remove HTML-significant chars
}

// CORRECT: Validate numeric input
function sanitizeAmount(input: string): bigint | null {
  const cleaned = input.replace(/[^0-9.]/g, "");
  try {
    return parseUnits(cleaned, 18);
  } catch {
    return null;
  }
}
```

## No eval() or innerHTML with User Data

These are XSS attack vectors. Never use them with any data that could originate from user input.

```tsx
// WRONG: XSS vulnerability
element.innerHTML = userProvidedHTML;
eval(userProvidedCode);
new Function(userProvidedCode)();
document.write(userData);

// CORRECT: Use safe React rendering
function TokenDescription({ description }: { description: string }) {
  // React auto-escapes by default
  return <p>{description}</p>;
}

// CORRECT: If HTML rendering is truly needed, use DOMPurify
import DOMPurify from "dompurify";

function RichContent({ html }: { html: string }) {
  const clean = DOMPurify.sanitize(html, {
    ALLOWED_TAGS: ["b", "i", "em", "strong", "a", "p", "br"],
    ALLOWED_ATTR: ["href", "target", "rel"],
  });
  return <div dangerouslySetInnerHTML={{ __html: clean }} />;
}
```

## Rate Limiting on API Routes

All API routes must have rate limiting to prevent abuse.

```tsx
// src/lib/rate-limit.ts
interface RateLimitConfig {
  readonly windowMs: number;
  readonly maxRequests: number;
}

const DEFAULT_LIMITS: Record<string, RateLimitConfig> = {
  "/api/mint": { windowMs: 60_000, maxRequests: 5 },
  "/api/search": { windowMs: 60_000, maxRequests: 30 },
  "/api/metadata": { windowMs: 60_000, maxRequests: 60 },
};

// Usage in API route
export async function POST(request: Request) {
  const ip = request.headers.get("x-forwarded-for") ?? "unknown";
  const limit = checkRateLimit(ip, "/api/mint");

  if (!limit.allowed) {
    return Response.json(
      { error: "Rate limit exceeded", retryAfter: limit.retryAfterMs },
      { status: 429, headers: { "Retry-After": String(limit.retryAfterMs / 1000) } },
    );
  }

  // ... handle request
}
```

## HTTPS Only for Web3 RPCs

Never use unencrypted HTTP for RPC connections. Validate all RPC URLs at startup.

```tsx
// CORRECT: HTTPS validation
function validateRpcUrl(url: string): string {
  const parsed = new URL(url);
  if (parsed.protocol !== "https:" && parsed.protocol !== "wss:") {
    throw new Error(`Insecure RPC URL: ${url} — use HTTPS or WSS`);
  }
  return url;
}

// Apply at config time
const RPC_URLS: Record<number, string> = {
  1: validateRpcUrl(process.env.ETH_RPC_URL ?? "https://eth.llamarpc.com"),
  8453: validateRpcUrl(process.env.BASE_RPC_URL ?? "https://mainnet.base.org"),
};

// WRONG: HTTP RPC (interceptable by MITM)
const provider = new JsonRpcProvider("http://localhost:8545"); // Only OK for local dev
```
