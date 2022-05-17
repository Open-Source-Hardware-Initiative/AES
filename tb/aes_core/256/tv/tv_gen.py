from Crypto.Cipher import AES
import binascii
import random

def encrypt(key,plaintext):
    cipher = AES.new(key, AES.MODE_ECB)
    msg = cipher.encrypt(plaintext.to_bytes(16,'big'))
    hex_out = str(binascii.hexlify(msg))
    return hex_out[2:-1]

def decrypt(key,ciphertext):
    decipher = AES.new(key, AES.MODE_ECB)
    deciphered = (decipher.decrypt(ciphertext.to_bytes(16,'big')))
    hex_out = str(binascii.hexlify(deciphered))
    return hex_out[2:-1]
    

#Number of vectors to generate
vecNum = 100000
#File to write vectors to
tvFile = open("tv.txt","w")

for i in range(vecNum):
    #Generate Inputs
    key_in = random.randint(1000,2**256-1)
    plaintext = random.randint(1000,2**128-1)
    key = key_in.to_bytes(32,'big')
    #Encrypt Decrypt
    ciphertext_out = encrypt(key,plaintext)
    plaintext_out = decrypt(key,int(ciphertext_out,16))
    
    #Outputs to hex
    ciphertext_hex = ciphertext_out.zfill(32)
    plaintext_hex = plaintext_out.zfill(32)
    key_hex = hex(key_in)[2:].zfill(64)
    
    #Write to file
    tvFile.write("%s_%s_%s\n" % (key_hex,ciphertext_hex,plaintext_hex))
