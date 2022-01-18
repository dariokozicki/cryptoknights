// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./utils/SafeMathUtils.sol";

library KnightLib {
    using SafeMath for uint256;
    using SafeMath8 for uint8;

    event Attack(uint256 attackerId, uint256 receiverId, uint8 energyLeft, bool wasSuccessful, uint256 damage);

    struct Knight {
        uint256 id;
        uint256 dna;
        uint256 experience;
        uint256 attackLevel;
        uint256 weaponId;
        uint8 energy;
        address owner;
    }

    function attack(Knight storage _attacker, Knight storage _receiver) external {
        require(_attacker.energy >= attackEnergyConsumption(), "The attacking knight has no more energy.");
        _attacker.energy = _attacker.energy.sub(attackEnergyConsumption());
        emit Attack(_attacker.id, _receiver.id, _attacker.energy, true, _attacker.attackLevel);
    }

    function attackEnergyConsumption() public pure returns (uint8) { 
        return 1;
    }
}