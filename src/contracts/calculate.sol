pragma solidity >=0.5.0;
import "./storage.sol";

contract Calculate is Storage {
    mapping(string => uint256) internal _betChoices;
    string[] internal _options;

    modifier isOptions(string memory bet) {
        require(
            keccak256(abi.encodePacked(bet)) ==
                keccak256(abi.encodePacked(_options[0])) ||
                keccak256(abi.encodePacked(bet)) ==
                keccak256(abi.encodePacked(_options[1])),
            "The bet choice is not valid"
        );
        _;
    }

    function _countDifference() internal {
        uint256 counter1 = 0;
        uint256 counter2 = 0;
        for (uint256 i = 0; i < _options.length; i++) {
            if (
                keccak256(abi.encodePacked(_betOn[_players[i]])) ==
                keccak256(abi.encodePacked(_options[0]))
            ) {
                counter1++;
            } else {
                counter2++;
            }
        }
        _betChoices[_options[0]] = counter1;
        _betChoices[_options[1]] = counter2;
    }

    function empty() internal {
        delete _players;
        delete _options;
    }
}
