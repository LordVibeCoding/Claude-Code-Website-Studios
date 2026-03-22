---
path:
  - "src/components/**"
---

# Component Code Standards

## TypeScript Props Interface

Every component MUST define a typed props interface. No `any` types allowed.

```tsx
// CORRECT: Explicit props interface
interface TokenCardProps {
  readonly address: string;
  readonly name: string;
  readonly symbol: string;
  readonly balance: bigint;
  readonly imageUrl?: string;
  readonly onSelect?: (address: string) => void;
}

export function TokenCard({
  address,
  name,
  symbol,
  balance,
  imageUrl,
  onSelect,
}: TokenCardProps) {
  return (/* ... */);
}

// WRONG: No types, inline object
export function TokenCard(props: any) {
  return (/* ... */);
}

// WRONG: Destructuring without type
export function TokenCard({ address, name }) {
  return (/* ... */);
}
```

## Export Rules

- **Default exports**: ONLY for page components (`page.tsx`, `layout.tsx`)
- **Named exports**: For ALL other components, hooks, utilities

```tsx
// src/components/token-card.tsx — CORRECT: named export
export function TokenCard(props: TokenCardProps) { /* ... */ }

// src/app/mint/page.tsx — CORRECT: default export for page
export default function MintPage() { /* ... */ }

// src/components/token-card.tsx — WRONG: default export for component
export default function TokenCard(props: TokenCardProps) { /* ... */ }
```

## forwardRef for Interactive Elements

All components that render interactive HTML elements (buttons, inputs, links) MUST use `forwardRef` to allow parent ref access.

```tsx
// CORRECT: forwardRef for interactive elements
import { forwardRef } from "react";

interface WalletButtonProps {
  readonly variant?: "primary" | "outline";
  readonly size?: "sm" | "md" | "lg";
  readonly children: React.ReactNode;
}

export const WalletButton = forwardRef<HTMLButtonElement, WalletButtonProps>(
  function WalletButton({ variant = "primary", size = "md", children, ...rest }, ref) {
    return (
      <button
        ref={ref}
        className={cn(buttonVariants({ variant, size }))}
        {...rest}
      >
        {children}
      </button>
    );
  }
);

// WRONG: No ref forwarding
export function WalletButton({ children }: WalletButtonProps) {
  return <button>{children}</button>;
}
```

## React.memo for Expensive Renders

Use `memo` for components that:
- Render large lists or complex subtrees
- Receive stable props but re-render due to parent updates
- Perform expensive computations in render

```tsx
// CORRECT: Memoized list item
import { memo } from "react";

interface NFTGridItemProps {
  readonly tokenId: number;
  readonly metadata: NFTMetadata;
  readonly onSelect: (id: number) => void;
}

export const NFTGridItem = memo(function NFTGridItem({
  tokenId,
  metadata,
  onSelect,
}: NFTGridItemProps) {
  return (
    <div onClick={() => onSelect(tokenId)}>
      <img src={metadata.image} alt={metadata.name} />
      <span>{metadata.name}</span>
    </div>
  );
});

// When NOT to use memo: simple components, frequently changing props
```

## No Inline Styles

Use Tailwind CSS exclusively. No `style={{}}` props.

```tsx
// CORRECT: Tailwind
<div className="flex items-center gap-4 rounded-xl bg-gray-900 p-6">
  <span className="text-sm font-medium text-gray-400">{label}</span>
</div>

// WRONG: Inline styles
<div style={{ display: "flex", alignItems: "center", gap: 16, padding: 24 }}>
  <span style={{ fontSize: 14, color: "#9ca3af" }}>{label}</span>
</div>

// WRONG: CSS modules (use Tailwind instead in this project)
<div className={styles.container}>
```

## Key Props in Lists

Every list rendering MUST use stable, unique keys. NEVER use array index as key.

```tsx
// CORRECT: Unique, stable key
{tokens.map((token) => (
  <TokenCard key={token.address} {...token} />
))}

// CORRECT: Composite key when needed
{positions.map((pos) => (
  <PositionRow key={`${pos.poolAddress}-${pos.tokenId}`} position={pos} />
))}

// WRONG: Index as key
{tokens.map((token, index) => (
  <TokenCard key={index} {...token} />
))}

// WRONG: No key
{tokens.map((token) => (
  <TokenCard {...token} />
))}
```

## Component File Structure

Each component file should follow this order:

```tsx
// 1. Imports
import { memo, forwardRef } from "react";
import { cn } from "@/lib/utils";

// 2. Types / Interfaces
interface ComponentProps {
  readonly prop: string;
}

// 3. Constants (component-specific)
const VARIANTS = { /* ... */ } as const;

// 4. Component definition
export function Component({ prop }: ComponentProps) {
  // a. Hooks
  // b. Derived state
  // c. Handlers
  // d. Render
  return (/* ... */);
}

// 5. Sub-components (if small, otherwise separate file)
function SubComponent() { /* ... */ }
```
