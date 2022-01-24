/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This module contains a complete encipher core for an AES unit.
*/



module aes_encipher(input logic [3:0] round,
		     input logic [1:0] mode, //00 for 128 01 for 192 and 10 for 256
		     input logic [127:0] prev_key,
		     input logic [127:0] current_key,
		     input logic [127:0] data_in,
		     output logic [127:0] data_out,
		     output logic [127:0] round_key);
		     
		     
			logic [127:0] round_key_sched;

		     //Key scheduler logic. One per core.
		     aes_roundkey keysched(.RD(round),
		     			   .mode(mode),
		     			   .prev_key(prev_key),
		     			   .current_key(current_key),
		     			   .round_key(round_key));


			//Check round 1
			//assign roundOne = ~round[3] & ~round[2] & ~round[1] & round[0];
			//assign round_key = (mode[1] & roundOne) ? current_key : round_key_sched;


		     //AES datapath
		     aes_rounddata rddata(.round(round),
		     			  .mode(mode),
		     			  .round_key(round_key),
		     			  .data_in(data_in),
		     			  .data_out(data_out));
endmodule
