pragma solidity >=0.5.0;
import "@openzeppelin/contracts/access/Ownable.sol";

contract Storage is Ownable {
    mapping(address => uint256) private _betAmount;
    mapping(address => string) private _betOn;
    address[] private _players;

    event depositBet(address indexed player, uint256 amount);

    function register(string memory bet) external {
        require(
            bytes(_betOn[msg.sender]).length == 0,
            "You have already register"
        );
        _players.push(msg.sender);
        chosenBet(bet, msg.sender);
    }

    function depostBet(uint256 amount) external payable {
        require(
            msg.value >= 1 ether,
            "The minimum amount required to bet is 1 ether"
        );
        _betAmount[msg.sender] += amount;
        emit depositBet(msg.sender, amount);
    }

    function chosenBet(string memory bet, address player) private {
        _betOn[player] = bet;
    }

    function getAmount() external view returns (uint256) {
        uint256 amount = _betAmount[msg.sender];
        return amount;
    }

    function getChoice() external view returns (string memory) {
        string memory choice = _betOn[msg.sender];
        return choice;
    }

    function empty() private {
        for (uint256 i = _players.length - 1; i >= 0; i--) {
            _betAmount[_players[i]] = 0;
            _betOn[_players[i]] = "";
            _players.pop();
        }
    }
}
