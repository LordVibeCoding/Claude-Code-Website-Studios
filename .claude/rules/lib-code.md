---
path:
  - "src/lib/**"
---

# Library Code Standards

## Pure Functions Preferred

All utility functions in `src/lib/` should be pure — same inputs always produce same outputs, no side effects.

```tsx
// CORRECT: Pure function
export function formatTokenAmount(
  amount: bigint,
  decimals: number,
  maxDecimals = 4,
): string {
  const divisor = 10n ** BigInt(decimals);
  const whole = amount / divisor;
  const fraction = amount % divisor;
  const fractionStr = fraction.toString().padStart(decimals, "0").slice(0, maxDecimals);
  return `${whole.toLocaleString()}.${fractionStr}`;
}

// CORRECT: Pure transformation
export function sortTokensByBalance(
  tokens: readonly Token[],
): readonly Token[] {
  return [...tokens].sort((a, b) => Number(b.balance - a.balance));
}

// WRONG: Side effect in utility
export function formatTokenAmount(amount: bigint, decimals: number): string {
  analytics.track("format_called"); // Side effect!
  return (Number(amount) / 10 ** decimals).toFixed(4);
}

// WRONG: Mutates input
export function sortTokensByBalance(tokens: Token[]): Token[] {
  tokens.sort((a, b) => Number(b.balance - a.balance)); // Mutates!
  return tokens;
}
```

## Full TypeScript Types

No `any` types. Use generics for reusable utilities. All exports must have explicit return types.

```tsx
// CORRECT: Fully typed with generics
export function groupBy<T, K extends string | number>(
  items: readonly T[],
  keyFn: (item: T) => K,
): Readonly<Record<K, readonly T[]>> {
  const result = {} as Record<K, T[]>;
  for (const item of items) {
    const key = keyFn(item);
    const group = result[key] ?? [];
    result[key] = [...group, item];
  }
  return result;
}

// CORRECT: Explicit types for domain functions
export function isValidAddress(address: string): address is `0x${string}` {
  return /^0x[0-9a-fA-F]{40}$/.test(address);
}

export function truncateAddress(address: `0x${string}`): string {
  return `${address.slice(0, 6)}...${address.slice(-4)}`;
}

// WRONG: Using any
export function groupBy(items: any[], keyFn: (item: any) => any): any {
  // ...
}
```

## No React Imports

`src/lib/` is framework-agnostic. No React, no hooks, no JSX. These are plain TypeScript utilities.

```tsx
// CORRECT: Framework-agnostic
// src/lib/chain.ts
export const CHAINS = {
  ETHEREUM: 1,
  POLYGON: 137,
  BASE: 8453,
  ARBITRUM: 42161,
} as const;

export type ChainId = (typeof CHAINS)[keyof typeof CHAINS];

export function getChainName(chainId: ChainId): string {
  const names: Record<ChainId, string> = {
    [CHAINS.ETHEREUM]: "Ethereum",
    [CHAINS.POLYGON]: "Polygon",
    [CHAINS.BASE]: "Base",
    [CHAINS.ARBITRUM]: "Arbitrum One",
  };
  return names[chainId];
}

// WRONG: React dependency in lib/
import { useState } from "react"; // FORBIDDEN in src/lib/
```

## No Side Effects

Library modules must not execute code on import. No top-level fetch calls, no global state mutation.

```tsx
// CORRECT: Export factory functions, not instances
export function createRpcProvider(
  chainId: ChainId,
  rpcUrl: string,
): JsonRpcProvider {
  return new JsonRpcProvider(rpcUrl, chainId);
}

// WRONG: Side effect on import
const provider = new JsonRpcProvider(process.env.RPC_URL!); // Runs on import!
export { provider };

// WRONG: Mutable global state
let cache: Record<string, unknown> = {};
export function getFromCache(key: string) { return cache[key]; }
export function setCache(key: string, value: unknown) { cache[key] = value; }
```

## Constants in UPPER_SNAKE_CASE

All constants must use `UPPER_SNAKE_CASE`. Group related constants in objects with `as const`.

```tsx
// CORRECT: Constants
export const MAX_UINT256 = 2n ** 256n - 1n;
export const ZERO_ADDRESS = "0x0000000000000000000000000000000000000000" as const;
export const DEFAULT_SLIPPAGE_BPS = 50; // 0.5%

export const TOKEN_DECIMALS = {
  ETH: 18,
  USDC: 6,
  USDT: 6,
  WBTC: 8,
} as const;

export const CONTRACT_ADDRESSES = {
  [CHAINS.ETHEREUM]: {
    STUDIO_NFT: "0x..." as `0x${string}`,
    MARKETPLACE: "0x..." as `0x${string}`,
  },
  [CHAINS.BASE]: {
    STUDIO_NFT: "0x..." as `0x${string}`,
    MARKETPLACE: "0x..." as `0x${string}`,
  },
} as const;

// WRONG: Lowercase constant, magic number
export const maxUint = 2n ** 256n - 1n;
export const slippage = 50;
```

## Contract ABIs in Separate Files

ABIs must be isolated in their own files, never inline in business logic.

```tsx
// CORRECT: ABI in dedicated file
// src/lib/abi/studio-nft.ts
export const STUDIO_NFT_ABI = [
  {
    type: "function",
    name: "mint",
    inputs: [
      { name: "to", type: "address" },
      { name: "uri", type: "string" },
    ],
    outputs: [{ name: "tokenId", type: "uint256" }],
    stateMutability: "nonpayable",
  },
  // ...
] as const;

// src/lib/contracts.ts — imports the ABI
import { STUDIO_NFT_ABI } from "./abi/studio-nft";

export function getStudioNFTContract(address: string, signer: Signer) {
  return new Contract(address, STUDIO_NFT_ABI, signer);
}

// WRONG: ABI inline in component or hook
const contract = new Contract(address, [
  "function mint(address to, string uri) returns (uint256)",
], signer); // Hard to maintain, no type safety
```

## Chain Config Centralized

All chain-specific configuration lives in `src/lib/chains.ts`.

```tsx
// src/lib/chains.ts
export interface ChainConfig {
  readonly id: ChainId;
  readonly name: string;
  readonly rpcUrl: string;
  readonly explorerUrl: string;
  readonly nativeCurrency: {
    readonly name: string;
    readonly symbol: string;
    readonly decimals: number;
  };
  readonly contracts: {
    readonly studioNFT: `0x${string}`;
    readonly marketplace: `0x${string}`;
  };
}

export const CHAIN_CONFIG: Readonly<Record<ChainId, ChainConfig>> = {
  [CHAINS.BASE]: {
    id: CHAINS.BASE,
    name: "Base",
    rpcUrl: "https://mainnet.base.org",
    explorerUrl: "https://basescan.org",
    nativeCurrency: { name: "Ether", symbol: "ETH", decimals: 18 },
    contracts: {
      studioNFT: "0x...",
      marketplace: "0x...",
    },
  },
  // ... other chains
} as const;

export function getExplorerTxUrl(chainId: ChainId, txHash: string): string {
  return `${CHAIN_CONFIG[chainId].explorerUrl}/tx/${txHash}`;
}
```
