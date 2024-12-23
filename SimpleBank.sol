//SPDX-License-Identifier: MIT

//https://betterprogramming.pub/developing-a-smart-contract-by-using-remix-ide-81ff6f44ba2f
pragma solidity >=0.7.0 <=0.9.0;
contract SimpleBank {
struct client_account{

int client_id; //Keep Client ID
address client_address; //Keep Client Address
uint client_balance_in_ether; ////Keep Client Ether balance
}
client_account[] clients; //Array of all client maintain information
int clientCounter;
address payable manager; // payable function to receives ether address is datatype it is 20 byte hash address public key
modifier onlyManager() { //modifier can check wheather code is executed accouding to condition for manager side
require(msg.sender == manager, "Only manager can call this!"); // here sender is manager in this case
// for deposit sender is == manager and for withdrawal sender == client 
_;// when the function should be executed.
}
modifier onlyClients() { //modifier can check wheather code is executed accouding to condition for client side
    bool isclient = false; // intially value of isclient false
    for(uint i=0;i<clients.length;i++){ //check upto to all client store in array
        if(clients[i].client_address == msg.sender){ //now check client address matched with sender only that client intiate transaction
            isclient = true; // client address matched with existing client address in bank database isclient value updated true.
            break;
        }
    }
require(isclient, "Only clients can call this!"); // isclient true here so allowed call the transaction.
_; // when the function should be executed.
}
constructor() {
clientCounter = 0; // those client join contract assign there ID intially it set 0
}

receive() external payable { } // this allows the smart contract to receive ether
function setManager(address managerAddress) public returns(string memory){ //setManager method will be used to set the manager address to variables
// string memory store address of manager account instead of store data
manager = payable(managerAddress);// managerAddress is consumed as a parameter and cast as payable to provide sending ether.
return " "; // return payable address of manager
}

function joinAsClient() public payable returns(string memory){ //joinAsClient method will be used to make sure theclient joins the contract.
clients.push(client_account(clientCounter++, msg.sender, address(msg.sender).balance)); // push() array method to add items into a storage array.
return " "; // return all client details
}
function deposit() public payable onlyClients{ // deposit == client to contract by onlyclient
//deposit method will be used to send ETH from the client account to the contract.
// We want this method to be callable only by clients who’ve joined the contract, so the onlyClient modifier is used for this restriction.
payable(address(this)).transfer(msg.value); //transfer methods belongs to the contract, and it’s dedicated to sending an indicated amount of ETH between addresses.
// The payable keyword makes receipt of the ETH transfer possible so the amount of ETH indicated in the msg.value will be transferred to the contract address.
}
function withdraw(uint amount) public payable onlyClients{
// withdraw == contract to client by onlyclient
payable(msg.sender).transfer(amount * 1 ether);
//The withdraw method will be used to send ETH 
// so the onlyClient modifier is used for this restriction.
}
function sendInterest() public payable onlyManager{ //The sendInterest method will be used to send ETH as interest from the contract to all clients. can called by only manager
for(uint i=0;i<clients.length;i++){ // check client in database
address initialAddress = clients[i].client_address;
// check client address
payable(initialAddress).transfer(1 ether);
}
}
function getContractBalance() public view returns(uint){
//getContractBalance method will be used to get the balance of the contract we deployed.
    return address(this).balance;
}
}
