# Rotate Word Testbenches
This directory contains testbenches for the rotate word operation. 


## Usage
This directory contains two tests, one for simple debugging and one that utilizes testvectors for a more thorough test.

> Basic Testbench
>> To run the basic testbench, all you need to do (assuming you are using modelsim) is run <mark>vsim -do test_rot.do</mark>

> Vectorized testbench
>> To run the vectorized testbench, you will first need to generate the vectors. First go to the tv directory and run the 
>> python script using <mark>python3 gen_tv.py</mark> and then go back up to this directory and run <mark> vsim -do test_rot_tv.do </mark>
