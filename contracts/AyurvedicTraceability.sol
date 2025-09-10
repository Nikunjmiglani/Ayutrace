// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract AyurvedicTraceability {
    uint public herbCounter;
    uint public batchCounter;
    uint public productCounter;

    struct Herb {
        uint id;
        string name;
        string geoLocation;
        uint timestamp;
        address collector;
    }

    struct Batch {
        uint id;
        uint[] herbIds;
        string processDetails;
        uint timestamp;
        address processor;
    }

    struct Product {
        uint id;
        uint batchId;
        string formulationDetails;
        uint timestamp;
        address packager;
    }

    mapping(uint => Herb) public herbs;
    mapping(uint => Batch) public batches;
    mapping(uint => Product) public products;

    event HerbCollected(uint id, string name, string geoLocation, address collector);
    event BatchCreated(uint id, uint[] herbIds, string processDetails);
    event ProductLabeled(uint id, uint batchId, string formulationDetails);

    // -----------------
    //  Write Functions
    // -----------------
    function collectHerb(string memory _name, string memory _geoLocation) public {
        herbCounter++;
        herbs[herbCounter] = Herb(herbCounter, _name, _geoLocation, block.timestamp, msg.sender);
        emit HerbCollected(herbCounter, _name, _geoLocation, msg.sender);
    }

    function createBatch(uint[] memory _herbIds, string memory _processDetails) public {
        batchCounter++;
        batches[batchCounter] = Batch(batchCounter, _herbIds, _processDetails, block.timestamp, msg.sender);
        emit BatchCreated(batchCounter, _herbIds, _processDetails);
    }

    function labelProduct(uint _batchId, string memory _formulationDetails) public {
        require(_batchId > 0 && _batchId <= batchCounter, "Invalid batch ID");
        productCounter++;
        products[productCounter] = Product(productCounter, _batchId, _formulationDetails, block.timestamp, msg.sender);
        emit ProductLabeled(productCounter, _batchId, _formulationDetails);
    }

    // -----------------
    //  Read Functions
    // -----------------
   function getHerb(uint _id) public view returns (Herb memory) {
    require(_id > 0 && _id <= herbCounter, "Herb does not exist");
    return herbs[_id];
}

function getBatch(uint _id) public view returns (Batch memory) {
    require(_id > 0 && _id <= batchCounter, "Batch does not exist");
    return batches[_id];
}

function getProduct(uint _id) public view returns (Product memory) {
    require(_id > 0 && _id <= productCounter, "Product does not exist");
    return products[_id];
}

}
