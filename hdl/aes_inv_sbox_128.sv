/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains a 128 bit inverse substitution box
	    which is comprised of 4x 32 bit inverse substitution boxes
*/

module aes_inv_sbox_128(input logic [127:0] in,
		     output logic [127:0] out);
		     
		     
		//Declare the SBOX for (least significant) word 0 of the input
		aes_inv_sbox_word sbox_w0(.in(in[31:0]),
				      .out(out[31:0]));
		//Declare the SBOX for word 1 of the input
		aes_inv_sbox_word sbox_w1(.in(in[63:32]),
				      .out(out[63:32]));
		//Declare the SBOX for word 2 of the input
		aes_inv_sbox_word sbox_w2(.in(in[95:64]),
				      .out(out[95:64]));	
		//Declare the SBOX for word 3 of the input	
		aes_inv_sbox_word sbox_w3(.in(in[127:96]),
				      .out(out[127:96]));
				 
endmodule
