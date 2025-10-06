##
# Synthesize all Combinations of sbox,  mixcol and arch
##
architectures = {"radix4":"radix4_fwd.sv",
                 "radix8":"radix8_fwd.sv",
                 "radix32":"radix32_fwd.sv",
                 "full_spatial":"full_spatial_fwd",
                 "pipelined":"pipelined"}
sboxes = {"lut_sbox":"lut_sbox", #Key is for identification, 
          ""}
mixcols = {}
#Exhaustive Search over the design space
for architecture in architectures:
    for sbox in sboxes:
        for mixcol in mixcols:
            output = codegen(architecture,sbox,mixcol) # Generate a modular AES with a certain arch,sbox,and mixcol
            power,performance,area = eda_flow(output) # Characterize the structure of the generated code
