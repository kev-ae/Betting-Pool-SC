pragma solidity >=0.5.0;
import "./storage.sol";

contract Calculate is Storage {
    mapping(string => uint256) private _betChoices;
    string[] private _options;

    function calculateDifference()
        internal
        returns (
            string memory,
            uint256,
            string memory,
            uint256
        )
    {
        getOptions();
        uint256 counter = 0;
        for (uint256 i = 0; i < _options.length; i++) {}
    }

    function getOptions() private {
        uint256 counter = 0;
        for (uint256 i = 0; i < _players.length; i++) {
            for (uint256 j = 0; j < _options.length; j++) {
                if (
                    keccak256(abi.encodePacked(_betOn[_players[i]])) !=
                    keccak256(abi.encodePacked(_options[j]))
                ) {
                    counter++;
                } else {
                    j = _options.length;
                }
            }
            if (counter == _options.length) {
                _options.push(_betOn[_players[i]]);
            }
            counter = 0;
        }
    }
}
