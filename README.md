# Introduction
This repository is a work in progress for an open source AES unit designed in SystemVerilog. More specifically,
this design is an implementation of the [FIPS 197 Standard](https://nvlpubs.nist.gov/nistpubs/fips/nist.fips.197.pdf) version
of the [Rijndael cipher](https://csrc.nist.gov/csrc/media/projects/cryptographic-standards-and-guidelines/documents/aes-development/rijndael-ammended.pdf). 
The goal of this implementation is to create a skeleton for other researchers to expand on and more easily test different hypothesis in a hardware setting.
As this repository matures, I hope to add comparisons of different available logic optimizations for AES as well as create a basis for rapid testing of the functionality and efficacy of advancements to the AES hardware design. As opposed to other implementations, this implementation is RTL/synthesis friendly.  It also tries to create an easy to understand implementation and testbenching system in SV.  Some of the comparisons of this unit are in the paper listed in the README.



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

R. L. Swann and J. E. Stine, "A Reconfigurable Architecture for Improvement and Optimization of Advanced Encryption Standard Hardware, " 55th Annual Asilomar Conference on Signals, Systems, and Computers, 2021 (in press).
