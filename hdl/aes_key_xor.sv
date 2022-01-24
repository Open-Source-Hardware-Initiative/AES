/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains the XOr used for AES key expansion.
* 	    this generates all four words of the next round key
*	    It uses the input of the new word that has been shifted
*	    and SBOXed(keyBox_out) as well as operating on the previously
*	    generated words (via the old_key). 
*	    NOTE: this module might only work for AES256?
https://crypto.stackexchange.com/questions/81712/rcon-for-aes-192-and-256
*	    This module uses components of the even odd method for
*	    key expansion : https://ieeexplore.ieee.org/document/6125708
*/

module aes_key_xor(input logic [3:0] RD,//Round Number
		   input logic [1:0] mode, //00 for 128 01 for 192 and 10 for 256
		   input logic [31:0] keyBox_out, //Output of SBOX
		   input logic [127:0]  old_key, //Previous Round Key
		   output logic [127:0] new_key); //New Round Key

			//Declare the intermediary variables
			logic [7:0] roundCon_odd;
			logic [7:0] roundCon_even;
			logic [7:0] rcon_256;
			logic [7:0] rcon_128;
			logic [7:0] rcon_192;
			logic [7:0] rcon_mux;
			logic [31:0] rcon;
			logic roundCon_first;

			logic [31:0] key_w0;
			logic [31:0] key_w1;
			logic [31:0] key_w2;
			logic [31:0] key_w3;



			//Signal to detect round 1
			assign roundCon_first = ~(RD[3] | RD[2] | RD[1]) & RD[0];	
			//Select between the shifted or nonshifted outputs for odd even generation.
			assign rcon_256 = roundCon_first ? 8'h01 : (RD[0] ? 8'h00 << RD[3:1] : 8'h01 << (RD[3:1] -1));
			//Use LUT for rcon_128
			rcon_lut_128 lut_128(.RD(RD),.rcon_out(rcon_128));
			//Select between AES128 and AES256 round constants (This will need to be changed to add 192)
			assign rcon_mux = mode[1] ? rcon_256 : rcon_128;
			
			//Extend rcon to get the correct value to XOR in
			assign rcon = {rcon_mux, 24'h000000};
			

			//Word 0 [31:0] (newest word) should be XOR'ed with all of the words of the old key and RCON
			assign key_w0 = keyBox_out ^ old_key[127:96] ^ old_key[95:64] ^ old_key[63:32] ^ old_key[31:0] ^ rcon;
			//Word 1 [32:63] should be XOR'ed with the 3 upper words of the old key and RCON
			assign key_w1 = keyBox_out ^ old_key[127:96] ^ old_key[95:64] ^ old_key[63:32] ^ rcon;
			//Word 2 [95:64] should be XOR'ed with the 2 upper word of the old key and RCON
			assign key_w2 = keyBox_out ^ old_key[127:96] ^ old_key[95:64] ^ rcon;
			//Word 3 [127:96] should be XOR'ed with the upper word of the old key and RCON
			assign key_w3 = keyBox_out ^ old_key[127:96] ^ rcon;
			
			assign new_key = {key_w3,key_w2,key_w1,key_w0};
endmodule



//Use a lookup table for 128 bit round constants for now.
//These were obtained from : https://en.wikipedia.org/wiki/AES_key_schedule
module rcon_lut_128(input logic [3:0] RD,
			output logic [7:0] rcon_out);
	
			always_comb
			  begin
			  
				case(RD)
				  8'h01 : rcon_out = 8'h01;
				  8'h02 : rcon_out = 8'h02;
				  8'h03 : rcon_out = 8'h04;
				  8'h04 : rcon_out = 8'h08;
				  8'h05 : rcon_out = 8'h10;
				  8'h06 : rcon_out = 8'h20;
				  8'h07 : rcon_out = 8'h40;
				  8'h08 : rcon_out = 8'h80;
				  8'h09 : rcon_out = 8'h1B;
				  8'h0A : rcon_out = 8'h36;
				  default : rcon_out = 8'h00;

				
				
				
				endcase
			  
			  
			  end
			
endmodule //rcon_lut_128	
