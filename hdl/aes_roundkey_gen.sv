`define alchemy_family_aes_roundkey_gen "aes_roundkey_gen"

/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This module calculates 14 round keys for use in the
*	    generalized AES implementation and also implements
	    mode switching for different AES key sizes
*/

//TODO why not just make it take round as input and give one key


module aes_roundkey_gen(input logic [1:0] mode, //00 for AES-128 01 for AES_192 10 for AES_256
		       input logic [255:0] key_in,
		       input logic [3:0] round,
		       output logic [127:0] round_key);
		
		logic [127:0] round_key_internal;

		logic [127:0] key_r0,key_r1;
		logic [127:0] prev_key;

        //TODO I don't really like using a case statement here
  		    always_comb
		      begin
		    	case(round)
		    	  4'h0 : round_key = key_r0;
		    	  4'h1 : round_key = key_r1;
		    	  default : round_key = round_key_internal;
		    	endcase
		      end
      
        
        //Flags to check for round 0 or round 1 case
        assign r0_flag = ~(|round[3:0]);
        assign r1_flag = ~(|round[3:1]) & round[0];
        
        assign key_r0 = mode[1] ? key_in[255:128] : key_in[127:0];
        assign key_r1 = mode[1] ? key_in[127:0] : round_key_internal;

        assign prev_key = mode[1] ? key_in[255:128] : key_in[127:0];
		//Calculate the round_key for round 1
		aes_roundkey rk_1(.RD(round),
				  .mode(mode),
				  .prev_key(prev_key),
				  .current_key(key_in[127:0]),
				  .round_key(round_key_internal));
				  
endmodule


