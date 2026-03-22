---
path:
  - "src/hooks/**"
---

# Custom Hooks Standards

## Naming Convention

All custom hooks MUST start with `use`. The name should describe what the hook provides, not how it works.

```tsx
// CORRECT: Descriptive "use" prefix
export function useWalletBalance(address: string | undefined) { /* ... */ }
export function useTokenPrice(symbol: string) { /* ... */ }
export function useContractRead<T>(config: ContractReadConfig) { /* ... */ }

// WRONG: Missing "use" prefix
export function getWalletBalance(address: string) { /* ... */ }
export function fetchTokenPrice(symbol: string) { /* ... */ }

// WRONG: Implementation-focused name
export function useEthersCall(config: Config) { /* ... */ } // What does it DO?
```

## Proper Cleanup in useEffect

Every `useEffect` with subscriptions, timers, or event listeners MUST return a cleanup function.

```tsx
// CORRECT: Full cleanup
export function useBlockNumber() {
  const [blockNumber, setBlockNumber] = useState<number>();
  const { provider } = useProvider();

  useEffect(() => {
    if (!provider) return;

    const handleBlock = (num: number) => setBlockNumber(num);
    provider.on("block", handleBlock);

    // Cleanup: remove listener
    return () => {
      provider.off("block", handleBlock);
    };
  }, [provider]);

  return blockNumber;
}

// CORRECT: Timer cleanup
export function usePolledPrice(tokenAddress: string, intervalMs = 30_000) {
  const [price, setPrice] = useState<number>();

  useEffect(() => {
    let cancelled = false;

    const poll = async () => {
      const p = await fetchPrice(tokenAddress);
      if (!cancelled) setPrice(p);
    };

    poll(); // Initial fetch
    const id = setInterval(poll, intervalMs);

    return () => {
      cancelled = true;
      clearInterval(id);
    };
  }, [tokenAddress, intervalMs]);

  return price;
}

// WRONG: No cleanup — memory leak
export function useBlockNumber() {
  const { provider } = useProvider();

  useEffect(() => {
    provider?.on("block", (num) => setBlockNumber(num));
    // Missing cleanup!
  }, [provider]);
}
```

## No Side Effects in Render

Hooks must not trigger side effects during the render phase. All side effects go in `useEffect` or event handlers.

```tsx
// CORRECT: Side effect in useEffect
export function useTokenMetadata(tokenId: number) {
  const [metadata, setMetadata] = useState<TokenMetadata>();

  useEffect(() => {
    let cancelled = false;

    fetchMetadata(tokenId).then((data) => {
      if (!cancelled) setMetadata(data);
    });

    return () => { cancelled = true; };
  }, [tokenId]);

  return metadata;
}

// WRONG: Side effect during render
export function useTokenMetadata(tokenId: number) {
  const [metadata, setMetadata] = useState<TokenMetadata>();

  // This fires during render — BAD!
  fetchMetadata(tokenId).then(setMetadata);

  return metadata;
}
```

## Memoize Expensive Computations

Use `useMemo` for derived data that is expensive to compute.

```tsx
// CORRECT: Memoized expensive computation
export function useFilteredTokens(
  tokens: readonly Token[],
  query: string,
  chainId: number,
) {
  const filtered = useMemo(() => {
    return tokens
      .filter((t) => t.chainId === chainId)
      .filter((t) =>
        t.name.toLowerCase().includes(query.toLowerCase()) ||
        t.symbol.toLowerCase().includes(query.toLowerCase()) ||
        t.address.toLowerCase() === query.toLowerCase()
      )
      .sort((a, b) => Number(b.balance - a.balance));
  }, [tokens, query, chainId]);

  return filtered;
}

// WRONG: Recomputes on every render
export function useFilteredTokens(tokens: Token[], query: string, chainId: number) {
  // No memoization — recalculates even when inputs haven't changed
  const filtered = tokens.filter(/* ... */).sort(/* ... */);
  return filtered;
}
```

## Proper Dependency Arrays

Include ALL reactive values in dependency arrays. Never suppress the exhaustive-deps lint.

```tsx
// CORRECT: Complete dependencies
export function useContractEvent(
  contract: Contract | undefined,
  eventName: string,
  handler: (args: unknown[]) => void,
) {
  // Stabilize handler reference
  const handlerRef = useRef(handler);
  handlerRef.current = handler;

  useEffect(() => {
    if (!contract) return;

    const listener = (...args: unknown[]) => handlerRef.current(args);
    contract.on(eventName, listener);

    return () => {
      contract.off(eventName, listener);
    };
  }, [contract, eventName]); // handlerRef is stable, no need to include
}

// WRONG: Missing dependency
useEffect(() => {
  fetchBalance(address); // `address` not in deps!
}, []); // eslint-disable-line react-hooks/exhaustive-deps  <-- NEVER DO THIS

// WRONG: Object/function in deps causing infinite loops
useEffect(() => {
  // This runs every render because `options` is a new object each time
}, [options]); // Wrap in useMemo or extract stable values
```

## AbortController for Async Operations

All async hooks MUST use AbortController to cancel in-flight requests on cleanup.

```tsx
// CORRECT: AbortController for fetch cancellation
export function useTokenBalances(address: string | undefined) {
  const [balances, setBalances] = useState<TokenBalance[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<Error>();

  useEffect(() => {
    if (!address) {
      setBalances([]);
      return;
    }

    const controller = new AbortController();
    setLoading(true);
    setError(undefined);

    fetchBalances(address, { signal: controller.signal })
      .then((data) => {
        if (!controller.signal.aborted) {
          setBalances(data);
        }
      })
      .catch((err) => {
        if (!controller.signal.aborted) {
          setError(err);
        }
      })
      .finally(() => {
        if (!controller.signal.aborted) {
          setLoading(false);
        }
      });

    return () => controller.abort();
  }, [address]);

  return { balances, loading, error } as const;
}
```

## Return Type Pattern

Hooks should return a consistent shape — either a single value, a tuple, or a readonly object.

```tsx
// Object return — preferred for hooks with multiple values
export function useWallet() {
  // ...
  return { address, chainId, status, connect, disconnect } as const;
}

// Tuple return — for simple state + setter pairs
export function useToggle(initial = false) {
  const [value, setValue] = useState(initial);
  const toggle = useCallback(() => setValue((v) => !v), []);
  return [value, toggle] as const;
}
```
