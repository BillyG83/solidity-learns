pragma solidity 0.8.10;

contract Bank {

    mapping(address => uint) balance;
    address owner;

    modifier onlyOwner {
        require(msg.sender == owner, "Sorry you are not admin");
        _; // run the function
    }

    constructor() {
        owner = msg.sender;
    }

    function addBalance(uint _toAdd) public onlyOwner returns (uint) {
        balance[msg.sender] += _toAdd;
        return balance[msg.sender];
    }

    function getBalance() public view returns (uint) {
        return balance[msg.sender];
    }

    function transfer (address recipient, uint amount) public {
        require(balance[msg.sender] >= amount, "Balance is too low for");
        require(msg.sender != recipient, "Do not send to yourself");

        uint previousBalance = balance[msg.sender];
        _transfer(msg.sender, recipient, amount);
        assert(balance[msg.sender] == previousBalance - amount);
    }

    function _transfer(address from, address to, uint amount) private {
        balance[from] -= amount;
        balance[to] += amount;
    }
}