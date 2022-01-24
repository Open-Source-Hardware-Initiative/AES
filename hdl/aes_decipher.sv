/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This module contains a complete encipher core for an AES unit.
*/



module aes_decipher(input logic [3:0] round,
		     input logic [1:0] mode, //00 for 128 01 for 192 and 10 for 256
		     input logic [127:0] prev_key,
		     input logic [127:0] current_key,
		     input logic [127:0] data_in,
		     input logic [127:0] round_key, 
		     output logic [127:0] data_out);
		     
		     
		     
		     //AES datapath
		     aes_inv_rounddata rddata(.round(round),
		     			      .mode(mode),
		     			      .round_key(round_key),
		     			      .data_in(data_in),
		     			      .data_out(data_out));
endmodule
