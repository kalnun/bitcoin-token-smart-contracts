pragma solidity 0.4.24;


import "../utils/OwnableContract.sol";
import "../utils/IndexedMapping.sol";
import "../utils/OwnableContractOwner.sol";
import "../factory/MembersInterface.sol";


contract Members is MembersInterface, OwnableContract {

    using IndexedMapping for IndexedMapping.indexedMapping;

    IndexedMapping.indexedMapping internal custodians;
    IndexedMapping.indexedMapping internal merchants;

    event CustodianAdd(address custodian);

    function addCustodian(address custodian) external onlyOwner {
        require(custodian != address(0), "invalid custodian address");
        require(custodians.add(custodian), "custodian add failed"); 

        emit CustodianAdd(custodian);
    }

    event CustodianRemove(address custodian);

    function removeCustodian(address custodian) external onlyOwner {
        require(custodian != address(0), "invalid custodian address");
        require(custodians.remove(custodian), "custodian remove failed");

        emit CustodianRemove(custodian);
    }

    event MerchantAdd(address merchant);

    function addMerchant(address merchant) external onlyOwner {
        require(merchant != address(0), "invalid merchant address");
        require(merchants.add(merchant), "merchant add failed");

        emit MerchantAdd(merchant);
    } 

    event MerchantRemove(address custodian);

    function removeMerchant(address merchant) external onlyOwner {
        require(merchant != address(0), "invalid merchant address");
        require(merchants.remove(merchant), "merchant remove failed");

        emit MerchantRemove(merchant);
    }

    function isCustodian(address addr) external view returns(bool) {
        return custodians.exists(addr);
    }

    function isMerchant(address addr) external view returns(bool) {
        return merchants.exists(addr);
    }

    function getMerchant(uint index) public view returns (address) {
        return merchants.getValue(index);
    }

    function getMerchants() public view returns (address[]) {
        return merchants.getValueList();
    }

    function getCustodian(uint index) public view returns (address) {
        return custodians.getValue(index);
    }

    function getCustodians() public view returns (address[]) {
        return custodians.getValueList();
    }
}