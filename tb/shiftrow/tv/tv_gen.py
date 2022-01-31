#This python script generates test vectors for the AES shift row operation
import random


#This def takes in 128 bit state and outputs the 128 bit shifted state
def aes_inv_shiftrow(state):

    
    #Check Bounds
    if(state > (2**128-1)):
        print("Error : State is larger than a single block")
        exit()
        
    #Operate on state
    else:
        #Break into bytes
        bytes = []
        for i in range(16):
            bytes.append(hex((state >> (8*i)) & 0xFF )[2:].zfill(2))
            
        #Bytes will start at leas significant byte
        #bytes[0]  = w0_b0
        #bytes[1]  = w0_b1
        #bytes[2]  = w0_b2
        #bytes[3]  = w0_b3
        #bytes[4]  = w1_b0
        #bytes[5]  = w1_b1
        #bytes[6]  = w1_b2
        #bytes[7]  = w1_b3
        #bytes[8]  = w2_b0
        #bytes[9]  = w2_b1
        #bytes[10] = w2_b2
        #bytes[11] = w2_b3
        #bytes[12] = w3_b0
        #bytes[13] = w3_b1
        #bytes[14] = w3_b2
        #bytes[15] = w3_b3
        
        #Thus 
        #wire [31:0] out_w0 = {w3_b3, w0_b2, w1_b1, w2_b0};
        #wire [31:0] out_w1 = {w2_b3, w3_b2, w0_b1, w1_b0};
        #wire [31:0] out_w2 = {w1_b3, w2_b2, w3_b1, w0_b0};
        #wire [31:0] out_w3 = {w0_b3, w1_b2, w2_b1, w3_b0};
        #assign dataOut = {out_w0, out_w1, out_w2, out_w3};
        
        #becomes
        out_w0 = bytes[15] + bytes[2]  + bytes[5]  + bytes[8]
        out_w1 = bytes[11] + bytes[14] + bytes[1]  + bytes[4]
        out_w2 = bytes[7]  + bytes[10] + bytes[13] + bytes[0]
        out_w3 = bytes[3]  + bytes[6]  + bytes[9]  + bytes[12]
        
        
        return int(out_w0 + out_w1 + out_w2 + out_w3,16)


def aes_shiftrow(state):

    #Check Bounds
    if(state > (2**128-1)):
        print("Error : State is larger than a single block")
        exit()
        
    #Operate on state
    else:
        #Break into bytes
        bytes = []
        for i in range(16):
            bytes.append(hex((state >> (8*i)) & 0xFF )[2:].zfill(2))
            
        #Bytes will start at leas significant byte
        #bytes[0]  = w0_b0
        #bytes[1]  = w0_b1
        #bytes[2]  = w0_b2
        #bytes[3]  = w0_b3
        #bytes[4]  = w1_b0
        #bytes[5]  = w1_b1
        #bytes[6]  = w1_b2
        #bytes[7]  = w1_b3
        #bytes[8]  = w2_b0
        #bytes[9]  = w2_b1
        #bytes[10] = w2_b2
        #bytes[11] = w2_b3
        #bytes[12] = w3_b0
        #bytes[13] = w3_b1
        #bytes[14] = w3_b2
        #bytes[15] = w3_b3
        
        #Thus 
        #wire [31:0] out_w0 = {w3_b3, w2_b2, w1_b1, w0_b0};
        #wire [31:0] out_w1 = {w2_b3, w1_b2, w0_b1, w3_b0};
        #wire [31:0] out_w2 = {w1_b3, w0_b2, w3_b1, w2_b0};
        #wire [31:0] out_w3 = {w0_b3, w3_b2, w2_b1, w1_b0}; 
        #assign dataOut = {out_w0, out_w1, out_w2, out_w3};
        
        #becomes
        out_w0 = bytes[15] + bytes[10]  + bytes[5]  + bytes[0]
        out_w1 = bytes[11] + bytes[6] + bytes[1]  + bytes[12]
        out_w2 = bytes[7]  + bytes[2] + bytes[13] + bytes[8]
        out_w3 = bytes[3]  + bytes[14]  + bytes[9]  + bytes[4]       
        
        
        return int(out_w0 + out_w1 + out_w2 + out_w3,16)
  
#Number of vectors to generate
number_vectors = 1000      
#Open Test vector file
f = open("tv.txt","w")

for i in range(number_vectors):
    input_vector = random.randint(1000,2**128-1)
    output_vector = aes_shiftrow(input_vector)
    f.write("%s_%s\n" % (hex(output_vector)[2:].zfill(32),hex(input_vector)[2:].zfill(32)))







