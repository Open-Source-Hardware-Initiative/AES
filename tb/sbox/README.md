# SBOX Testbench
This Directory contains the testbench for the substitution box
unit for the AES design. 

## Usage
In order to run the exhaustive substitution box test you will first
need to generate test vectors by going to the ```tv``` directory 
and running the tv_gen programming by typing the command ```python3
tv_gen.py``` This will generate ```tv.txt``` which is used as
comparison for the testbech, next, you will run the testbench in
this directory by running the command ```vsim -do test_sbox.do```
this will run the substitution box test and check that it is
functioning properly. 
