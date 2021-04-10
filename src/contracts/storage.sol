pragma solidity >=0.5.0;
import "@openzeppelin/contracts/access/Ownable.sol";

contract Storage is Ownable {
    mapping(address => uint256) private _betAmount;
    mapping(address => string) private _betOn;
    address[] private _players;

    event depositBet(address indexed player, uint256 amount);
    event playerRegister(address indexed player, string bet);

    modifier isNotRegister() {
        uint256 counter = 0;
        for (uint256 i = 0; i < _players.length; i++) {
            if (_players[i] != msg.sender) {
                counter++;
            }
        }
        require(counter == _players.length, "You have already register");
        _;
    }

    function register(string memory bet, uint256 deposit)
        external
        payable
        isNotRegister
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

    function getAmount() external view returns (uint256) {
        uint256 amount = _betAmount[msg.sender];
        return amount;
    }

    function getChoice() external view returns (string memory) {
        string memory choice = _betOn[msg.sender];
        return choice;
    }

    function empty() internal {
        delete _players;
    }

    function withdraw() external onlyOwner {
        address payable _owner = payable(owner());
        _owner.transfer(address(this).balance);
    }
}
