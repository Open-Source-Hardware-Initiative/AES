#This python script generates test vectors for the aesRotate function


import random


def aesRotate(inWord,disable):

    #Check Bounds
    if(inWord > 2**32):
        print("Input Word to AES Rotate Function is too large, the maximum is a 32 bit integer")
        exit()
        
    elif(disable == 1):
        return inWord
    
    else:
        #Intialize empty string for rotation
        outWord = ""
        #Convert input to binary string and fill to 32 bits
        inWord_bin = bin(inWord)[2:].zfill(32)
        #This version will be little endian, which makes the indicies more similar to verilog
        inWord_bin_rev = inWord_bin[::-1]

        #Rotate in[23:16] to out[31:24]
        outWord += inWord_bin_rev[23:15:-1] 
        #Rotate in[15:8] to out[23:16]
        outWord += inWord_bin_rev[15:7:-1] 
        #Rotate in[7:0] to out[15:8]
        outWord +=  inWord_bin_rev[7::-1] 
        #Rotate in[31:24] to out[7:0]
        outWord +=  inWord_bin_rev[31:23:-1]
        
        #Return result as an integer for easier number management
        return int(outWord,2)


#Number of vectors you want to create
number_vectors = 1000
f = open("tv.txt","w")

for i in range(number_vectors):

    #Generate random inputs
    inWord = random.randint(1000,2**32)
    disable = random.randint(0,1)
    
    
    #Get output from random inputs
    outWord = aesRotate(inWord,disable)
    
    #Output inputs and outputs to test vector file
    f.write("%s_%s_%s\n" % (disable,bin(outWord)[2:].zfill(32),bin(inWord)[2:].zfill(32)))
