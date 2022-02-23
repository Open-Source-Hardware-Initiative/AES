import random

#128 bit key round constants
rcon_256 = [0x01,0x01,0x00,0x02,0x00,0x04,0x00,0x08,0x00,0x10,0x00,0x20,0x00,0x40]


#Substitution Box
sbox = (
    0x63, 0x7C, 0x77, 0x7B, 0xF2, 0x6B, 0x6F, 0xC5, 0x30, 0x01, 0x67, 0x2B, 0xFE, 0xD7, 0xAB, 0x76,
    0xCA, 0x82, 0xC9, 0x7D, 0xFA, 0x59, 0x47, 0xF0, 0xAD, 0xD4, 0xA2, 0xAF, 0x9C, 0xA4, 0x72, 0xC0,
    0xB7, 0xFD, 0x93, 0x26, 0x36, 0x3F, 0xF7, 0xCC, 0x34, 0xA5, 0xE5, 0xF1, 0x71, 0xD8, 0x31, 0x15,
    0x04, 0xC7, 0x23, 0xC3, 0x18, 0x96, 0x05, 0x9A, 0x07, 0x12, 0x80, 0xE2, 0xEB, 0x27, 0xB2, 0x75,
    0x09, 0x83, 0x2C, 0x1A, 0x1B, 0x6E, 0x5A, 0xA0, 0x52, 0x3B, 0xD6, 0xB3, 0x29, 0xE3, 0x2F, 0x84,
    0x53, 0xD1, 0x00, 0xED, 0x20, 0xFC, 0xB1, 0x5B, 0x6A, 0xCB, 0xBE, 0x39, 0x4A, 0x4C, 0x58, 0xCF,
    0xD0, 0xEF, 0xAA, 0xFB, 0x43, 0x4D, 0x33, 0x85, 0x45, 0xF9, 0x02, 0x7F, 0x50, 0x3C, 0x9F, 0xA8,
    0x51, 0xA3, 0x40, 0x8F, 0x92, 0x9D, 0x38, 0xF5, 0xBC, 0xB6, 0xDA, 0x21, 0x10, 0xFF, 0xF3, 0xD2,
    0xCD, 0x0C, 0x13, 0xEC, 0x5F, 0x97, 0x44, 0x17, 0xC4, 0xA7, 0x7E, 0x3D, 0x64, 0x5D, 0x19, 0x73,
    0x60, 0x81, 0x4F, 0xDC, 0x22, 0x2A, 0x90, 0x88, 0x46, 0xEE, 0xB8, 0x14, 0xDE, 0x5E, 0x0B, 0xDB,
    0xE0, 0x32, 0x3A, 0x0A, 0x49, 0x06, 0x24, 0x5C, 0xC2, 0xD3, 0xAC, 0x62, 0x91, 0x95, 0xE4, 0x79,
    0xE7, 0xC8, 0x37, 0x6D, 0x8D, 0xD5, 0x4E, 0xA9, 0x6C, 0x56, 0xF4, 0xEA, 0x65, 0x7A, 0xAE, 0x08,
    0xBA, 0x78, 0x25, 0x2E, 0x1C, 0xA6, 0xB4, 0xC6, 0xE8, 0xDD, 0x74, 0x1F, 0x4B, 0xBD, 0x8B, 0x8A,
    0x70, 0x3E, 0xB5, 0x66, 0x48, 0x03, 0xF6, 0x0E, 0x61, 0x35, 0x57, 0xB9, 0x86, 0xC1, 0x1D, 0x9E,
    0xE1, 0xF8, 0x98, 0x11, 0x69, 0xD9, 0x8E, 0x94, 0x9B, 0x1E, 0x87, 0xE9, 0xCE, 0x55, 0x28, 0xDF,
    0x8C, 0xA1, 0x89, 0x0D, 0xBF, 0xE6, 0x42, 0x68, 0x41, 0x99, 0x2D, 0x0F, 0xB0, 0x54, 0xBB, 0x16,
)

