pragma solidity >=0.5.0;
import "./calculate.sol";

contract Betpool is Calculate {
    function register(string memory bet, uint256 deposit)
        external
        payable
        isNotRegister
        isOptions(bet)
    {
        require(
            msg.value >= 1 ether,
            "The minimum amount required to bet is 1 ether"
        );
        _players.push(msg.sender);
        _betOn[msg.sender] = bet;
        _betAmount[msg.sender] = deposit;
        emit playerRegister(msg.sender, bet);
        emit depositBet(msg.sender, deposit);
    }

    function _setOptions(string memory opt1, string memory opt2) internal {
        _options.push(opt1);
        _options.push(opt2);
        _countDifference();
    }
}
