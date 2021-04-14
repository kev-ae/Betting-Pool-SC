pragma solidity >=0.5.0;
import "./storage.sol";

contract Calculate is Storage {
    mapping(string => uint256) internal _betChoices;
    string[] internal _options;
    uint256 internal _choice1Winnings;
    uint256 internal _choice2Winnings;

    modifier isOptions(string memory bet) {
        require(
            keccak256(abi.encodePacked(bet)) ==
                keccak256(abi.encodePacked(_options[0])) ||
                keccak256(abi.encodePacked(bet)) ==
                keccak256(abi.encodePacked(_options[1])),
            "The input you have chosen is not one of the options"
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
                _choice1Winnings += _betAmount[_players[i]];
            } else {
                counter2++;
                _choice2Winnings += _betAmount[_players[i]];
            }
        }
        _betChoices[_options[0]] = counter1;
        _betChoices[_options[1]] = counter2;
    }

    function _getPercentage() internal view returns (uint256, uint256) {
        uint256 total = _betChoices[_options[0]] + _betChoices[_options[1]];
        uint256 pcent1 = (_betChoices[_options[0]] * 100) / total;
        uint256 pcent2 = (_betChoices[_options[1]] * 100) / total;
        return (pcent1, pcent2);
    }

    function _divide(string memory winner) internal view returns (uint256) {
        uint256 p1;
        uint256 p2;
        uint256 percent = 0;
        (p1, p2) = _getPercentage();
        if (
            keccak256(abi.encodePacked(winner)) ==
            keccak256(abi.encodePacked(_options[0]))
        ) {
            percent = p2 / _betChoices[_options[0]];
        } else {
            percent = p1 / _betChoices[_options[1]];
        }
        return percent;
    }
}
