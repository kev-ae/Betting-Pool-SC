pragma solidity >=0.5.0;
import "@openzeppelin/contracts/access/Ownable.sol";

contract Storage is Ownable {
    mapping(address => uint256) internal _betAmount;
    mapping(address => string) internal _betOn;
    address[] internal _players;

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

    function getAmount() external view returns (uint256) {
        uint256 amount = _betAmount[msg.sender];
        return amount;
    }

    function getChoice() external view returns (string memory) {
        string memory choice = _betOn[msg.sender];
        return choice;
    }

    function withdraw() external onlyOwner {
        address payable _owner = payable(owner());
        _owner.transfer(address(this).balance);
    }
}
