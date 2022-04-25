/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains 4 sets of the Rijndael SBOX so a whole word
*	    can be looked up simultaneously
*/


module aes_sbox_word(input logic [31:0] in,
		     output logic [31:0] out);
		     
		     
		     
		//Declare the SBOX for (least significant) byte 0 of the input
		aes_sbox sbox_b0(.in(in[7:0]),
				 .out(out[7:0]));
		//Declare the SBOX for byte 1 of the input
		aes_sbox sbox_b1(.in(in[15:8]),
				 .out(out[15:8]));
		//Declare the SBOX for byte 2 of the input
		aes_sbox sbox_b2(.in(in[23:16]),
				 .out(out[23:16]));	
		//Declare the SBOX for byte 3 of the input	
		aes_sbox sbox_b3(.in(in[31:24]),
				 .out(out[31:24]));
		
endmodule


module aes_sbox_word_g113(input logic [31:0] in,
		     output logic [31:0] out);
		     
		     
		     
		//Declare the SBOX for (least significant) byte 0 of the input
		aes_sbox_g113 sbox_b0(.in(in[7:0]),
				 .out(out[7:0]));
		//Declare the SBOX for byte 1 of the input
		aes_sbox_g113 sbox_b1(.in(in[15:8]),
				 .out(out[15:8]));
		//Declare the SBOX for byte 2 of the input
		aes_sbox_g113 sbox_b2(.in(in[23:16]),
				 .out(out[23:16]));	
		//Declare the SBOX for byte 3 of the input	
		aes_sbox_g113 sbox_b3(.in(in[31:24]),
				 .out(out[31:24]));
		
endmodule



module aes_sbox_word_g115(input logic [31:0] in,
		     output logic [31:0] out);
		     
		     
		     
		//Declare the SBOX for (least significant) byte 0 of the input
		aes_sbox_g115 sbox_b0(.in(in[7:0]),
				 .out(out[7:0]));
		//Declare the SBOX for byte 1 of the input
		aes_sbox_g115 sbox_b1(.in(in[15:8]),
				 .out(out[15:8]));
		//Declare the SBOX for byte 2 of the input
		aes_sbox_g115 sbox_b2(.in(in[23:16]),
				 .out(out[23:16]));	
		//Declare the SBOX for byte 3 of the input	
		aes_sbox_g115 sbox_b3(.in(in[31:24]),
				 .out(out[31:24]));
		
endmodule



module aes_sbox_word_g128(input logic [31:0] in,
		     output logic [31:0] out);
		     
		     
		     
		//Declare the SBOX for (least significant) byte 0 of the input
		aes_sbox_g128 sbox_b0(.in(in[7:0]),
				 .out(out[7:0]));
		//Declare the SBOX for byte 1 of the input
		aes_sbox_g128 sbox_b1(.in(in[15:8]),
				 .out(out[15:8]));
		//Declare the SBOX for byte 2 of the input
		aes_sbox_g128 sbox_b2(.in(in[23:16]),
				 .out(out[23:16]));	
		//Declare the SBOX for byte 3 of the input	
		aes_sbox_g128 sbox_b3(.in(in[31:24]),
				 .out(out[31:24]));
		
endmodule
