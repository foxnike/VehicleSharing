// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.0;


// TODO ensure how and where use this constance
uint256 constant expansionFactor = 10^8;

uint256 constant skillPara1 = 1;
uint256 constant skillPara2 = 1; 

contract sharing {
    address payable admin;

    struct vehicle {
        uint256 id;  // does it has meaning?
        uint256 price; // price per unit time;
        uint256 idleTime;
        uint256 drivingDistance; // accumulative driving distance
        uint256 vehicleValue;
        uint256[] preference;
        uint256[] requestQuene;
        int256 matchId;
    }

    struct customer {
        uint256 id;
        uint256 drivingAge;
        uint256 deductionPerTime;
        uint256[] preference;
    }

    // now it records the subscript of customers or vehicles
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
        uint256 _price,
        uint256 _idleTime,
        uint256 _drivingDistance,
        uint256 _vehicleValue
    ) public  {
        uint256[] memory blank;
        vehicleList.push(
            vehicle({
                id: _id,
                price: _price,
                idleTime: _idleTime,
                drivingDistance: _drivingDistance,
                vehicleValue: _vehicleValue,
                preference: blank,
                requestQuene: blank,
                matchId: -1
            })
        );
    }

    //TODO maybe need a modifier to check parameters
    function appendCustomer(
        uint256 _id,
        uint256 _deductionPerTime,
        uint256 _drivingAge
    ) public {
        uint256[] memory blank;
        customerList.push(
            customer({
                id: _id,
                drivingAge: _drivingAge,
                deductionPerTime: _deductionPerTime,
                preference: blank
            })
        );
    }
    // only first match round
    function buildPairs() public returns (matchPair[] memory) {
        updatePreferenceForCustomers();
        updatePreferenceForVehicles();

        for(uint i = 0; i < customerList.length; i++) {
            if(matchSign[i] == 0) sendRequset(i);
        }
        for(uint i = 0; i < vehicleList.length; i++) {
            uint256[] memory line = vehicleList[i].requestQuene;
            if(line.length > 0) {
                uint256 candidate = line[0];
                uint256 degreeOfCandidate = getDegree(i,candidate);
                if(line.length == 1) {
                    result.push(matchPair({
                        userId: candidate,
                        vehicleId: i
                    }));
                matchSign[candidate] = 1;
                }else {
                    for(uint j = 0; j < line.length; j++) {
                        if(getDegree(i,line[j]) < degreeOfCandidate) {
                            candidate = line[j];
                            degreeOfCandidate = getDegree(i,line[j]);
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
        
        for(uint i = 0; i < vehicleList.length; i++) {
            uint256[] memory values;
            for(uint j = 0; j < customerList.length; j++) {
                values[j] = customerValue(i,j);
            }
            for(uint j = 0; j < values.length; j++) {
                uint maxPos = getMaxOne(values);
                customerList[i].preference.push(maxPos);
                values[maxPos] = 0;
            }
        }
    }

    function updatePreferenceForCustomers() private {

    }

    function sendRequset(uint256 order) private {
        uint256 vehicleId = customerList[order].preference[0];
        vehicleList[vehicleId].requestQuene[0] = order;
        //TODO is it need to remove ranked object?
    }


    //plus 10^8/ 2^10 for every number
    function vehicleValue() private pure returns(fixed ) {
        
    }
    //plus 10^8/ 2^10 for every number
    // utility of vehicles is indicator multiply price multiply driving skill multiply credit
    // for the  customer whom condition cant satisfied  return zero
    function customerValue(uint vehicleId,uint customerId) private  returns(uint256) {
        uint256 price = vehicleList[vehicleId].price;
        uint256 skillUtility = getSkillUtilty(customerList[customerId].drivingAge,customerList[customerId].deductionPerTime);
        uint256 creditUtility = getCreditUtility(customerId);
        uint256 output = price * skillUtility * creditUtility;
        return output;
    }


    //TODO get customer order in vehivle's preference list
    function getDegree(uint256 vehicleId,uint256 customerId) private returns(uint256){

    }

    function getMaxOne(uint256[] memory values) pure private returns(uint) {
        uint maxPos;
        for(uint i = 0; i < values.length; i++) {
            if(values[maxPos] < values[i]) {
                maxPos = i;
            }
        }
        return maxPos;
    }

    function getSkillUtilty(uint drivingAge,uint deductionPerTime) private pure returns(uint256 ) {
        drivingAge *= expansionFactor;
        deductionPerTime *= expansionFactor;
        return drivingAge*drivingAge*skillPara1 - deductionPerTime*skillPara2;
    }

    function getCreditUtility(uint customerId) private returns(uint) {

    }
}
