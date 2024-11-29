// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

contract wavecount {
    struct waves{
        uint256[] wave_count;
    }
    waves w_var;
 function store(uint256 _num) public{
    if(_num!=0)
        w_var.wave_count.push(_num);
    else
    delete w_var.wave_count;
 }
 function retrive() public view returns (uint256){
     return w_var.wave_count.length;
 }
}
