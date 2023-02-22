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
        uint256 userId;
        uint256 vehicleId;
    }

    vehicle[] private vehicleList;

    customer[] private customerList;
    

    uint256[] matchSign;

    matchPair[] result;


    constructor() payable {
        admin = payable(msg.sender);
    }

    //TODO maybe need a modifier to check parameters
    function appendVehicle(
        uint256 _id,
        uint256 _unitPrice,
        uint256 _idleTime,
        uint256 _drivingDistance,
        uint256 _vehicleValue
    ) public  {
        uint256[] memory blank;
        vehicleList.push(
            vehicle({
                id: _id,
                unitPrice: _unitPrice,
                idleTime: _idleTime,
                drivingDistance: _drivingDistance,
                vehicleValue: _vehicleValue,
                preference: blank,
                requestQuene: blank
            })
        );
    }

    //TODO maybe need a modifier to check parameters
    function appendCustomer(
        uint256 _id,
        uint256 _drivingAge
    ) public {
        uint256[] memory blank;
        customerList.push(
            customer({
                id: _id,
                drivingAge: _drivingAge,
                preference: blank
            })
        );
    }

    function buildPairs() public returns (matchPair[] memory) {
        updatePreferenceForCustomers();
        updatePreferenceForVehicles();

        for(uint i = 0; i < customerList.length; i++) {
            if(matchSign[i] == 0) sendRequset(i);
        }
        for(uint i = 0; i < vehicleList.length; i++) {
            if(vehicleList[i].requestQuene.length > 0) {
                if(vehicleList[i].requestQuene.length == 1) {
                    result.push(matchPair({
                        userId: vehicleList[i].requestQuene[0],
                        vehicleId: i
                    }));
                matchSign[vehicleList[i].requestQuene[0]] = 1;
                }else {
                    uint256 candidate = vehicleList[i].requestQuene[0];
                    uint256 candidatePosition = findPosition(candidate);
                    for(uint j = 0; j < vehicleList[i].requestQuene.length; j++) {
                        if(findPosition(vehicleList[i].requestQuene[j]) <candidatePosition ) {
                            candidate = vehicleList[i].requestQuene[j];
                            candidatePosition = findPosition(candidate);
                        }
                    }
                    result.push(matchPair({
                        userId: candidate,
                        vehicleId: i
                    }));
                    matchSign[candidate] = 1;
                }

            }
        }
        return result;
    }

    function updatePreferenceForVehicles() private {

    }

    function updatePreferenceForCustomers() private {

    }

    function sendRequset(uint256 order) private {
        uint256 vehicleId = customerList[order].preference[0];
        vehicleList[vehicleId].requestQuene[0] = order;
        //TODO is it need to remove ranked object?
    }



    function vehicleValue() private pure returns(fixed ) {

    }
    
    function customerValue() private pure returns(fixed) {

    }

    function findPosition(uint256 num) private returns(uint256){

    }
}
