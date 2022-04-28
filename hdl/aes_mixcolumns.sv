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





module aes_mixcolumns_min(data, mixedcols);

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
   aes_mixword_min mw0(.word(w0),
	       .mixed_word(ws0));
   aes_mixword_min mw1(.word(w1),
	       .mixed_word(ws1));
   aes_mixword_min mw2(.word(w2),
	       .mixed_word(ws2));
   aes_mixword_min mw3(.word(w3),
	       .mixed_word(ws3));


   //Assign Output
   assign mixedcols = {ws0, ws1, ws2, ws3};

endmodule // mixcolumns



/*
*
*
* Circuit Minimized mixword operation from https://eprint.iacr.org/2019/833
*
*
*/

module aes_mixword_min(input logic [31:0] word,
		  output logic [31:0] mixed_word);

	logic [59:0] t;
	logic [31:0] x;
	logic [31:0] y;

	assign x = word;

	assign t[0] = x[0] ^  x[8];
	assign t[1] = x[16] ^  x[24];
	assign t[2] = x[1] ^  x[9];
	assign t[3] = x[17] ^  x[25];
	assign t[4] = x[2] ^  x[10];
	assign t[5] = x[18] ^  x[26];
	assign t[6] = x[3] ^  x[11];
	assign t[7] = x[19] ^  x[27];
	assign t[8] = x[4] ^  x[12];
	assign t[9] = x[20] ^  x[28];
	assign t[10] = x[5] ^  x[13];
	assign t[11] = x[21] ^  x[29];
	assign t[12] = x[6] ^  x[14];
	assign t[13] = x[22] ^  x[30];
	assign t[14] = x[23] ^  x[31];
	assign t[15] = x[7] ^  x[15];
	assign t[16] = x[8] ^  t[1];
	assign y[0] = t[15] ^  t[16];
	assign t[17] = x[7] ^  x[23];
	assign t[18] = x[24] ^  t[0];
	assign y[16] = t[14] ^  t[18];
	assign t[19] = t[1] ^  y[16];
	assign y[24] = t[17] ^  t[19];
	assign t[20] = x[27] ^  t[14];
	assign t[21] = t[0] ^  y[0];
	assign y[8] = t[17] ^  t[21];
	assign t[22] = t[5] ^  t[20];
	assign y[19] = t[6] ^  t[22];
	assign t[23] = x[11] ^  t[15];
	assign t[24] = t[7] ^  t[23];
	assign y[3] = t[4] ^  t[24];
	assign t[25] = x[2] ^  x[18];
	assign t[26] = t[17] ^  t[25];
	assign t[27] = t[9] ^  t[23];
	assign t[28] = t[8] ^  t[20];
	assign t[29] = x[10] ^  t[2];
	assign y[2] = t[5] ^  t[29];
	assign t[30] = x[26] ^  t[3];
	assign y[18] = t[4] ^  t[30];
	assign t[31] = x[9] ^  x[25];
	assign t[32] = t[25] ^  t[31];
	assign y[10] = t[30] ^  t[32];
	assign y[26] = t[29] ^  t[32];
	assign t[33] = x[1] ^  t[18];
	assign t[34] = x[30] ^  t[11];
	assign y[22] = t[12] ^  t[34];
	assign t[35] = x[14] ^  t[13];
	assign y[6] = t[10] ^  t[35];
	assign t[36] = x[5] ^  x[21];
	assign t[37] = x[30] ^  t[17];
	assign t[38] = x[17] ^  t[16];
	assign t[39] = x[13] ^  t[8];
	assign y[5] = t[11] ^  t[39];
	assign t[40] = x[12] ^  t[36];
	assign t[41] = x[29] ^  t[9];
	assign y[21] = t[10] ^  t[41];
	assign t[42] = x[28] ^  t[40];
	assign y[13] = t[41] ^  t[42];
	assign y[29] = t[39] ^  t[42];
	assign t[43] = x[15] ^  t[12];
	assign y[7] = t[14] ^  t[43];
	assign t[44] = x[14] ^  t[37];
	assign y[31] = t[43] ^  t[44];
	assign t[45] = x[31] ^  t[13];
	assign y[15] = t[44] ^  t[45];
	assign y[23] = t[15] ^  t[45];
	assign t[46] = t[12] ^  t[36];
	assign y[14] = y[6] ^  t[46];
	assign t[47] = t[31] ^  t[33];
	assign y[17] = t[19] ^  t[47];
	assign t[48] = t[6] ^  y[3];
	assign y[11] = t[26] ^  t[48];
	assign t[49] = t[2] ^  t[38];
	assign y[25] = y[24] ^  t[49];
	assign t[50] = t[7] ^  y[19];
	assign y[27] = t[26] ^  t[50];
	assign t[51] = x[22] ^  t[46];
	assign y[30] = t[11] ^  t[51];
	assign t[52] = x[19] ^  t[28];
	assign y[20] = x[28] ^  t[52];
	assign t[53] = x[3] ^  t[27];
	assign y[4] = x[12] ^  t[53];
	assign t[54] = t[3] ^  t[33];
	assign y[9] = y[8] ^  t[54];
	assign t[55] = t[21] ^  t[31];
	assign y[1] = t[38] ^  t[55];
	assign t[56] = x[4] ^  t[17];
	assign t[57] = x[19] ^  t[56];
	assign y[12] = t[27] ^  t[57];
	assign t[58] = x[3] ^  t[28];
	assign t[59] = t[17] ^  t[58];
	assign y[28] = x[20] ^  t[59];

	assign mixed_word = y;
endmodule


