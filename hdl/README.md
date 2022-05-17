# Purpose
This directory contains the HDL (Hardware Descriptive Language) for the design.
Feel free to ask any questions here on github. 


# Modules


| Module Name      | Module Purpose |
| ----------- | ----------- |
| aes_addroundkey | Module for accomplishing AES add round key operation with 128 bit width |
| aes_core_gen   | The generalized AES core which supports both AES-128 and AES-256 in current iterations        |
| aes_core_128 | Legacy core that is currently non-functional |
| aes_fsm_128 | Legacy FSM for 128 bit key only variant |
| aes_fsm_gen | Generalized FSM which supports both AES-128 and AES-256 |
| inv_mixword | Applies AES Mix Word Operation to a single 32 bit word
| aes_inv_mixcols | Applies AES Mixcolumns to entire 128 bit state | 
| aes_inv_rounddata | AES Inverse Rounddata Operation |
| aes_inv_sbox_128 | 128-bit wide inverse Rijndael Substitution Box |
| aes_inv_sbox | 8-bit wide inverse Rijndael Substitution Box |
| aes_inv_sbox_word | 32-bit wide inverse Rijndael Substitution Box |
| aes_inv_shiftrow | AES Inverse Shift Rows bit manipulation module |
| aes_key_xor | AES Key XOR and round constant computation |
| rcon_lut_128 | Lookup table variant of Round Constant computation |
| mixword | Applies 32-bit Mix Word operation to a 32-bit word of the state |
| aes_mixcolumns | Applies 128-bit wide mix columns operation to the entirety of the state |
| aesRotateWord | Applies the rotate operation on a single word (For Key Scheduler) | 
| aes_roundkey_gen | Contains logic for converting basic single round key generation to 128/256 round key generation |
| aes_roundkey_gen_legacy | Legacy variant of the roundkey generation, used before decipher_key_mem was a thing |
| aes_roundkey | Computes a single round's key |
| aes_rounddata | Computes a single forward round data computation |
| aes_sbox_128 | 128-bit wide forward substitution box |
| aes_sbox | 8-bit wide forward substitution box |
| aes_sbox_word | 32-bit wide forward substitution box |
| aes_shiftrow | 128-bit wide shiftrows bit manipulation |
| decipher_key_mem | Memory for storing decipher reverse key schedule |
| gmX | Accomplishes Galois multiplication in field GF(2^8) by X | 





