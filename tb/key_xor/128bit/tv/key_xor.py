import random

rcon_128 = [0x01,0x02,0x04,0x08,0x10,0x20,0x40,0x80,0x1B,0x36]


def key_xor(key,sbox_out,roundNum):
    key_bin = bin(key)[2:].zfill(128)
    sbox_out_bin = bin(sbox_out)[2:].zfill(32)
    roundNum_bin = bin(roundNum)[2:].zfill(4)
    

    #Split key into 32 bit words
    key_bin_split =  [int(key_bin[i:i+32],2) for i in range(0, len(key_bin), 32)]
    
    #Get rcon from table and bitshift by 24
    rcon = rcon_128[roundNum-1] << 24
    
    
    #Recombine
    out_w0 = sbox_out ^ key_bin_split[3] ^ key_bin_split[2] ^ key_bin_split[1] ^ key_bin_split[0] ^ rcon
    out_w1 = sbox_out ^ key_bin_split[2] ^ key_bin_split[1] ^ key_bin_split[0] ^ rcon
    out_w2 = sbox_out ^ key_bin_split[1] ^ key_bin_split[0] ^ rcon
    out_w3 = sbox_out ^ key_bin_split[0] ^ rcon
    

    
    return int(hex(out_w3)[2:].zfill(8) + hex(out_w2)[2:].zfill(8) + hex(out_w1)[2:].zfill(8) + hex(out_w0)[2:].zfill(8),16)

    
#Number of vectors to generate
numbervecs = 10000
#File to write vectors to
tvFile = open("tv.txt","w")



for i in range(numbervecs):
    inputKey = random.randint(1000,2**128-1)
    sbox_out = random.randint(1000,2**32-1)
    roundNum = random.randint(1,9)
    result = key_xor(inputKey,sbox_out,roundNum)
    
    
    
    #Convert to hex
    inputKey_hex = hex(inputKey)[2:].zfill(32)
    sbox_out_hex = hex(sbox_out)[2:].zfill(8)
    roundnum_hex     = hex(roundNum)[2:]
    result_hex = hex(result)[2:].zfill(32)
    
    
    
    tvFile.write("%s_%s_%s_%s\n" % (inputKey_hex,sbox_out_hex,roundnum_hex,result_hex))
