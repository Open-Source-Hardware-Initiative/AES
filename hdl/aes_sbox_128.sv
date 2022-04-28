/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains a 128 bit substitution box
	    which is comprised of 4x 32 bit substitution boxes
*/

module aes_sbox_128(input logic [127:0] in,
		     output logic [127:0] out);
		     
		     
		//Declare the SBOX for (least significant) word 0 of the input
		aes_sbox_word sbox_w0(.in(in[31:0]),
				      .out(out[31:0]));
		//Declare the SBOX for word 1 of the input
		aes_sbox_word sbox_w1(.in(in[63:32]),
				      .out(out[63:32]));
		//Declare the SBOX for word 2 of the input
		aes_sbox_word sbox_w2(.in(in[95:64]),
				      .out(out[95:64]));	
		//Declare the SBOX for word 3 of the input	
		aes_sbox_word sbox_w3(.in(in[127:96]),
				      .out(out[127:96]));
				 
endmodule



/*
*
*
* 128 bit canright sbox
*
*
*/

module aes_sbox_128_canright(input logic [127:0] in,
		     output logic [127:0] out);
		     
		     
		//Declare the SBOX for (least significant) word 0 of the input
		aes_sbox_word_canright sbox_w0(.in(in[31:0]),
				      .out(out[31:0]));
		//Declare the SBOX for word 1 of the input
		aes_sbox_word_canright sbox_w1(.in(in[63:32]),
				      .out(out[63:32]));
		//Declare the SBOX for word 2 of the input
		aes_sbox_word_canright sbox_w2(.in(in[95:64]),
				      .out(out[95:64]));	
		//Declare the SBOX for word 3 of the input	
		aes_sbox_word_canright sbox_w3(.in(in[127:96]),
				      .out(out[127:96]));
				 
endmodule


/*
*
*
* 128 bit NIST g113 sbox
*
*
*/
module aes_sbox_128_g113(input logic [127:0] in,
		     output logic [127:0] out);
		     
		     
		//Declare the SBOX for (least significant) word 0 of the input
		aes_sbox_word_g113 sbox_w0(.in(in[31:0]),
				      .out(out[31:0]));
		//Declare the SBOX for word 1 of the input
		aes_sbox_word_g113 sbox_w1(.in(in[63:32]),
				      .out(out[63:32]));
		//Declare the SBOX for word 2 of the input
		aes_sbox_word_g113 sbox_w2(.in(in[95:64]),
				      .out(out[95:64]));	
		//Declare the SBOX for word 3 of the input	
		aes_sbox_word_g113 sbox_w3(.in(in[127:96]),
				      .out(out[127:96]));
				 
endmodule

/*
*
*
* 128 bit NIST g115 sbox
*
*
*/
module aes_sbox_128_g115(input logic [127:0] in,
		     output logic [127:0] out);
		     
		     
		//Declare the SBOX for (least significant) word 0 of the input
		aes_sbox_word_g115 sbox_w0(.in(in[31:0]),
				      .out(out[31:0]));
		//Declare the SBOX for word 1 of the input
		aes_sbox_word_g115 sbox_w1(.in(in[63:32]),
				      .out(out[63:32]));
		//Declare the SBOX for word 2 of the input
		aes_sbox_word_g115 sbox_w2(.in(in[95:64]),
				      .out(out[95:64]));	
		//Declare the SBOX for word 3 of the input	
		aes_sbox_word_g115 sbox_w3(.in(in[127:96]),
				      .out(out[127:96]));
				 
endmodule

/*
*
*
* 128 bit NIST g128 sbox
*
*
*/

module aes_sbox_128_g128(input logic [127:0] in,
		     output logic [127:0] out);
		     
		     
		//Declare the SBOX for (least significant) word 0 of the input
		aes_sbox_word_128 sbox_w0(.in(in[31:0]),
				      .out(out[31:0]));
		//Declare the SBOX for word 1 of the input
		aes_sbox_word_128 sbox_w1(.in(in[63:32]),
				      .out(out[63:32]));
		//Declare the SBOX for word 2 of the input
		aes_sbox_word_128 sbox_w2(.in(in[95:64]),
				      .out(out[95:64]));	
		//Declare the SBOX for word 3 of the input	
		aes_sbox_word_128 sbox_w3(.in(in[127:96]),
				      .out(out[127:96]));
				 
endmodule
