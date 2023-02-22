// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;

contract sharing {
    address payable admin;

    struct vehicle {
        uint256 id;
        uint256 unitPrice; // price per unit time;
        uint256 idleTime;
        uint256 drivingDistance; // accumulative driving distance
        uint256 vehicleValue;
        uint256[] preference;
        uint256[] requestQuene;
    }

    struct customer {
        uint256 id;
        uint256 drivingAge;
        uint256[] preference;
    }

    struct matchPair {
        string userId;
        string vehicleId;
    }

    vehicle[] private vehicleList;

    customer[] private customerList;

    constructor() payable {
        admin = payable(msg.sender);
    }

    // need a modifier to check input parameter
    function appendVehicle(
        uint256 _id,
        uint256 _unitPrice,
        uint256 _idleTime,
        uint256 _drivingDistance,
        uint256 _vehicleValue
    ) public  {
        vehicleList.push(
            vehicle({
                id: _id,
                unitPrice: _unitPrice,
                idleTime: _idleTime,
                drivingDistance: _drivingDistance,
                vehicleValue: _vehicleValue
            })
        );
    }

    // need a modifier to check input parameter
    function appendCustomer(
        uint256 _id,
        uint256 _drivingAge
    ) public {
        customerList.push(
            customer({
                id: _id,
                drivingAge: _drivingAge
            })
        );
    }

    function buildPairs() public returns (matchPair[] memory) {
        buildPreferenceForCustomer();
        buildPreferenceForVehicle();
        uint256[customerList.length] unmatchCutomer;
        for(uint i = 0; i < customerList ; i++){
           sendRequset()
        }
    }

    function buildPreferenceForVehicles() private {

    }

    function buildPreferenceForCustomers() private {

    }

    function sendRequset(uint256 num) private returns(int) {

    }



    function vehicleValue() private pure returns(fixed ) {

    }
    
    function customerValue() private pure returns(fixed) {

    }
}
