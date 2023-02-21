// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;

contract sharing {
    address payable admin;

    struct vehicle {
        string id;
        uint256 unitPrice; // price per unit time;
        uint256 idleTime;
        uint256 drivingDistance; // accumulative driving distance
        uint256 vehicleValue;
    }

    struct customer {
        string id;
        uint256 drivingAge;
    }

    vehicle[] private vehicleList;

    customer[] private customerList;

    modifier checkParameter() {
        
    }

    constructor() payable {
        admin = payable(msg.sender);
    }

    // need a modifier to check input parameter
    function addVehicle(
        string memory _id,
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
    function addCustomer(
        string memory _id,
        uint256 _drivingAge
    ) public {
        customerList.push(
            customer({
                id: _id,
                drivingAge: _drivingAge
            })
        );
    }
}
