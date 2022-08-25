pragma solidity ^0.5.0;

// Defines a new contract named `Joint Savings Account`
contract JointSavings {
    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance; 

    /*
    'withdraw function' with two arguments:
        - A `uint` variable named `amount`
        - A `payable address` named `recipient`
    */
    function withdraw(uint amount, address payable recipient) public {

        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");
        require(address(this).balance >= amount, "Insufficient funds!");
        // `if` statement checks if the `lastToWithdraw` is not equal to (`!=`) to `recipient`. If `lastToWithdraw` is not equal, then it's set to the current value of `recipient`.
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        // Calls the `transfer` function of the `recipient` and passes it the `amount` to transfer as an argument.
            recipient.transfer(amount);
        // Sets the `lastWithdrawAmount` variable equal to `amount`
            lastWithdrawAmount = amount;
        // Calls the `contractBalance` variable and sets it equal to the balance of the contract by using `address(this).balance` to reflect the new balance of the contract.
            contractBalance = address(this).balance;
    }
}
    //* `public payable` function named `deposit`.
    function deposit() public payable {

        /*
        Calls the `contractBalance` variable and sets it equal to the balance of the contract by using `address(this).balance`.
        */
        contractBalance = address(this).balance;
    }

    /*
    Defines a `public` function named `setAccounts` that receives two `address payable` arguments named `account1` and `account2`.
    */
    function setAccounts(address payable account1, address payable account2) public{
        accountOne = account1;
        accountTwo = account2;
    }

    /*
    **Default fallback function** so that the user contract can store Ether sent from outside the deposit function.
    */
    function() external payable {}
}