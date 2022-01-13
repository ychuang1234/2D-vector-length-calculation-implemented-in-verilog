<h1 align="left">2D vector length calculation implemented in verilog</h1>
<h2 align="center">  

 
 ## Goal 
 Compare performance of 2 VLSI implementation of square root operation in Verilog based on the pipelined multiplier to calculate vector length. 
  
  ## Description
I implemented Baysiean optimization algorithm with gaussian model to sample the possible combinations of hyperparamters in KNN model. The dataset was created randomly with 5 cluster with 2D feature (a.k.a number of features is two), which were not disclosed in the real scenario in training process. I randomly sampled 50 combinations of hyperparameters to make the gaussian model efficienly simulate the relationship between hypermeters and overall performance of the KNN model. Through simulation with Baysiean optimization (maximizing the posterior probility), instead of training to get the real data of the model performation, which is time-comsuming.


 <p align="center">
 
| Input vector    | Enable time  | A      | Binary search |
|:---------------:|:------------:| :-----:| :------------:|
| input=(25,5)    | 60 ps        | 195 ps |355 ps         | 
| input=(16,10)   | 523 ps       | 655 ps | 817 ps        |
 
</p>
 
 
<p align="center">
 <img src="https://github.com/ychuang1234/2D-vector-length-calculation-implemented-in-verilog/blob/5c9cd49b196f881f23c33c66eff427be8b669188/result1.JPG" height="80%">
 <img src="https://github.com/ychuang1234/2D-vector-length-calculation-implemented-in-verilog/blob/5c9cd49b196f881f23c33c66eff427be8b669188/result2.JPG" height="80%">
</p>
