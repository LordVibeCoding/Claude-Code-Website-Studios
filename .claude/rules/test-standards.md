---
path:
  - "tests/**"
---

# Test Standards

## File Naming

Test files MUST follow the naming convention and mirror the source structure.

```
src/lib/format.ts         →  tests/lib/format.test.ts
src/hooks/useWallet.ts    →  tests/hooks/useWallet.test.ts
src/components/TokenCard.tsx → tests/components/TokenCard.test.tsx
src/contracts/StudioNFT.sol  → tests/contracts/StudioNFT.test.ts
```

Allowed suffixes: `.test.ts`, `.test.tsx`, `.spec.ts`, `.spec.tsx`

```
# CORRECT
token-card.test.tsx
useWallet.test.ts
StudioNFT.spec.ts

# WRONG
token-card-tests.ts       # Wrong suffix
testTokenCard.ts          # Wrong prefix style
token_card.test.ts        # Wrong case (match source file)
```

## Describe Blocks for Grouping

Use `describe` blocks to organize tests by function/feature, and nested `describe` for sub-scenarios.

```tsx
// CORRECT: Clear grouping
describe("formatTokenAmount", () => {
  describe("with standard decimals (18)", () => {
    it("formats zero correctly", () => {
      expect(formatTokenAmount(0n, 18)).toBe("0.0000");
    });

    it("formats whole numbers", () => {
      expect(formatTokenAmount(1000000000000000000n, 18)).toBe("1.0000");
    });

    it("formats fractional amounts", () => {
      expect(formatTokenAmount(1500000000000000000n, 18)).toBe("1.5000");
    });
  });

  describe("with USDC decimals (6)", () => {
    it("formats correctly", () => {
      expect(formatTokenAmount(1000000n, 6)).toBe("1.0000");
    });
  });

  describe("edge cases", () => {
    it("handles max uint256", () => {
      expect(() => formatTokenAmount(MAX_UINT256, 18)).not.toThrow();
    });

    it("handles zero decimals", () => {
      expect(formatTokenAmount(42n, 0)).toBe("42.");
    });
  });
});

// WRONG: Flat, unorganized tests
test("format 1", () => { /* ... */ });
test("format 2", () => { /* ... */ });
test("format 3", () => { /* ... */ });
```

## Meaningful Test Names

Test names should describe the expected behavior, not the implementation.

```tsx
// CORRECT: Behavior-focused names
it("returns truncated address with first 6 and last 4 characters", () => {});
it("throws when address is not checksummed", () => {});
it("connects wallet and updates status to connected", () => {});
it("shows error message when transaction is reverted", () => {});

// WRONG: Implementation-focused or vague names
it("test 1", () => {});
it("works", () => {});
it("calls the function", () => {});
it("should truncateAddress", () => {}); // Repeats function name
```

## No Test Interdependence

Each test MUST be fully independent. No shared mutable state between tests.

```tsx
// CORRECT: Each test sets up its own state
describe("TokenList", () => {
  it("renders empty state when no tokens", () => {
    render(<TokenList tokens={[]} />);
    expect(screen.getByText("No tokens found")).toBeInTheDocument();
  });

  it("renders all tokens", () => {
    const tokens = [mockToken("ETH"), mockToken("USDC")];
    render(<TokenList tokens={tokens} />);
    expect(screen.getAllByRole("listitem")).toHaveLength(2);
  });
});

// WRONG: Tests depend on shared state
let tokens: Token[] = [];

beforeEach(() => {
  tokens.push(mockToken("ETH")); // Accumulates across tests!
});

it("has 1 token", () => {
  expect(tokens).toHaveLength(1); // Passes
});

it("has 1 token", () => {
  expect(tokens).toHaveLength(1); // FAILS — has 2!
});
```

## Mock Web3 Providers

Use dedicated mocks for Web3 providers. Never connect to real networks in tests.

