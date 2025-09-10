// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract AyurvedicTraceability {
    uint public herbCounter;
    uint public batchCounter;
    uint public productCounter;

    struct Herb {
        string herbId;       // unique string ID (HERB-XXXX)
        string name;
        string geoLocation;
        uint timestamp;
        address collector;
    }

    struct Batch {
        uint id;
        string[] herbIds;     // store string herbIds
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

    // Herb lookup by herbId string
    mapping(string => Herb) public herbs;
    mapping(uint => Batch) public batches;
    mapping(uint => Product) public products;

    event HerbCollected(string herbId, string name, string geoLocation, address collector);
    event BatchCreated(uint id, string[] herbIds, string processDetails);
    event ProductLabeled(uint id, uint batchId, string formulationDetails);

    // -----------------
    //  Write Functions
    // -----------------
    function collectHerb(string memory _herbId, string memory _name, string memory _geoLocation) public {
        require(bytes(herbs[_herbId].herbId).length == 0, "Herb ID already exists");
        herbCounter++;
        herbs[_herbId] = Herb(_herbId, _name, _geoLocation, block.timestamp, msg.sender);
        emit HerbCollected(_herbId, _name, _geoLocation, msg.sender);
    }

    function createBatch(string[] memory _herbIds, string memory _processDetails) public {
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
    function getHerb(string memory _herbId) public view returns (Herb memory) {
        require(bytes(herbs[_herbId].herbId).length > 0, "Herb does not exist");
        return herbs[_herbId];
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