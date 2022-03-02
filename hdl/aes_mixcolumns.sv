/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains the "mix columns" operation for AES.
*	    The "mix columns" operation is essentially composed of a
*	    nice little galois field multiplication (of 1, 2 or 3) in the field
*	    x^8 + x^4 + x^3 + x + 1.
*	    The actual matrix you multiply by is
*	    [2 3 1 1][a_0,j]
*	    [1 2 3 1][a_1,j]
*	    [1 1 2 3][a_2,j]
*           [3 1 1 2][a_3,j]
*I used the secworks repo for reference here as it gets a little mathy
*/
`include "./galois_func.sv"

module aes_mixcolumns(data, mixedcols);

   //Declare Inputs/Outputs
   input  logic [127:0] data;
   output logic [127:0] mixedcols;

   //Declare internal Logic
   logic [31:0] 	w0, w1, w2, w3;
   logic [31:0] 	ws0, ws1, ws2, ws3;
   
   //Break up data into individual words
   assign w0 = data[127:96];
   assign w1 = data[95:64];
   assign w2 = data[63:32];
   assign w3 = data[31:0];

   //Instantiate The mix words components for the words
   mixword mw0(.word(w0),
	       .mixed_word(ws0));
   mixword mw1(.word(w1),
	       .mixed_word(ws1));
   mixword mw2(.word(w2),
	       .mixed_word(ws2));
   mixword mw3(.word(w3),
	       .mixed_word(ws3));


   //Assign Output
   assign mixedcols = {ws0, ws1, ws2, ws3};

endmodule // mixcolumns


//This applies the galois field operations to an individual 32 bit word.
module mixword (word, mixed_word);
   
   //Declare Inputs/Outputs
   input logic [31:0] word;
   output logic [31:0] mixed_word;

   //Declare Internal Signals
   logic [7:0] 	       b0, b1, b2, b3;
   logic [7:0] 	       mb0, mb1, mb2, mb3;

   logic [7:0] 	       gm2_0_out;
   logic [7:0] 	       gm3_0_out;

   logic [7:0] 	       gm2_1_out;
   logic [7:0] 	       gm3_1_out;

   logic [7:0] 	       gm2_2_out;
   logic [7:0] 	       gm3_2_out;
   
   logic [7:0] 	       gm2_3_out;
   logic [7:0] 	       gm3_3_out;


   //Break word into bytes
   assign b0 = word[31:24];
   assign b1 = word[23:16];
   assign b2 = word[15:8];
   assign b3 = word[7:0];

   //mb0 galois components
   gm2 gm2_0(.gm2_in(b0),
	     .gm2_out(gm2_0_out));
   gm3 gm3_0(.gm3_in(b1),
	     .gm3_out(gm3_0_out));


   //mb1 galois components
   gm2 gm2_1(.gm2_in(b1),
	     .gm2_out(gm2_1_out));
   gm3 gm3_1(.gm3_in(b2),
	     .gm3_out(gm3_1_out));

   //mb2 galois components
   gm2 gm2_2(.gm2_in(b2),
	     .gm2_out(gm2_2_out));
   gm3 gm3_2(.gm3_in(b3),
	     .gm3_out(gm3_2_out));

   //mb3 galois components
   gm2 gm2_3(.gm2_in(b3),
	     .gm2_out(gm2_3_out));
   gm3 gm3_3(.gm3_in(b0),
	     .gm3_out(gm3_3_out));

   //Combine Componenets into mixed word
   assign mb0 = gm2_0_out ^ gm3_0_out ^ b2 ^ b3;
   assign mb1 = gm2_1_out ^ gm3_1_out ^ b0 ^ b3;
   assign mb2 = gm2_2_out ^ gm3_2_out ^ b0 ^ b1;
   assign mb3 = gm2_3_out ^ gm3_3_out ^ b1 ^ b2;

   assign mixed_word = {mb0, mb1, mb2, mb3};
endmodule




