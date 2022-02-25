# Summary
This directory contains the testbench for the single round key computation
module. This module accomplishes a single round key computation according
to the round key schedule specified in the [AES Standard](https://nvlpubs.nist.gov/nistpubs/fips/nist.fips.197.pdf)


## Usage
This directory contains two subdirectories:
> 128bit
> 256bit

These subdirectories represent the modes for round key generation currently
supported by this AES unit. Inside of each folder you will find a **tv** folder
which contains a python script that, when run, will generate the test vectors
for the unit. After running this python script and succesfully generating
**tv.txt** you will return to the above directory and run the command (assuming
you are using modelsim):
> vsim -do test_roundkey_vec.do

This should run the simulation for the round key generation
