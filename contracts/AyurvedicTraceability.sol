// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract AyurvedicTraceability {
    uint public batchCounter;
    uint public productCounter;

    struct Batch {
        uint id;             // numeric ID
        string batchId;      // external ID like BATCH-XXXX
        bytes32 batchHash;   // SHA256/Keccak256 hash of all herb + metadata
        uint timestamp;
        address processor;
    }

    struct Product {
        uint id;
        uint batchIdNum;     // link to numeric batchCounter
        string formulationDetails;
        uint timestamp;
        address packager;
    }

    mapping(uint => Batch) public batches;
    mapping(uint => Product) public products;

    event BatchCreated(uint id, string batchId, bytes32 batchHash);
    event ProductLabeled(uint id, uint batchIdNum, string formulationDetails);

    // -----------------
    //  Write Functions
    // -----------------
    function createBatch(string memory _batchId, bytes32 _batchHash) public {
        batchCounter++;
        batches[batchCounter] = Batch(batchCounter, _batchId, _batchHash, block.timestamp, msg.sender);
        emit BatchCreated(batchCounter, _batchId, _batchHash);
    }

    function labelProduct(uint _batchIdNum, string memory _formulationDetails) public {
        require(_batchIdNum > 0 && _batchIdNum <= batchCounter, "Invalid batch ID");
        productCounter++;
        products[productCounter] = Product(productCounter, _batchIdNum, _formulationDetails, block.timestamp, msg.sender);
        emit ProductLabeled(productCounter, _batchIdNum, _formulationDetails);
    }

    // -----------------
    //  Read Functions
    // -----------------
    function getBatch(uint _id) public view returns (Batch memory) {
        require(_id > 0 && _id <= batchCounter, "Batch does not exist");
        return batches[_id];
    }

    function getProduct(uint _id) public view returns (Product memory) {
        require(_id > 0 && _id <= productCounter, "Product does not exist");
        return products[_id];
    }
}
