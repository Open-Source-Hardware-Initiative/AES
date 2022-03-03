/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This module calculates 14 round keys for use in the
*	    generalized AES implementation and also implements
	    mode switching for different AES key sizes
*/

//TODO why not just make it take round as input and give one key


module aes_roundkey_gen_notbad(input logic [1:0] mode, //00 for AES-128 01 for AES_192 10 for AES_256
		       input logic [255:0] key_in,
		       input logic [3:0] dec_key_schedule_round, round,
		       input logic dec_key_gen,
		       output logic [127:0] round_key [14:0]);
		
		logic [127:0] round_key_internal [14:0];
		//Intermediary round key for 256 bit case
		logic [127:0] rk1_tmp, rk1_256;
		logic prev_key_offset;

		
		//The first (Round 0) key is the input key
		assign round_key_internal[0] = key_in[255:128];


		assign prev_key_offset = mode[1] ? 1'b1 : 1'b0;

        //Mux between encrypt gen and decrypt round values
        assign round_in = dec_key_gen ? dec_key_schedule_round : round;

		//Calculate the round_key for round 1
		aes_roundkey rk_1(.RD(round_in),
				  .mode(mode),
				  .prev_key(key_in[127:0]),
				  .current_key(key_in[127:0]),
				  .round_key(rk1_tmp));
				  
endmodule


module aes_roundkey_gen(input logic [1:0] mode, //00 for AES-128 01 for AES_192 10 for AES_256
		       input logic [255:0] key_in,
		       output logic [127:0] round_key [14:0]);
		
		logic [127:0] round_key_internal [14:0];
		//Intermediary round key for 256 bit case
		logic [127:0] rk1_tmp, rk1_256;
		logic prev_key_offset;
		
		//The first (Round 0) key is the input key
		assign round_key_internal[0] = key_in[255:128];
		
		//This offset is used for when we need to change the selected index of the array
		//TODO : THIS IS REALLY BEHAVIORAL AND SHOULD BE CHANGED AT SOME POINT
		assign prev_key_offset = mode[1] ? 1'b1 : 1'b0;

		//Calculate the round_key for round 1
		aes_roundkey rk_1(.RD(4'h1),
				  .mode(mode),
				  .prev_key(round_key_internal[0]),
				  .current_key(round_key_internal[0]),
				  .round_key(rk1_tmp));
		//Use either the round key for round 1 (calculated) or upper half of 256 bit key
		assign round_key_internal[1] = mode[1] ? key_in[127:0] : rk1_tmp;

		//Calculate the round_key for round 2				 
		aes_roundkey rk_2(.RD(4'h2),
				  .mode(mode),
				  .prev_key(round_key_internal[1- prev_key_offset] ),
				  .current_key(round_key_internal[1]),
				  .round_key(round_key_internal[2]));

		//Calculate the round_key for round 3			
		aes_roundkey rk_3(.RD(4'h3),
				  .mode(mode),
				  .prev_key(round_key_internal[2  - prev_key_offset]),
				  .current_key(round_key_internal[2]),
				  .round_key(round_key_internal[3]));

		//Calculate the round_key for round 4				 
		aes_roundkey rk_4(.RD(4'h4),
				  .mode(mode),
				  .prev_key(round_key_internal[3 - prev_key_offset]),
				  .current_key(round_key_internal[3]),
				  .round_key(round_key_internal[4]));

		//Calculate the round_key for round 5				  
		aes_roundkey rk_5(.RD(4'h5),
				  .mode(mode),
				  .prev_key(round_key_internal[4 - prev_key_offset]),
				  .current_key(round_key_internal[4]),
				  .round_key(round_key_internal[5]));

		//Calculate the round_key for round 6				  
		aes_roundkey rk_6(.RD(4'h6),
				  .mode(mode),
				  .prev_key(round_key_internal[5 - prev_key_offset]),
				  .current_key(round_key_internal[5]),
				  .round_key(round_key_internal[6]));

		//Calculate the round_key for round 7				  
		aes_roundkey rk_7(.RD(4'h7),
				  .mode(mode),
				  .prev_key(round_key_internal[6 - prev_key_offset]),
				  .current_key(round_key_internal[6]),
				  .round_key(round_key_internal[7]));

		//Calculate the round_key for round 8				  
		aes_roundkey rk_8(.RD(4'h8),
				  .mode(mode),
				  .prev_key(round_key_internal[7 - prev_key_offset]),
				  .current_key(round_key_internal[7]),
				  .round_key(round_key_internal[8]));

		//Calculate the round_key for round 9				  
		aes_roundkey rk_9(.RD(4'h9),
				  .mode(mode),
				  .prev_key(round_key_internal[8 - prev_key_offset]),
				  .current_key(round_key_internal[8]),
				  .round_key(round_key_internal[9]));

		//Calculate the round_key for round A				  
		aes_roundkey rk_A(.RD(4'hA),
				  .mode(mode),
				  .prev_key(round_key_internal[9 - prev_key_offset]),
				  .current_key(round_key_internal[9]),
				  .round_key(round_key_internal[10]));
				
		//Calculate the round_key for round B				  
		aes_roundkey rk_B(.RD(4'hB),
				  .mode(mode),
				  .prev_key(round_key_internal[10 - prev_key_offset]),
				  .current_key(round_key_internal[10]),
				  .round_key(round_key_internal[11]));
				 
		//Calculate the round_key for round C
		aes_roundkey rk_C(.RD(4'hC),
				  .mode(mode),
				  .prev_key(round_key_internal[11 - prev_key_offset]),
				  .current_key(round_key_internal[11]),
				  .round_key(round_key_internal[12]));
				  
		//Calculate the round_key for round D				  
		aes_roundkey rk_D(.RD(4'hD),
				  .mode(mode),
				  .prev_key(round_key_internal[12 - prev_key_offset]),
				  .current_key(round_key_internal[12]),
				  .round_key(round_key_internal[13]));
				  
		//Calculate the round_key for round E				  
		aes_roundkey rk_E(.RD(4'hE),
				  .mode(mode),
				  .prev_key(round_key_internal[13 - prev_key_offset]),
				  .current_key(round_key_internal[13]),
				  .round_key(round_key_internal[14]));

		
		assign round_key = round_key_internal;
			
endmodule