def aes_subword(state):
    '''This function applies the substitution box to the entire state'''

    #Break state into bytes
    state_bytes = [(state & (0xFF << 8 * i)) >> (8 * i) for i in range(4)]
    #Reverse bytelist to get correct direction
    state_bytes.reverse()
    #Initialize output string
    out_string = ""

    for byte in state_bytes:
        out_string = out_string + hex(sbox[byte])[2:].zfill(2)

    return int(out_string,16)



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



def key_xor(key,sbox_out,roundNum):
    key_bin = bin(key)[2:].zfill(128)
    sbox_out_bin = bin(sbox_out)[2:].zfill(32)
    roundNum_bin = bin(roundNum)[2:].zfill(4)
    

    #Split key into 32 bit words
    key_bin_split =  [int(key_bin[i:i+32],2) for i in range(0, len(key_bin), 32)]
    
    #Get rcon from table and bitshift by 24
    rcon = rcon_256[roundNum-1] << 24
    
    
    #Recombine
    out_w0 = sbox_out ^ key_bin_split[3] ^ key_bin_split[2] ^ key_bin_split[1] ^ key_bin_split[0] ^ rcon
    out_w1 = sbox_out ^ key_bin_split[2] ^ key_bin_split[1] ^ key_bin_split[0] ^ rcon
    out_w2 = sbox_out ^ key_bin_split[1] ^ key_bin_split[0] ^ rcon
    out_w3 = sbox_out ^ key_bin_split[0] ^ rcon
    

    
    return int(hex(out_w3)[2:].zfill(8) + hex(out_w2)[2:].zfill(8) + hex(out_w1)[2:].zfill(8) + hex(out_w0)[2:].zfill(8),16)

    

def gen_roundkey(prev_roundkey,cur_roundkey,roundNum):
    key_bin = bin(prev_roundkey)[2:].zfill(128)
    cur_key_bin = bin(cur_roundkey)[2:].zfill(128)
    
    key_bin_split =  [int(key_bin[i:i+32],2) for i in range(0, len(key_bin), 32)]
    
    cur_key_bin_split =  [int(cur_key_bin[i:i+32],2) for i in range(0, len(key_bin), 32)]
    
    lowestWord = cur_key_bin_split[3]
    
    #Run lowest word through rotate
    rotWord = aesRotate(lowestWord,int(bin(roundNum)[-1],2))
    print(hex(rotWord))
    #Substitute rotated word
    subWord = aes_subword(rotWord)
    #Run key through key_xor
    return key_xor(prev_roundkey,subWord,roundNum)

    
    return int(hex(out_w3)[2:].zfill(8) + hex(out_w2)[2:].zfill(8) + hex(out_w1)[2:].zfill(8) + hex(out_w0)[2:].zfill(8),16)

#Number of keys to generate
numKeys = 1000

#File to write vectors to
tvFile = open("tv.txt","w")

for i in range(1000//10):
    #Set prevkey to starting key
    #initialKey = random.randint(1000,2**256-1)
    initialKey = 0x01
    initialKey_hex = hex(initialKey)[2:].zfill(64)
    prevKey = int(initialKey_hex[:len(initialKey_hex)//2],16)
    currentKey = int(initialKey_hex[len(initialKey_hex)//2:],16)

    
    for round in range(2,11):
        #Generate output
        roundKey = gen_roundkey(prevKey,currentKey,round)


        #Convert values to hex        
        prevKey_hex = hex(prevKey)[2:].zfill(32)
        roundKey_hex = hex(roundKey)[2:].zfill(32)
        round_hex = hex(round)[2:].zfill(1)
            
        #Set prevkey to current roundkey
        prevKey = currentKey
        currentKey = roundKey
       
        
        
        
        #Write out hex value to file
        tvFile.write("%s_%s_%s\n" % (round_hex,prevKey_hex,roundKey_hex))
        
        








