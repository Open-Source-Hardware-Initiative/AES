/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains a single AES round data calculation.
*	    A single aes round is broken into the steps:
*	    SubBytes -> ShiftRows -> MixColumns -> AddRoundKey
*	    I have abstracted each of these operations into a module
*	    so you can just pass the data between these modules
*	    
*	    The use of these operations for rounds are:
*	    Initial round key addition : Data -> Addroundkey(with og key [255:128] aka roundkey_0 -> out
*	    Round 1-13 : SubBytes -> ShiftRows -> MixColumns -> addroundkey
*	    Round 14 : SubBytes -> ShiftRows -> AddRoundKey (Skip Mixcolumns)
*	    Thus there is also a multiplexer based on round number implemented
*	    to skip mixcolumns or everything except ark.
*/




module aes_rounddata(input logic [3:0] round,
             input logic clk,
		     input logic [1:0] mode, //00 for 128 01 for 192 and 10 for 256
		     input logic [1:0] width_sel, //selects sub-word for radix
		     input logic [127:0] round_key,
		     input logic [127:0] data_in,
		     output logic [127:0] data_out);

		logic [31:0] sbox_out;
		logic [127:0] shiftRow_out;
		logic [31:0] mixCol_out;
		logic [31:0] sbox_in;
		
		logic [31:0] accumulation_in;
		logic [31:0] accumulation_in_128;
		logic [31:0] accumulation_in_256;
		logic [127:0] accumulation_out;
		
		logic [127:0] ark_in_256;
		logic [127:0] ark_in_128;
		logic [127:0] ark_in_192;
		logic [127:0] ark_in_mode;
		logic [127:0] ark_in;
		

		
		logic AES_128_MODE;
		logic AES_192_MODE;
		logic AES_256_MODE;

		logic r0_flag;
		logic r10_flag;
		logic r14_flag;




		//AES Shift rows operation
		aes_shiftrow srow(.dataIn(data_in),
				  .dataOut(shiftRow_out));

        //Select current word from output of shiftrow using 4 input mux
        //Outputs should be:
        //00 : [31:0] | 01 : [63:32] | 10 : [95:64] | 11 : [127:96]
        assign sbox_in = width_sel[1] ? (width_sel[0] ? shiftRow_out[127:96] : shiftRow_out[95:64]) : (width_sel[0] ? shiftRow_out[63:32] : shiftRow_out[31:0]);


		//AES Substitution Box operation for single word
		aes_sbox_word sbox(.in(sbox_in),
				  .out(sbox_out));

		//AES Mix Columns operation for single word
		mixword mixcol(.word(sbox_out),
				      .mixed_word(mixCol_out));


        //Accumulation in should change between sbox_out and mixcol_out based on last_round
        assign accumulation_in_128 = r10_flag ? sbox_out : mixCol_out;
        assign accumulation_in_256 = r14_flag ? sbox_out : mixCol_out;
        assign accumulation_in = AES_256_MODE ? accumulation_in_256 : accumulation_in_128;

        //Accumulation register for 32 bit radix
        accumulation_reg stageon_accum(.in(accumulation_in),.clk(clk),.enable(1'b1),.out(accumulation_out));


		//Check for round 0 (RD = 0000)
		assign r0_flag = ~(round[3] | round[2] | round[1] | round[0]);
		//Check for round 10 (RD = 1010) (Last round of AES128)
		assign r10_flag = (round[3] & round[1]) & ~(round[2] & round[0]);
		//Check for round 12 (RD = 1100) (Last round ofAES192)
		assign r12_flag = (round[3] & round[2]) & ~(round[1] & round[0]);
		//Check for round 14 (RD = 1110) (Last round of AES256)
		assign r14_flag = (round[3] & round[2] & round[1]) & ~round[0];
		

		//NOTE FOR LATER : IT MIGHT BE BETTER TO HAVE A "last_round" input and "first_round" input from FSM
		//But this should be more generalized for now.

		//These ternaries break down into : if r0 ark_in takes data_in 
		//elsif final round take shiftRow_out else take mixCol_out
		
		//TODO : Un-nest ternaries?
		
		//Ark_in for AES128 (Necessary due to different round amounts between standards)
		assign ark_in_128 = r0_flag ? data_in : (r10_flag ? sbox_out : mixCol_out);
		
		//Ark_in for AES192 (Necessary due to different round amounts between standards)
		assign ark_in_192 = r0_flag ? data_in : (r12_flag ? sbox_out : mixCol_out);
		
		//Ark_in for AES256 (Necessary due to different round amounts between standards)
		assign ark_in_256 = r0_flag ? data_in : (r14_flag ? sbox_out : mixCol_out);
		
		
		//Set mode flag accordingly
		//mode = 00 for AES 128
		assign AES_128_MODE = ~(mode[0] | mode[1]);
		//mode = 01 for AES 192
		assign AES_192_MODE = mode[0] & ~mode[1];
		//mod = 10 for AES 256
		assign AES_256_MODE = ~mode[0] & mode[1];
		
		
		//Set ark_in according to mode NOTE: defaults to 256
		assign ark_in_mode = AES_128_MODE ? ark_in_128 : (AES_192_MODE ? ark_in_192 : ark_in_256);
		assign ark_in = r0_flag ? data_in : accumulation_out;
		
		
		//AES Add Round Key operation
		aes_addroundkey ark(.data(ark_in),
				    .round_key(round_key),
				    .sum(data_out));


endmodule







module accumulation_reg(input logic [31:0] in,
                        input logic clk, enable, 
                        output logic [127:0] out);
                        
    logic [127:0] out_prev;
    logic [127:0] prev_shift;
    
    assign prev_shift = out_prev >> 32;
    assign out = {in,prev_shift[95:0]};
    
    //Accumulate in 32 bit increments on clk
    always @(posedge clk)
      begin
        out_prev <= out;
      
      end

endmodule
