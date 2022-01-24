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



/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This module does 14 round key calculations.
	    this allows for calculation of the entire key
	    schedule for decryption. Since we have to 
	    do the entire key schedule in reverse it is
	    better to calculate it all at once.
*/
module aes_roundkey_128(input logic [1:0] mode, //00 for AES-128 01 for AES_192 10 for AES_256
		       input logic [127:0] key_in,
		       output logic [127:0] round_key [10:0]);
		
		logic [127:0] round_key_internal [10:0];
		
		//The first (Round 0) key is the input key
		assign round_key_internal[0] = key_in;

		//Calculate the round_key for round 1
		aes_roundkey rk_1(.RD(4'h1),
				  .mode(mode),
				  .prev_key(round_key_internal[0]),
				  .current_key(round_key_internal[0]),
				  .round_key(round_key_internal[1]));

		//Calculate the round_key for round 2				 
		aes_roundkey rk_2(.RD(4'h2),
				  .mode(mode),
				  .prev_key(round_key_internal[1]),
				  .current_key(round_key_internal[1]),
				  .round_key(round_key_internal[2]));

		//Calculate the round_key for round 3			
		aes_roundkey rk_3(.RD(4'h3),
				  .mode(mode),
				  .prev_key(round_key_internal[2]),
				  .current_key(round_key_internal[2]),
				  .round_key(round_key_internal[3]));

		//Calculate the round_key for round 4				 
		aes_roundkey rk_4(.RD(4'h4),
				  .mode(mode),
				  .prev_key(round_key_internal[3]),
				  .current_key(round_key_internal[3]),
				  .round_key(round_key_internal[4]));

		//Calculate the round_key for round 5				  
		aes_roundkey rk_5(.RD(4'h5),
				  .mode(mode),
				  .prev_key(round_key_internal[4]),
				  .current_key(round_key_internal[4]),
				  .round_key(round_key_internal[5]));

		//Calculate the round_key for round 6				  
		aes_roundkey rk_6(.RD(4'h6),
				  .mode(mode),
				  .prev_key(round_key_internal[5]),
				  .current_key(round_key_internal[5]),
				  .round_key(round_key_internal[6]));

		//Calculate the round_key for round 7				  
		aes_roundkey rk_7(.RD(4'h7),
				  .mode(mode),
				  .prev_key(round_key_internal[6]),
				  .current_key(round_key_internal[6]),
				  .round_key(round_key_internal[7]));

		//Calculate the round_key for round 8				  
		aes_roundkey rk_8(.RD(4'h8),
				  .mode(mode),
				  .prev_key(round_key_internal[7]),
				  .current_key(round_key_internal[7]),
				  .round_key(round_key_internal[8]));

		//Calculate the round_key for round 9				  
		aes_roundkey rk_9(.RD(4'h9),
				  .mode(mode),
				  .prev_key(round_key_internal[8]),
				  .current_key(round_key_internal[8]),
				  .round_key(round_key_internal[9]));

		//Calculate the round_key for round A				  
		aes_roundkey rk_A(.RD(4'hA),
				  .mode(mode),
				  .prev_key(round_key_internal[9]),
				  .current_key(round_key_internal[9]),
				  .round_key(round_key_internal[10]));
		

		
		assign round_key = round_key_internal;
			
endmodule
