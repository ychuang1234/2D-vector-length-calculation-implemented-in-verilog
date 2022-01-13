<h1 align="left">2D vector length calculation implemented in verilog</h1>
<h2 align="center">  

 
 ## Goal 
 Compare performance of 2 VLSI implementation of **square root operation** in Verilog based on the **pipelined multiplier** to calculate vector length. 
  
  ## Description
 In this project, I implemented pipelined interger multiplier by using severals registers to store the intermediate result in `mult_man.v` and square root operation by binary search in `sqrt.v`. In order to compare the efficiency of binary search and its possible drawbacks, I compared my implementation with [A new non-restoring square root algorithm and its VLSI implementations](https://ieeexplore.ieee.org/document/563604) in `function` in `vector_len.v`. I also wrote `test.tb` to test if signal being raised (espicaiily the **ready signal** after operation) at the anticipated time, and reset all all the value stored in registers to zero before new round of vector length calculation round. 

 ## Result
 <p align="center">
 
| Input vector    | Enable time  | Non-restoring square root | Binary search sqaure root |
|:---------------:|:------------:| :-----:| :------------:|
| input=(25,5)    | 60 ps        | 195 ps |355 ps         | 
| input=(16,10)   | 523 ps       | 655 ps | 817 ps        |
 
</p>
 
 
<p align="center">
 <img src="https://github.com/ychuang1234/2D-vector-length-calculation-implemented-in-verilog/blob/5c9cd49b196f881f23c33c66eff427be8b669188/result1.JPG" height="80%">
 <img src="https://github.com/ychuang1234/2D-vector-length-calculation-implemented-in-verilog/blob/5c9cd49b196f881f23c33c66eff427be8b669188/result2.JPG" height="80%">
</p>
