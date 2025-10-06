`define alchemy_family_aes_roundkey "aes_roundkey"

/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This module calculates a single forward roundkey for AES through combination
*	    of shift rows, byte substitution, and key XOR
*/



module aes_roundkey(input logic [3:0] RD,
		    input logic [1:0] mode,
		    input logic [127:0] prev_key,
		    input logic [127:0] current_key,
		    output logic [127:0] round_key);
		    
		    
		    logic disableRotate;
		    
		    //Intermediary logic
		    logic [31:0] rotWord;
		    logic [31:0] keyBox_out;
		    
		    
		    
		    //Change the rotate disable depending on type of AES used
		    always_comb
		      begin
		    	case(mode)
		    	  2'b00 : disableRotate = 1'b0;
		    	  2'b01 : disableRotate = 1'b0;
		    	  2'b10 : disableRotate = RD[0];
		    	  default : disableRotate = 1'b0;
		    	endcase
		      end

			//If we are in AES256 and it is first round then the round key is
			//just current key
		    
		    
		    //Circularly rotate the lowest word of the current key
		    aesRotateWord rotate(.disableRotate(disableRotate),
		    			  .inWord(current_key[31:0]),
		    			  .rotWord(rotWord));
		    			  
		    //Run the rotated word through the SBOX
		    aes_sbox_word sbox(.in(rotWord),
		    		       .out(keyBox_out));
		    		       	       
		    //Run the subsituted word through the key_XOR process
		    aes_key_xor key_xor(.RD(RD),
		    			.mode(mode),
		    			.keyBox_out(keyBox_out),
		    			.old_key(prev_key),
		    			.new_key(round_key));
		    			
endmodule



