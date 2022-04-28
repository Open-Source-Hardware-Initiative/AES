/*

This file contains pipelineable versions of the nist sbox

*/ 



/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains rijndael forward S-BOX in the form of a LUT
*/


/*
*
* Basic LUT SBOX
*
*/

/*
*
* 113 Gate SBOX
*
*/

module aes_sbox_g113(input logic [7:0] in,
		output logic [7:0] out);
	
	logic [7:0] U;
	logic [7:0] S;
	logic [105:0] t;

	aes_8reverse rev(.in(in),
			.out(U));

	//Unused
	assign t[0] = 1'b0;

	//Now time for dis mess	
	assign t[1] = U[3] ^ U[5];
	assign t[2] = U[0] ^ U[6];
	assign t[3] = U[0] ^ U[3];
	assign t[4] = U[0] ^ U[5];
	assign t[5] = U[1] ^ U[2];
	assign t[6] = t[5] ^ U[7];
	assign t[7] = t[6] ^ U[3];
	assign t[8] = t[2] ^ t[1];
	assign t[9] = t[6] ^ U[0];
	assign t[10] = t[6] ^ U[6];
	assign t[11] = t[10] ^ t[4];
	assign t[12] = U[4] ^ t[8];
	assign t[13] = t[12] ^ U[5];
	assign t[14] = t[12] ^ U[1];
	assign t[15] = t[13] ^ U[7];
	assign t[16] = t[13] ^ t[5];
	assign t[17] = t[14] ^ t[3];
	assign t[18] = U[7] ^ t[17];
	assign t[19] = t[16] ^ t[17];
	assign t[20] = t[16] ^ t[4];
	assign t[21] = t[5] ^ t[17];
	assign t[22] = t[2] ^ t[21];
	assign t[23] = U[0] ^ t[21];
	assign t[24] = t[8] & t[13];
	assign t[25] = t[11] & t[15];
	assign t[26] = t[25] ^ t[24];
	assign t[27] = t[7] & U[7];
	assign t[28] = t[27] ^ t[24];
	assign t[29] = t[2] & t[21];
	assign t[30] = t[10] & t[6];
	assign t[31] = t[30] ^ t[29];
	assign t[32] = t[9] & t[18];
	assign t[33] = t[32] ^ t[29];
	assign t[34] = t[3] & t[17];
	assign t[35] = t[1] & t[19];
	assign t[36] = t[35] ^ t[34];
	assign t[37] = t[4] & t[16];
	assign t[38] = t[37] ^ t[34];
	assign t[39] = t[26] ^ t[14];
	assign t[40] = t[28] ^ t[38];
	assign t[41] = t[31] ^ t[36];
	assign t[42] = t[33] ^ t[38];
	assign t[43] = t[39] ^ t[36];
	assign t[44] = t[40] ^ t[20];
	assign t[45] = t[41] ^ t[22];
	assign t[46] = t[42] ^ t[23];
	assign t[47] = t[43] ^ t[44];
	assign t[48] = t[43] & t[45];
	assign t[49] = t[46] ^ t[48];
	assign t[50] = t[47] & t[49];
	assign t[51] = t[50] ^ t[44];
	assign t[52] = t[45] ^ t[46];
	assign t[53] = t[44] ^ t[48];
	assign t[54] = t[53] & t[52];
	assign t[55] = t[54] ^ t[46];
	assign t[56] = t[45] ^ t[55];
	assign t[57] = t[49] ^ t[55];
	assign t[58] = t[46] & t[57];
	assign t[59] = t[58] ^ t[56];
	assign t[60] = t[49] ^ t[58];
	assign t[61] = t[51] & t[60];
	assign t[62] = t[47] ^ t[61];
	assign t[63] = t[62] ^ t[59];
	assign t[64] = t[51] ^ t[55];
	assign t[65] = t[51] ^ t[62];
	assign t[66] = t[55] ^ t[59];
	assign t[67] = t[64] ^ t[63];
	assign t[68] = t[66] & t[13];
	assign t[69] = t[59] & t[15];
	assign t[70] = t[55] & U[7];
	assign t[71] = t[65] & t[21];
	assign t[72] = t[62] & t[6];
	assign t[73] = t[51] & t[18];
	assign t[74] = t[64] & t[17];
	assign t[75] = t[67] & t[19];
	assign t[76] = t[63] & t[16];
	assign t[77] = t[66] & t[8];
	assign t[78] = t[59] & t[11];
	assign t[79] = t[55] & t[7];
	assign t[80] = t[65] & t[2];
	assign t[81] = t[62] & t[10];
	assign t[82] = t[51] & t[9];
	assign t[83] = t[64] & t[3];
	assign t[84] = t[67] & t[1];
	assign t[85] = t[63] & t[4];
	assign t[86] = t[83] ^ t[84];
	assign t[87] = t[78] ^ t[86];
	assign t[88] = t[77] ^ t[87];
	assign t[89] = t[68] ^ t[70];
	assign t[90] = t[69] ^ t[68];
	assign t[91] = t[71] ^ t[72];
	assign t[92] = t[80] ^ t[89];
	assign t[93] = t[75] ^ t[91];
	assign t[94] = t[76] ^ t[92];
	assign t[95] = t[93] ^ t[94];
	assign t[96] = t[91] ^ t[90];
	assign t[97] = t[71] ^ t[73];
	assign t[98] = t[81] ^ t[86];
	assign t[99] = t[89] ^ t[97];
	assign S[3] = t[88] ^ t[96];
	assign t[100] = t[74] ^ t[93];
	assign t[101] = t[82] ^ t[95];
	assign t[102] = t[98] ^ t[99];
	assign S[7] = t[80] ^~ t[102];
	assign t[103] = t[83] ^ t[100];
	assign t[104] = t[87] ^ t[79];
	assign S[0] = t[88] ^ t[100];
	assign S[6] = t[95] ^~ t[102];
	assign S[4] = t[99] ^ S[3];
	assign S[1] = S[3] ^~ t[100];
	assign t[105] = t[101] ^ t[103];
	assign S[2] = t[105] ^~ t[85];
	assign S[5] = t[104] ^ t[101];


	aes_8reverse revOut(.in(S),
			.out(out));
