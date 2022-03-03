/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains a single AES round data
	    inverse calculation. This is essentially a
	    backwards version of the basic round data
	    algorithm.
	    
	    This essentially breaks down to a backwards version of the OG
	    Round 0 : addroundkey -> inv_shiftrows -> inv_sbox
	    Round 1-13 : addroundkey -> inv_mixcols -> inv_shiftrows -> inv_sbox
	    Round 14 : addroundkey
	    Or in more simplistic terms we want to skip the mixcols operation
	    on round 0 and skip all operations except addroundkey on round 14 (for AES256)
	    or just the last round to be more generalized
	    
	    
	    //MAYBE CONSIDER DOING ROUNDS BACKWARDS IS IT MORE STRAIGHTFORWARD THAT WAY?
*/



module aes_inv_rounddata(input logic [3:0] round,
		     input logic [1:0] mode, //00 for 128 01 for 192 and 10 for 256
		     input logic [127:0] round_key,
		     input logic [127:0] data_in,
		     output logic [127:0] data_out);

		logic [127:0] sbox_out;
		logic [127:0] shiftRow_out;
		logic [127:0] mixCol_out;
		logic [127:0] ark_out;
		
		logic [127:0] shiftRow_in;
		
		logic AES_128_MODE;
		logic AES_192_MODE;
		logic AES_256_MODE;

		logic r0_flag;
		logic r10_flag;
		logic r12_flag;
		logic r14_flag;
		logic last_round;


		//ROUND CHECKING LOGIC
		//Check for round 0 (RD = 0000)
		assign r0_flag = ~(round[3] | round[2] | round[1] | round[0]);
		//Check for round 10 (RD = 1010) (Last round of AES128)
		assign r10_flag = (round[3] & round[1]) & ~(round[2] & round[0]);
		//Check for round 12 (RD = 1100) (Last round ofAES192)
		assign r12_flag = (round[3] & round[2]) & ~(round[1] & round[0]);
		//Check for round 14 (RD = 1110) (Last round of AES256)
		assign r14_flag = (round[3] & round[2] & round[1]) & ~round[0];
		
		//MODE CHECKING LOGIC
		//mode = 00 for AES 128
		assign AES_128_MODE = ~(mode[0] | mode[1]);
		//mode = 01 for AES 192
		assign AES_192_MODE = mode[0] & ~mode[1];
		//mode = 10 for AES 256
		assign AES_256_MODE = ~mode[0] & mode[1];

		//AES OPERATION
		//AES Add Round Key operation
		aes_addroundkey ark(.data(data_in),
				    .round_key(round_key),
				    .sum(ark_out));


		//AES Mix Columns operation
		aes_inv_mixcols mixcol(.data(ark_out),
				      .mixed_col(mixCol_out));

		//We want to skip mix columns (alter the input to shiftRow) on round 0
		assign shiftRow_in = r0_flag ? ark_out : mixCol_out;


		//AES Shift rows operation
		aes_inv_shiftrow srow(.dataIn(shiftRow_in),
				  .dataOut(shiftRow_out));

		//AES Substitution Box operation
		aes_inv_sbox_128 sbox(.in(shiftRow_out),
				  .out(sbox_out));

		//Check if this is the last round of whatever mode we are in
		assign last_round = (r10_flag & AES_128_MODE) | (r12_flag & AES_192_MODE) | (r14_flag & AES_256_MODE);

		//Assign data out to the output of the ark if it is the last round or the sbox otherwise
		assign data_out = last_round ? ark_out : sbox_out;
		
endmodule
