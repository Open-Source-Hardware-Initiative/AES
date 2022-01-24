# Introduction
This repository is a work in progress for an open source AES unit designed in SystemVerilog. More specifically,
this design is an implementation of the [FIPS 197 Standard](https://nvlpubs.nist.gov/nistpubs/fips/nist.fips.197.pdf) version
of the [Rijndael cipher](https://csrc.nist.gov/csrc/media/projects/cryptographic-standards-and-guidelines/documents/aes-development/rijndael-ammended.pdf).



## Directory structure
This directory is the root of the repository. Below this root you will find.
>**hdl**     : Contains the Hardware Descriptive Language of the AES Unit

>**scripts** : Contains handy dandy scripts that help with development or testing

>**tb**      : Contains testbenches for the AES unit




## User Guide
This repository is designed for users of ModelSim or QuestaSim and as such functions mostly on DO files. In order to run any individual test on the units
go to the tb directory and then the directory of the unit you would like to test. For Example :
> cd ./tb/sbox/

Next, you will want to run the testbench using the do file macro in that directory (assuming you have vsim in your path already):

> vsim -do test_sbox.do





## Branches
>**main**    : contains the main branch of the repository






## References
This repository contains an open source AES design as presented in:

Swann, R. L., &amp; Stine, J. E. (n.d.). In 55th Annual Asilomar Conference on Signals, Systems, and Computers (Vol. 55). Pacific Grove; IEEE. 