endmodule

/*
*
* 115 Gate SBOX
*
*/

module aes_sbox_g115(input logic [7:0] in,
		output logic [7:0] out);
	
	logic [7:0] U;
	logic [7:0] S;
	logic [107:0] t;
	
	//Set u to in (To use their notation)
	aes_8reverse rev(.in(in),
			.out(U));
	//Unused
	assign t[0] = 1'b0;

	//Now time for dis mess	
	assign t[1] = U[3] ^ U[5];
	assign t[2] = U[0] ^ U[6];
	assign t[3] = U[0] ^ U[3];
	assign t[4] = U[0] ^ U[5];
	assign t[5] = U[1] ^ U[2];
	assign t[6] = t[5] ^ U[7];
	assign t[7] = t[6] ^ U[3];
	assign t[8] = t[2] ^ t[1];
	assign t[9] = t[6] ^ U[0];
	assign t[10] = t[6] ^ U[6];
	assign t[11] = t[10] ^ t[4];
	assign t[12] = U[4] ^ t[8];
	assign t[13] = t[12] ^ U[5];
	assign t[14] = t[12] ^ U[1];
	assign t[15] = t[13] ^ U[7];
	assign t[16] = t[13] ^ t[5];
	assign t[17] = t[14] ^ t[3];
	assign t[18] = U[7] ^ t[17];
	assign t[19] = t[16] ^ t[17];
	assign t[20] = t[16] ^ t[4];
	assign t[21] = t[5] ^ t[17];
	assign t[22] = t[2] ^ t[21];
	assign t[23] = U[0] ^ t[21];
	assign t[24] = t[8] & t[13];
	assign t[25] = t[11] & t[15];
	assign t[26] = t[25] ^ t[24];
	assign t[27] = t[7] & U[7];
	assign t[28] = t[27] ^ t[24];
	assign t[29] = t[2] & t[21];
	assign t[30] = t[10] & t[6];
	assign t[31] = t[30] ^ t[29];
	assign t[32] = t[9] & t[18];
	assign t[33] = t[32] ^ t[29];
	assign t[34] = t[3] & t[17];
	assign t[35] = t[1] & t[19];
	assign t[36] = t[35] ^ t[34];
	assign t[37] = t[4] & t[16];
	assign t[38] = t[37] ^ t[34];
	assign t[39] = t[26] ^ t[36];
	assign t[40] = t[28] ^ t[38];
	assign t[41] = t[31] ^ t[36];
	assign t[42] = t[33] ^ t[38];
	assign t[43] = t[39] ^ t[14];
	assign t[44] = t[40] ^ t[20];
	assign t[45] = t[41] ^ t[22];
	assign t[46] = t[42] ^ t[23];
	assign t[47] = t[43] ^ t[44];
	assign t[48] = t[43] & t[45];
	assign t[49] = t[46] ^ t[48];
	assign t[50] = t[47] & t[49];
	assign t[51] = t[50] ^ t[44];
	assign t[52] = t[45] ^ t[46];
	assign t[53] = t[44] ^ t[48];
	assign t[54] = t[53] & t[52];
	assign t[55] = t[54] ^ t[46];
	assign t[56] = t[45] ^ t[55];
	assign t[57] = t[49] ^ t[55];
	assign t[58] = t[46] & t[57];
	assign t[59] = t[58] ^ t[56];
	assign t[60] = t[49] ^ t[58];
	assign t[61] = t[51] & t[60];
	assign t[62] = t[47] ^ t[61];
	assign t[63] = t[62] ^ t[59];
	assign t[64] = t[51] ^ t[55];
	assign t[65] = t[51] ^ t[62];
	assign t[66] = t[55] ^ t[59];
	assign t[67] = t[64] ^ t[63];
	assign t[68] = t[66] & t[13];
	assign t[69] = t[59] & t[15];
	assign t[70] = t[55] & U[7];
	assign t[71] = t[65] & t[21];
	assign t[72] = t[62] & t[6];
	assign t[73] = t[51] & t[18];
	assign t[74] = t[64] & t[17];
	assign t[75] = t[67] & t[19];
	assign t[76] = t[63] & t[16];
	assign t[77] = t[66] & t[8];
	assign t[78] = t[59] & t[11];
	assign t[79] = t[55] & t[7];
	assign t[80] = t[65] & t[2];
	assign t[81] = t[62] & t[10];
	assign t[82] = t[51] & t[9];
	assign t[83] = t[64] & t[3];
	assign t[84] = t[67] & t[1];
	assign t[85] = t[63] & t[4];
	assign t[86] = t[83] ^ t[84];
	assign t[87] = t[78] ^ t[79];
	assign t[88] = t[73] ^ t[81];
	assign t[89] = t[77] ^ t[78];
	assign t[90] = t[70] ^ t[80];
	assign t[91] = t[70] ^ t[73];
	assign t[92] = t[75] ^ t[76];
	assign t[93] = t[68] ^ t[71];
	assign t[94] = t[74] ^ t[75];
	assign t[95] = t[84] ^ t[85];
	assign t[96] = t[80] ^ t[88];
	assign t[97] = t[90] ^ t[93];
	assign t[98] = t[72] ^ t[86];
	assign t[99] = t[71] ^ t[94];
	assign t[100] = t[86] ^ t[97];
	assign t[101] = t[82] ^ t[97];
	assign t[102] = t[92] ^ t[98];
	assign t[103] = t[89] ^ t[98];
	assign t[104] = t[72] ^ t[99];
	assign t[105] = t[101] ^ t[102];
	assign t[106] = t[69] ^ t[103];
	assign S[0] = t[99] ^ t[103];
	assign S[6] = t[96] ^~ t[102];
	assign S[7] = t[88] ^~ t[100];
	assign t[107] = t[104] ^ t[105];
	assign S[3] = t[93] ^ t[106];
	assign S[4] = t[91] ^ t[106];
	assign S[5] = t[87] ^ t[105];
	assign S[1] = t[104] ^~ S[3];
	assign S[2] = t[95] ^~ t[107];


	aes_8reverse revOut(.in(S),
			.out(out));

