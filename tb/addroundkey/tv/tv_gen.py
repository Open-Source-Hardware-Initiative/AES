#This file contains a test vector generator for the addroundkey function
#of AES

import random


def addroundkey(state,key):

    #Check bounds
    if (state >= 2**128) or (key >= 2**128):
        print("State or key out of bounds")
        exit()


    return state ^ key
    
    
    
    
    
#Number of vectors to generate
vectorAmt = 1000
#Open Test Vector File
tvFile = open("tv.txt","w")


for i in range(vectorAmt):
    state = random.randint(1000,2**128-1)
    key = random.randint(1000,2**128-1)
    
    result = addroundkey(state,key)
    
    
    #Convert vector to hex and zero fill
    state_hex = hex(state)[2:].zfill(32)
    key_hex = hex(key)[2:].zfill(32)
    result_hex = hex(result)[2:].zfill(32)
    
    tvFile.write("%s_%s_%s\n" % (state_hex,key_hex,result_hex))