```tsx
// CORRECT: Mock provider setup
import { MockProvider } from "./helpers/mock-provider";

function createMockProvider(overrides?: Partial<ProviderConfig>) {
  return new MockProvider({
    chainId: 8453,
    blockNumber: 1000,
    balance: parseEther("10"),
    ...overrides,
  });
}

describe("useBalance", () => {
  it("returns the wallet balance", async () => {
    const provider = createMockProvider({ balance: parseEther("5.5") });

    const { result } = renderHook(
      () => useBalance("0x1234..."),
      { wrapper: createWrapper(provider) },
    );

    await waitFor(() => {
      expect(result.current.data).toBe(parseEther("5.5"));
    });
  });

  it("handles RPC errors gracefully", async () => {
    const provider = createMockProvider();
    provider.simulateError("eth_getBalance", new Error("RPC unavailable"));

    const { result } = renderHook(
      () => useBalance("0x1234..."),
      { wrapper: createWrapper(provider) },
    );

    await waitFor(() => {
      expect(result.current.error).toBeDefined();
      expect(result.current.data).toBeUndefined();
    });
  });
});
```

## Test Wallet Connection Flows

Wallet connection is a critical path — test all states.

```tsx
describe("WalletConnector", () => {
  it("shows connect button when disconnected", () => {
    render(<WalletConnector />, {
      wrapper: createWrapper({ status: "disconnected" }),
    });
    expect(screen.getByRole("button", { name: /connect/i })).toBeInTheDocument();
  });

  it("shows loading spinner during connection", () => {
    render(<WalletConnector />, {
      wrapper: createWrapper({ status: "connecting" }),
    });
    expect(screen.getByRole("status")).toBeInTheDocument();
  });

  it("displays truncated address when connected", () => {
    render(<WalletConnector />, {
      wrapper: createWrapper({
        status: "connected",
        address: "0x1234567890abcdef1234567890abcdef12345678",
      }),
    });
    expect(screen.getByText("0x1234...5678")).toBeInTheDocument();
  });

  it("shows error state with retry button", () => {
    render(<WalletConnector />, {
      wrapper: createWrapper({
        status: "error",
        error: new Error("User rejected"),
      }),
    });
    expect(screen.getByText(/rejected/i)).toBeInTheDocument();
    expect(screen.getByRole("button", { name: /retry/i })).toBeInTheDocument();
  });

  it("handles chain switching", async () => {
    const switchChain = vi.fn();
    render(<WalletConnector />, {
      wrapper: createWrapper({ status: "connected", chainId: 1, switchChain }),
    });

    await userEvent.click(screen.getByRole("button", { name: /switch.*base/i }));
    expect(switchChain).toHaveBeenCalledWith(8453);
  });
});
```

## Contract Interaction Tests

Contract tests use the Hardhat network for deterministic, fast execution.

```tsx
import { ethers } from "hardhat";
import { expect } from "chai";
import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";

describe("StudioNFT", () => {
  async function deployFixture() {
    const [owner, minter, user] = await ethers.getSigners();
    const StudioNFT = await ethers.getContractFactory("StudioNFT");
    const nft = await StudioNFT.deploy(owner.address);

    // Grant minter role
    const MINTER_ROLE = await nft.MINTER_ROLE();
    await nft.grantRole(MINTER_ROLE, minter.address);

    return { nft, owner, minter, user, MINTER_ROLE };
  }

  describe("Minting", () => {
    it("mints token with correct URI", async () => {
      const { nft, minter, user } = await loadFixture(deployFixture);
      const uri = "ipfs://QmTest123";

      await expect(nft.connect(minter).mint(user.address, uri))
        .to.emit(nft, "TokenMinted")
        .withArgs(user.address, 0, uri);

      expect(await nft.tokenURI(0)).to.equal(uri);
      expect(await nft.ownerOf(0)).to.equal(user.address);
    });

    it("reverts when caller lacks MINTER_ROLE", async () => {
      const { nft, user } = await loadFixture(deployFixture);

      await expect(
        nft.connect(user).mint(user.address, "ipfs://test"),
      ).to.be.revertedWithCustomError(nft, "AccessControlUnauthorizedAccount");
    });
  });

  describe("Gas Usage", () => {
    it("single mint costs less than 120k gas", async () => {
      const { nft, minter, user } = await loadFixture(deployFixture);
      const tx = await nft.connect(minter).mint(user.address, "ipfs://test");
      const receipt = await tx.wait();
      expect(receipt!.gasUsed).to.be.lessThan(120_000);
    });
  });
});
```