endmodule

/*
*
* 128 Gate SBOX
*
*/
module aes_sbox_g128(input logic [7:0] in,
		output logic [7:0] out);
	
	logic [7:0] U;
	logic [7:0] S;
	logic [120:0] t;
	
	//Set u to in (To use their notation)
	aes_8reverse rev(.in(in),
			.out(U));
	//Unused
	assign t[0] = 1'b0;

	//Now time for dis mess	
	assign t[1] = U[0] ^ U[3];
	assign t[2] = U[0] ^ U[5];
	assign t[3] = U[0] ^ U[6];
	assign t[4] = U[3] ^ U[5];
	assign t[5] = U[4] ^ U[6];
	assign t[6] = t[1] ^ t[5];
	assign t[7] = U[1] ^ U[2];
	assign t[8] = U[7] ^ t[6];
	assign t[9] = U[7] ^ t[7];
	assign t[10] = t[6] ^ t[7];
	assign t[11] = U[1] ^ U[5];
	assign t[12] = U[2] ^ U[5];
	assign t[13] = t[3] ^ t[4];
	assign t[14] = t[6] ^ t[11];
	assign t[15] = t[5] ^ t[11];
	assign t[16] = t[5] ^ t[12];
	assign t[17] = t[9] ^ t[16];
	assign t[18] = U[3] ^ U[7];
	assign t[19] = t[7] ^ t[18];
	assign t[20] = t[1] ^ t[19];
	assign t[21] = U[6] ^ U[7];
	assign t[22] = t[7] ^ t[21];
	assign t[23] = t[2] ^ t[22];
	assign t[24] = t[2] ^ t[10];
	assign t[25] = t[20] ^ t[17];
	assign t[26] = t[3] ^ t[16];
	assign t[27] = t[1] ^ t[12];
	assign t[28] = t[13] & t[6];
	assign t[29] = t[23] & t[8];
	assign t[30] = t[14] ^ t[28];
	assign t[31] = t[19] & U[7];
	assign t[32] = t[31] ^ t[28];
	assign t[33] = t[3] & t[16];
	assign t[34] = t[22] & t[9];
	assign t[35] = t[26] ^ t[33];
	assign t[36] = t[20] & t[17];
	assign t[37] = t[36] ^ t[33];
	assign t[38] = t[1] & t[15];
	assign t[39] = t[4] & t[27];
	assign t[40] = t[39] ^ t[38];
	assign t[41] = t[2] & t[10];
	assign t[42] = t[41] ^ t[38];
	assign t[43] = t[30] ^ t[29];
	assign t[44] = t[32] ^ t[24];
	assign t[45] = t[35] ^ t[34];
	assign t[46] = t[37] ^ t[42];
	assign t[47] = t[43] ^ t[40];
	assign t[48] = t[44] ^ t[42];
	assign t[49] = t[45] ^ t[40];
	assign t[50] = t[46] ^ t[25];
	assign t[51] = t[49] ^ t[50];
	assign t[52] = t[49] & t[47];
	assign t[53] = t[48] ^ t[52];
	assign t[54] = t[47] ^ t[48];
	assign t[55] = t[50] ^ t[52];
	assign t[56] = t[55] & t[54];
	assign t[57] = t[53] & t[51];
	assign t[58] = t[47] & t[50];
	assign t[59] = t[54] & t[58];
	assign t[60] = t[54] ^ t[52];
	assign t[61] = t[48] & t[49];
	assign t[62] = t[51] & t[61];
	assign t[63] = t[51] ^ t[52];
	assign t[64] = t[48] ^ t[56];
	assign t[65] = t[59] ^ t[60];
	assign t[66] = t[50] ^ t[57];
	assign t[67] = t[62] ^ t[63];
	assign t[68] = t[65] ^ t[67];
	assign t[69] = t[64] ^ t[66];
	assign t[70] = t[64] ^ t[65];
	assign t[71] = t[66] ^ t[67];
	assign t[72] = t[69] ^ t[68];
	assign t[73] = t[71] & t[6];
	assign t[74] = t[67] & t[8];
	assign t[75] = t[66] & U[7];
	assign t[76] = t[70] & t[16];
	assign t[77] = t[65] & t[9];
	assign t[78] = t[64] & t[17];
	assign t[79] = t[69] & t[15];
	assign t[80] = t[72] & t[27];
	assign t[81] = t[68] & t[10];
	assign t[82] = t[71] & t[13];
	assign t[83] = t[67] & t[23];
	assign t[84] = t[66] & t[19];
	assign t[85] = t[70] & t[3];
	assign t[86] = t[65] & t[22];
	assign t[87] = t[64] & t[20];
	assign t[88] = t[69] & t[1];
	assign t[89] = t[72] & t[4];
	assign t[90] = t[68] & t[2];
	assign t[91] = t[88] ^ t[89];
	assign t[92] = t[77] ^ t[83];
	assign t[93] = t[73] ^ t[75];
	assign t[94] = t[74] ^ t[82];
	assign t[95] = t[81] ^ t[85];
	assign t[96] = t[76] ^ t[88];
	assign t[97] = t[89] ^ t[96];
	assign t[98] = t[73] ^ t[94];
	assign t[99] = t[78] ^ t[86];
	assign t[100] = t[79] ^ t[80];
	assign t[101] = t[80] ^ t[95];
	assign t[102] = t[87] ^ t[93];
	assign t[103] = t[75] ^ t[78];
	assign t[104] = t[77] ^ t[91];
	assign t[105] = t[79] ^ t[88];
	assign t[106] = t[82] ^ t[92];
	assign t[107] = t[83] ^ t[91];
	assign t[108] = t[84] ^ t[92];
	assign t[109] = t[85] ^ t[99];
	assign t[110] = t[90] ^ t[95];
	assign t[111] = t[91] ^ t[92];
	assign t[112] = t[92] ^ t[98];
	assign t[113] = t[94] ^ t[103];
	assign t[114] = t[109] ^ t[93];
	assign t[115] = t[106] ^ t[100];
	assign t[116] = t[97] ^ t[101];
	assign t[117] = t[98] ^ t[100];
	assign t[118] = t[99] ^ t[101];
	assign t[119] = t[102] ^ t[105];
	assign t[120] = t[102] ^ t[108];
	assign S[0] = t[97] ^ t[115];
	assign S[1] = t[107] ^~ t[117];
	assign S[2] = t[110] ^~ t[119];
	assign S[3] = t[97] ^ t[112];
	assign S[4] = t[111] ^ t[113];
	assign S[5] = t[116] ^ t[120];
	assign S[6] = t[104] ^~ t[118];
	assign S[7] = t[97] ^~ t[114];


	aes_8reverse revOut(.in(S),
			.out(out));
endmodule
