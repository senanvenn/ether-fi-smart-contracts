
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract NativeMintingConfigs {
    struct ConfigPerL2 {
        string name;
        string rpc_url;
        uint32 l2Eid;
        address l2Oft;
        address l2SyncPool;
        address l2SyncPoolRateLimiter;
        address l2ExchagneRateProvider;
        address l2PriceOracle;
        address l2ContractControllerSafe;

        address l1dummyToken;
        address l1Receiver;

        // ProxyAdmin
        address l2Oft_ProxyAdmin;
        address l2SyncPool_ProxyAdmin;
        address l2ExchagneRateProvider_ProxyAdmin;
        address l1dummyToken_ProxyAdmin;
        address l1Receiver_ProxyAdmin;
    }

    string l1RpcUrl = "https://mainnet.gateway.tenderly.co";
    uint32 l1Eid = 30101;
    address l1Endpoint = 0x1a44076050125825900e736c501f859c50fE728c;
    address ETH_ADDRESS = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    address l1SyncPoolAddress = 0xD789870beA40D056A4d26055d0bEFcC8755DA146;
    address l1OftAdapter = 0xFE7fe01F8B9A76803aF3750144C2715D9bcf7D0D;

    ConfigPerL2 BLAST = ConfigPerL2({
        name: "BLAST",
        rpc_url: "https://rpc.blast.io",
        l2Eid: 30243,
        l2Oft: 0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A,
        l2SyncPool: 0x52c4221Cb805479954CDE5accfF8C4DcaF96623B,
        l2SyncPoolRateLimiter: 0x6f257089bF046a02751b60767871953F3899652e,
        l2ExchagneRateProvider: 0xc42853c0C6624F42fcB8219aCeb67Ad188087DCB,
        l2PriceOracle: 0xcD96262Df56127f298b452FA40759632868A472a,
        l2ContractControllerSafe: 0xa4822d7d24747e6A1BAA171944585bad4434f2D5,
        l1dummyToken: 0x83998e169026136760bE6AF93e776C2F352D4b28,
        l1Receiver: 0x27e120C518a339c3d8b665E56c4503DF785985c2,

        l2Oft_ProxyAdmin: 0x2F6f3cc4a275C7951FB79199F01eD82421eDFb68,
        l2SyncPool_ProxyAdmin: 0x8f732e00d6CF2302775Df16d4110f0f7ad3780f9,
        l2ExchagneRateProvider_ProxyAdmin: 0xb4224E552016ba5D35b44608Cd4578fF7FCB6e82,
        l1dummyToken_ProxyAdmin: 0x96a226ad7c14870502f9794fB481EE102E595fFa,
        l1Receiver_ProxyAdmin: 0x70F38913d95987829577788dF9a6A0741dA16543
    });

    ConfigPerL2 LINEA = ConfigPerL2({
        name: "LINEA",
        rpc_url: "https://1rpc.io/linea",
        l2Eid: 30183,
        l2Oft: 0x1Bf74C010E6320bab11e2e5A532b5AC15e0b8aA6,
        l2SyncPool: 0x823106E745A62D0C2FC4d27644c62aDE946D9CCa,
        l2SyncPoolRateLimiter: 0x3A19866D5E0fAE0Ce19Adda617f9d2B9fD5a3975,
        l2ExchagneRateProvider: 0x241a91F095B2020890Bc8518bea168C195518344,
        l2PriceOracle: address(0),
        l2ContractControllerSafe: address(0),
        l1dummyToken: 0x61Ff310aC15a517A846DA08ac9f9abf2A0f9A2bf,
        l1Receiver: 0x6F149F8bf1CB0245e70171c9972059C22294aa35,
        
        l2Oft_ProxyAdmin: address(0),
        l2SyncPool_ProxyAdmin: address(0),
        l2ExchagneRateProvider_ProxyAdmin: address(0),
        l1dummyToken_ProxyAdmin: address(0),
        l1Receiver_ProxyAdmin: address(0)
    });

    ConfigPerL2 MODE = ConfigPerL2({
        name: "MODE",
        rpc_url: "https://mainnet.mode.network",
        l2Eid: 30260,
        l2Oft: 0x04C0599Ae5A44757c0af6F9eC3b93da8976c150A,
        l2SyncPool: 0x52c4221Cb805479954CDE5accfF8C4DcaF96623B,
        l2SyncPoolRateLimiter: 0x95F1138837F1158726003251B32ecd8732c76781,
        l2ExchagneRateProvider: 0xc42853c0C6624F42fcB8219aCeb67Ad188087DCB,
        l2ContractControllerSafe: 0xa4822d7d24747e6A1BAA171944585bad4434f2D5,
        l2PriceOracle: address(0),
        l1dummyToken: 0xDc400f3da3ea5Df0B7B6C127aE2e54CE55644CF3,
        l1Receiver: 0xC8Ad0949f33F02730cFf3b96E7F067E83De1696f,

        l2Oft_ProxyAdmin: 0x2F6f3cc4a275C7951FB79199F01eD82421eDFb68,
        l2SyncPool_ProxyAdmin: 0x8f732e00d6CF2302775Df16d4110f0f7ad3780f9,
        l2ExchagneRateProvider_ProxyAdmin: 0xb4224E552016ba5D35b44608Cd4578fF7FCB6e82,
        l1dummyToken_ProxyAdmin: address(0),
        l1Receiver_ProxyAdmin: address(0)
    });

    ConfigPerL2[] l2s;

    function _init() public {
        l2s.push(BLAST);
        l2s.push(LINEA);
        l2s.push(MODE);
    }

    function _toBytes32(address addr) internal pure returns (bytes32) {
        return bytes32(uint256(uint160(addr)));
    }
}