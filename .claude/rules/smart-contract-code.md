---
path:
  - "src/contracts/**"
---

# Smart Contract Code Standards

## Solidity Version

All contracts MUST use Solidity 0.8.x (with overflow checks built-in). Pin the exact version.

```solidity
// CORRECT
pragma solidity 0.8.24;

// WRONG: floating version
pragma solidity ^0.8.0;

// WRONG: old version without overflow protection
pragma solidity 0.7.6;
```

## OpenZeppelin Usage

Use OpenZeppelin contracts as the foundation. Never reimplement standard patterns.

```solidity
// CORRECT: Use battle-tested implementations
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import {Pausable} from "@openzeppelin/contracts/utils/Pausable.sol";

contract StudioNFT is ERC721, Ownable, ReentrancyGuard, Pausable {
    // ...
}

// WRONG: Hand-rolling ERC721
contract StudioNFT {
    mapping(uint256 => address) private _owners;
    // Don't do this — use OpenZeppelin
}
```

## Reentrancy Guards

ALL functions that make external calls MUST use the `nonReentrant` modifier.

```solidity
// CORRECT
function withdraw() external nonReentrant {
    uint256 balance = balances[msg.sender];
    balances[msg.sender] = 0;           // Effects before interactions
    (bool ok, ) = msg.sender.call{value: balance}("");
    require(ok, "Transfer failed");
}

// WRONG: No reentrancy protection
function withdraw() external {
    uint256 balance = balances[msg.sender];
    (bool ok, ) = msg.sender.call{value: balance}("");
    require(ok, "Transfer failed");
    balances[msg.sender] = 0;           // State change AFTER external call
}
```

## Access Control

Every admin/privileged function MUST have access control. Prefer role-based access over single owner.

```solidity
import {AccessControl} from "@openzeppelin/contracts/access/AccessControl.sol";

contract StudioMarketplace is AccessControl {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR_ROLE");

    // CORRECT: Role-gated function
    function setFeeRate(uint256 newRate) external onlyRole(ADMIN_ROLE) {
        require(newRate <= MAX_FEE_RATE, "Fee too high");
        feeRate = newRate;
        emit FeeRateUpdated(newRate);
    }

    // WRONG: No access control
    function setFeeRate(uint256 newRate) external {
        feeRate = newRate;
    }
}
```

## Events for All State Changes

Every function that modifies state MUST emit an event. Events are the primary indexing mechanism for frontends.

```solidity
// CORRECT: Events defined and emitted
event TokenMinted(address indexed to, uint256 indexed tokenId, string uri);
event PriceUpdated(uint256 indexed tokenId, uint256 oldPrice, uint256 newPrice);
event RoyaltySet(address indexed receiver, uint96 feeNumerator);

function mint(address to, string calldata uri) external onlyRole(MINTER_ROLE) {
    uint256 tokenId = _nextTokenId++;
    _safeMint(to, tokenId);
    _setTokenURI(tokenId, uri);
    emit TokenMinted(to, tokenId, uri);
}

// WRONG: State change without event
function mint(address to, string calldata uri) external {
    _safeMint(to, _nextTokenId++);
}
```

## Gas Optimization

### Struct Packing

```solidity
// CORRECT: Packed struct (1 storage slot = 32 bytes)
struct Listing {
    address seller;     // 20 bytes
    uint64 price;       // 8 bytes
    uint32 expiry;      // 4 bytes
}                       // Total: 32 bytes = 1 slot

// WRONG: Wasted storage slots
struct Listing {
    uint256 price;      // 32 bytes = 1 slot
    address seller;     // 20 bytes = 1 slot (wastes 12 bytes)
    uint256 expiry;     // 32 bytes = 1 slot
}                       // Total: 3 slots
```

### Use `calldata` for Read-Only Parameters

```solidity
// CORRECT: calldata for read-only arrays/strings
function batchMint(address[] calldata recipients, string[] calldata uris)
    external
    onlyRole(MINTER_ROLE)
{
    // ...
}

// WRONG: memory copies the entire array
function batchMint(address[] memory recipients, string[] memory uris) external {
    // ...
}
```

### Use Custom Errors

```solidity
// CORRECT: Custom errors (cheaper than require strings)
error InsufficientPayment(uint256 required, uint256 provided);
error TokenNotListed(uint256 tokenId);
error Unauthorized(address caller);

function buy(uint256 tokenId) external payable {
    Listing storage listing = listings[tokenId];
    if (listing.seller == address(0)) revert TokenNotListed(tokenId);
    if (msg.value < listing.price) {
        revert InsufficientPayment(listing.price, msg.value);
    }
}

// WRONG: String error messages (expensive)
function buy(uint256 tokenId) external payable {
    require(listings[tokenId].seller != address(0), "Token not listed");
    require(msg.value >= listings[tokenId].price, "Insufficient payment");
}
```

## NatSpec Documentation

ALL public and external functions MUST have NatSpec documentation.

```solidity
/// @title Studio NFT Collection
/// @author Web3 Website Studios
/// @notice ERC-721 NFT contract with role-based minting and royalties
/// @dev Implements ERC-2981 for on-chain royalty info
contract StudioNFT is ERC721, ERC2981, AccessControl, ReentrancyGuard {

    /// @notice Mint a new token to the specified address
    /// @dev Caller must have MINTER_ROLE. Token ID auto-increments.
    /// @param to The recipient address
    /// @param uri The metadata URI for the token
    /// @return tokenId The ID of the newly minted token
    function mint(address to, string calldata uri)
        external
        onlyRole(MINTER_ROLE)
        returns (uint256 tokenId)
    {
        tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        emit TokenMinted(to, tokenId, uri);
    }
}
```

## Prohibited Patterns

```solidity
// NEVER use selfdestruct
selfdestruct(payable(owner)); // FORBIDDEN

// NEVER use delegatecall to untrusted addresses
address(untrusted).delegatecall(data); // FORBIDDEN

// NEVER use tx.origin for authorization
require(tx.origin == owner); // FORBIDDEN — use msg.sender

// NEVER use block.timestamp for critical randomness
uint256 random = uint256(blockhash(block.number)); // FORBIDDEN
```

## Checks-Effects-Interactions Pattern

ALWAYS follow this order in every function:

```solidity
function purchase(uint256 tokenId) external payable nonReentrant {
    // 1. CHECKS — validate all conditions
    Listing storage listing = listings[tokenId];
    if (listing.seller == address(0)) revert TokenNotListed(tokenId);
    if (msg.value < listing.price) {
        revert InsufficientPayment(listing.price, msg.value);
    }

    // 2. EFFECTS — update state
    address seller = listing.seller;
    uint256 price = listing.price;
    delete listings[tokenId];

    // 3. INTERACTIONS — external calls LAST
    _transfer(seller, msg.sender, tokenId);
    (bool ok, ) = seller.call{value: price}("");
    if (!ok) revert TransferFailed();

    emit TokenPurchased(tokenId, seller, msg.sender, price);
}
```
