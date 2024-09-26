// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {VennFirewallConsumer} from "@ironblocks/firewall-consumer/contracts/consumers/VennFirewallConsumer.sol";
import "@openzeppelin-upgradeable/contracts/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin-upgradeable/contracts/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin-upgradeable/contracts/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/utils/Context.sol";

import "./interfaces/IEtherFiNodesManager.sol";


contract TNFT is VennFirewallConsumer, ERC721Upgradeable, UUPSUpgradeable, OwnableUpgradeable {
    //--------------------------------------------------------------------------------------
    //---------------------------------  STATE-VARIABLES  ----------------------------------
    //--------------------------------------------------------------------------------------
    address public stakingManagerAddress;
    address public etherFiNodesManagerAddress;

    //--------------------------------------------------------------------------------------
    //----------------------------  STATE-CHANGING FUNCTIONS  ------------------------------
    //--------------------------------------------------------------------------------------

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    /// @notice initialize to set variables on deployment
    function initialize(address _stakingManagerAddress) initializer external firewallProtected {
        require(_stakingManagerAddress != address(0), "No zero addresses");
        
        __ERC721_init("Transferrable NFT", "TNFT");
        __Ownable_init();
        __UUPSUpgradeable_init();

        stakingManagerAddress = _stakingManagerAddress;
    
		_setAddressBySlot(bytes32(uint256(keccak256("eip1967.firewall")) - 1), address(0));
		_setAddressBySlot(bytes32(uint256(keccak256("eip1967.firewall.admin")) - 1), msg.sender);
	}

    /// @notice initialization function that should be called after phase 2.0 contract upgrade
    function initializeOnUpgrade(address _etherFiNodesManagerAddress) onlyOwner external firewallProtected {
        require(_etherFiNodesManagerAddress != address(0), "Cannot initialize to zero address");

        etherFiNodesManagerAddress = _etherFiNodesManagerAddress;
    }

    /// @notice Mints NFT to required user
    /// @dev Only through the staking contract and not by an EOA
    /// @param _receiver Receiver of the NFT
    /// @param _validatorId The ID of the NFT
    function mint(address _receiver, uint256 _validatorId) external onlyStakingManager firewallProtected {
        _mint(_receiver, _validatorId);
    }

    /// @notice burn the associated tNFT when a full withdrawal is processed
    function burnFromWithdrawal(uint256 _validatorId) external onlyEtherFiNodesManager firewallProtected {
        _burn(_validatorId);
    }

        /// @notice burn the associated one
    function burnFromCancelBNftFlow(uint256 _validatorId) external onlyStakingManager firewallProtected {
        _burn(_validatorId);
    }

    function _transfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override {
        uint256 numAssociatedValidators = IEtherFiNodesManager(etherFiNodesManagerAddress).numAssociatedValidators(tokenId);
        require(numAssociatedValidators == 1, "numAssociatedValidators != 1");

        super._transfer(from, to, tokenId);
    }

    //--------------------------------------------------------------------------------------
    //-------------------------------  INTERNAL FUNCTIONS   --------------------------------
    //--------------------------------------------------------------------------------------

    function _authorizeUpgrade(
        address newImplementation
    ) internal override onlyOwner {}

    //--------------------------------------------------------------------------------------
    //--------------------------------------  GETTER  --------------------------------------
    //--------------------------------------------------------------------------------------

    /// @notice Fetches the address of the implementation contract currently being used by the proxy
    /// @return the address of the currently used implementation contract
    function getImplementation() external view returns (address) {
        return _getImplementation();
    }

    //--------------------------------------------------------------------------------------
    //------------------------------------  MODIFIERS  -------------------------------------
    //--------------------------------------------------------------------------------------

    modifier onlyStakingManager() {
        require(msg.sender == stakingManagerAddress, "Only staking manager contract");
        _;
    }

    modifier onlyEtherFiNodesManager() {
        require(msg.sender == etherFiNodesManagerAddress, "Only etherFiNodesManager contract");
        _;
    }

    function _msgData() internal view virtual override(Context, ContextUpgradeable) returns (bytes calldata) {
        return super._msgData();
    }

    function _msgSender() internal view virtual override(Context, ContextUpgradeable) returns (address) {
        return super._msgSender();
    }
}
