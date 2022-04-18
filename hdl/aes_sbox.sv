/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains rijndael forward S-BOX in the form of a LUT
*/


/*
*
* Basic LUT SBOX
*
*/

module aes_sbox(input logic [7:0] in,
		output logic [7:0] out);

		//case statement to lookup the value in the rijndael table
		always_comb 
		  begin
			  case(in)
				8'h00 : out = 8'h63;
				8'h01 : out = 8'h7C;
				8'h02 : out = 8'h77;
				8'h03 : out = 8'h7B;
				8'h04 : out = 8'hF2;
				8'h05 : out = 8'h6B;
				8'h06 : out = 8'h6F;
				8'h07 : out = 8'hC5;
				8'h08 : out = 8'h30;
				8'h09 : out = 8'h01;
				8'h0A : out = 8'h67;
				8'h0B : out = 8'h2B;
				8'h0C : out = 8'hFE;
				8'h0D : out = 8'hD7;
				8'h0E : out = 8'hAB;
				8'h0F : out = 8'h76;
				8'h10 : out = 8'hCA;
				8'h11 : out = 8'h82;
				8'h12 : out = 8'hC9;
				8'h13 : out = 8'h7D;
				8'h14 : out = 8'hFA;
				8'h15 : out = 8'h59;
				8'h16 : out = 8'h47;
				8'h17 : out = 8'hF0;
				8'h18 : out = 8'hAD;
				8'h19 : out = 8'hD4;
				8'h1A : out = 8'hA2;
				8'h1B : out = 8'hAF;
				8'h1C : out = 8'h9C;
				8'h1D : out = 8'hA4;
				8'h1E : out = 8'h72;
				8'h1F : out = 8'hC0;
				8'h20 : out = 8'hB7;
				8'h21 : out = 8'hFD;
				8'h22 : out = 8'h93;
				8'h23 : out = 8'h26;
				8'h24 : out = 8'h36;
				8'h25 : out = 8'h3F;
				8'h26 : out = 8'hF7;
				8'h27 : out = 8'hCC;
				8'h28 : out = 8'h34;
				8'h29 : out = 8'hA5;
				8'h2A : out = 8'hE5;
				8'h2B : out = 8'hF1;
				8'h2C : out = 8'h71;
				8'h2D : out = 8'hD8;
				8'h2E : out = 8'h31;
				8'h2F : out = 8'h15;
				8'h30 : out = 8'h04;
				8'h31 : out = 8'hC7;
				8'h32 : out = 8'h23;
				8'h33 : out = 8'hC3;
				8'h34 : out = 8'h18;
				8'h35 : out = 8'h96;
				8'h36 : out = 8'h05;
				8'h37 : out = 8'h9A;
				8'h38 : out = 8'h07;
				8'h39 : out = 8'h12;
				8'h3A : out = 8'h80;
				8'h3B : out = 8'hE2;
				8'h3C : out = 8'hEB;
				8'h3D : out = 8'h27;
				8'h3E : out = 8'hB2;
				8'h3F : out = 8'h75;
				8'h40 : out = 8'h09;
				8'h41 : out = 8'h83;
				8'h42 : out = 8'h2C;
				8'h43 : out = 8'h1A;
				8'h44 : out = 8'h1B;
				8'h45 : out = 8'h6E;
				8'h46 : out = 8'h5A;
				8'h47 : out = 8'hA0;
				8'h48 : out = 8'h52;
				8'h49 : out = 8'h3B;
				8'h4A : out = 8'hD6;
				8'h4B : out = 8'hB3;
				8'h4C : out = 8'h29;
				8'h4D : out = 8'hE3;
				8'h4E : out = 8'h2F;
				8'h4F : out = 8'h84;
				8'h50 : out = 8'h53;
				8'h51 : out = 8'hD1;
				8'h52 : out = 8'h00;
				8'h53 : out = 8'hED;
				8'h54 : out = 8'h20;
				8'h55 : out = 8'hFC;
				8'h56 : out = 8'hB1;
				8'h57 : out = 8'h5B;
				8'h58 : out = 8'h6A;
				8'h59 : out = 8'hCB;
				8'h5A : out = 8'hBE;
				8'h5B : out = 8'h39;
				8'h5C : out = 8'h4A;
				8'h5D : out = 8'h4C;
				8'h5E : out = 8'h58;
				8'h5F : out = 8'hCF;
				8'h60 : out = 8'hD0;
				8'h61 : out = 8'hEF;
				8'h62 : out = 8'hAA;
				8'h63 : out = 8'hFB;
				8'h64 : out = 8'h43;
				8'h65 : out = 8'h4D;
				8'h66 : out = 8'h33;
				8'h67 : out = 8'h85;
				8'h68 : out = 8'h45;
				8'h69 : out = 8'hF9;
				8'h6A : out = 8'h02;
				8'h6B : out = 8'h7F;
				8'h6C : out = 8'h50;
				8'h6D : out = 8'h3C;
				8'h6E : out = 8'h9F;
				8'h6F : out = 8'hA8;
				8'h70 : out = 8'h51;
				8'h71 : out = 8'hA3;
				8'h72 : out = 8'h40;
				8'h73 : out = 8'h8F;
				8'h74 : out = 8'h92;
				8'h75 : out = 8'h9D;
				8'h76 : out = 8'h38;
				8'h77 : out = 8'hF5;
				8'h78 : out = 8'hBC;
				8'h79 : out = 8'hB6;
				8'h7A : out = 8'hDA;
				8'h7B : out = 8'h21;
				8'h7C : out = 8'h10;
				8'h7D : out = 8'hFF;
				8'h7E : out = 8'hF3;
				8'h7F : out = 8'hD2;
				8'h80 : out = 8'hCD;
				8'h81 : out = 8'h0C;
				8'h82 : out = 8'h13;
				8'h83 : out = 8'hEC;
				8'h84 : out = 8'h5F;
				8'h85 : out = 8'h97;
				8'h86 : out = 8'h44;
				8'h87 : out = 8'h17;
				8'h88 : out = 8'hC4;
				8'h89 : out = 8'hA7;
				8'h8A : out = 8'h7E;
				8'h8B : out = 8'h3D;
				8'h8C : out = 8'h64;
				8'h8D : out = 8'h5D;
				8'h8E : out = 8'h19;
				8'h8F : out = 8'h73;
				8'h90 : out = 8'h60;
				8'h91 : out = 8'h81;
				8'h92 : out = 8'h4F;
				8'h93 : out = 8'hDC;
				8'h94 : out = 8'h22;
				8'h95 : out = 8'h2A;
				8'h96 : out = 8'h90;
				8'h97 : out = 8'h88;
				8'h98 : out = 8'h46;
				8'h99 : out = 8'hEE;
				8'h9A : out = 8'hB8;
				8'h9B : out = 8'h14;
				8'h9C : out = 8'hDE;
				8'h9D : out = 8'h5E;
				8'h9E : out = 8'h0B;
				8'h9F : out = 8'hDB;
				8'hA0 : out = 8'hE0;
				8'hA1 : out = 8'h32;
				8'hA2 : out = 8'h3A;
				8'hA3 : out = 8'h0A;
				8'hA4 : out = 8'h49;
				8'hA5 : out = 8'h06;
				8'hA6 : out = 8'h24;
				8'hA7 : out = 8'h5C;
				8'hA8 : out = 8'hC2;
				8'hA9 : out = 8'hD3;
				8'hAA : out = 8'hAC;
				8'hAB : out = 8'h62;
				8'hAC : out = 8'h91;
				8'hAD : out = 8'h95;
				8'hAE : out = 8'hE4;
				8'hAF : out = 8'h79;
				8'hB0 : out = 8'hE7;
				8'hB1 : out = 8'hC8;
				8'hB2 : out = 8'h37;
				8'hB3 : out = 8'h6D;
				8'hB4 : out = 8'h8D;
				8'hB5 : out = 8'hD5;
				8'hB6 : out = 8'h4E;
				8'hB7 : out = 8'hA9;
				8'hB8 : out = 8'h6C;
				8'hB9 : out = 8'h56;
				8'hBA : out = 8'hF4;
				8'hBB : out = 8'hEA;
				8'hBC : out = 8'h65;
				8'hBD : out = 8'h7A;
				8'hBE : out = 8'hAE;
				8'hBF : out = 8'h08;
				8'hC0 : out = 8'hBA;
				8'hC1 : out = 8'h78;
				8'hC2 : out = 8'h25;
				8'hC3 : out = 8'h2E;
				8'hC4 : out = 8'h1C;
				8'hC5 : out = 8'hA6;
				8'hC6 : out = 8'hB4;
				8'hC7 : out = 8'hC6;
				8'hC8 : out = 8'hE8;
				8'hC9 : out = 8'hDD;
				8'hCA : out = 8'h74;
				8'hCB : out = 8'h1F;
				8'hCC : out = 8'h4B;
				8'hCD : out = 8'hBD;
				8'hCE : out = 8'h8B;
				8'hCF : out = 8'h8A;
				8'hD0 : out = 8'h70;
				8'hD1 : out = 8'h3E;
				8'hD2 : out = 8'hB5;
				8'hD3 : out = 8'h66;
				8'hD4 : out = 8'h48;
				8'hD5 : out = 8'h03;
				8'hD6 : out = 8'hF6;
				8'hD7 : out = 8'h0E;
				8'hD8 : out = 8'h61;
				8'hD9 : out = 8'h35;
				8'hDA : out = 8'h57;
				8'hDB : out = 8'hB9;
				8'hDC : out = 8'h86;
				8'hDD : out = 8'hC1;
				8'hDE : out = 8'h1D;
				8'hDF : out = 8'h9E;
				8'hE0 : out = 8'hE1;
				8'hE1 : out = 8'hF8;
				8'hE2 : out = 8'h98;
				8'hE3 : out = 8'h11;
				8'hE4 : out = 8'h69;
				8'hE5 : out = 8'hD9;
				8'hE6 : out = 8'h8E;
				8'hE7 : out = 8'h94;
				8'hE8 : out = 8'h9B;
				8'hE9 : out = 8'h1E;
				8'hEA : out = 8'h87;
				8'hEB : out = 8'hE9;
				8'hEC : out = 8'hCE;
				8'hED : out = 8'h55;
				8'hEE : out = 8'h28;
				8'hEF : out = 8'hDF;
				8'hF0 : out = 8'h8C;
				8'hF1 : out = 8'hA1;
				8'hF2 : out = 8'h89;
				8'hF3 : out = 8'h0D;
				8'hF4 : out = 8'hBF;
				8'hF5 : out = 8'hE6;
				8'hF6 : out = 8'h42;
				8'hF7 : out = 8'h68;
				8'hF8 : out = 8'h41;
				8'hF9 : out = 8'h99;
				8'hFA : out = 8'h2D;
				8'hFB : out = 8'h0F;
				8'hFC : out = 8'hB0;
				8'hFD : out = 8'h54;
				8'hFE : out = 8'hBB;
				8'hFF : out = 8'h16;
			endcase
		  end
endmodule

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
