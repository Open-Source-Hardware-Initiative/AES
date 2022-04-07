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
		     input logic [3:0] width_sel, //selects sub-word for radix
		     input logic [127:0] round_key,
		     input logic [127:0] data_in,
		     output logic [127:0] data_out);

        //Galois Multiplication radix-8 units
        logic [7:0] gm2_out;
        logic [7:0] gm3_out;
        //32 bit inputs to mixcolumn recombinator
        logic [31:0] gm2_reg_out;
        logic [31:0] gm3_reg_out;
        logic [31:0] sbox_reg_out;

		logic [7:0] sbox_out;
		logic [127:0] shiftRow_out;
		logic [31:0] mixCol_out;
		logic [7:0] sbox_in;
		
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

        //Select current word from output of shiftrow using 16 input mux
        always_comb
		      begin
		    	case(width_sel)
		    	  4'h0 : sbox_in = shiftRow_out[7:0];
		    	  4'h1 : sbox_in = shiftRow_out[15:8];
		    	  4'h2 : sbox_in = shiftRow_out[23:16];
		    	  4'h3 : sbox_in = shiftRow_out[31:24];
		    	  4'h4 : sbox_in = shiftRow_out[39:32];
		    	  4'h5 : sbox_in = shiftRow_out[47:40];
		    	  4'h6 : sbox_in = shiftRow_out[55:48];
		    	  4'h7 : sbox_in = shiftRow_out[63:56];
		    	  4'h8 : sbox_in = shiftRow_out[71:64];
		    	  4'h9 : sbox_in = shiftRow_out[79:72];
		    	  4'hA : sbox_in = shiftRow_out[87:80];
		    	  4'hB : sbox_in = shiftRow_out[95:88];
		    	  4'hC : sbox_in = shiftRow_out[103:96];
		    	  4'hD : sbox_in = shiftRow_out[111:104];
		    	  4'hE : sbox_in = shiftRow_out[119:112];
		    	  4'hF : sbox_in = shiftRow_out[127:120];
		    	  default : sbox_in = shiftRow_out[7:0];
		    	endcase
		      end
        
 


		//AES Substitution Box operation for single word
		aes_sbox sbox(.in(sbox_in),
				  .out(sbox_out));




       //Incremental GM2 Multiplication
       gm2 gm2_1(.gm2_in(sbox_out),
	         .gm2_out(gm2_out));
	   //Incremental GM3 Multiplication
       gm3 gm3_1(.gm3_in(sbox_out),
	         .gm3_out(gm3_out));


        //Register the outputs of gm2 multiplications for mixcol recombination
        accumulation_reg_8 gm2_reg(.in(gm2_out),
                                  .clk(clk),
                                  .enable(1'b1),
                                  .out(gm2_reg_out));

        //Register the outputs of gm3 multiplications for mixcol recombination
        accumulation_reg_8 gm3_reg(.in(gm3_out),
                                  .clk(clk),
                                  .enable(1'b1),
                                  .out(gm3_reg_out));        
        //Register the sbox output for use in 
        accumulation_reg_8 sbox_reg(.in(sbox_out),
                                    .clk(clk),
                                    .enable(1'b1),
                                    .out(sbox_reg_out));



		//AES Mix Columns Recombination
		mixcol_radix8 mixcol_radix8(.gm2_mults(gm2_reg_out),
		                            .gm3_mults(gm3_reg_out),
		                            .sbox_outs(sbox_reg_out),
				                    .mixed_word(mixCol_out));


        //Accumulation in should change between sbox_out and mixcol_out based on last_round
        assign accumulation_in_128 = r10_flag ? sbox_reg_out : mixCol_out;
        assign accumulation_in_256 = r14_flag ? sbox_reg_out : mixCol_out;
        assign accumulation_in = AES_256_MODE ? accumulation_in_256 : accumulation_in_128;

        //Accumulation register for 32 bit radix
        //We want it every 4 sub-rounds, as that's when the mixcolumns we want
        //is ready. So we need this register to function on : 3,7,11,15
        //0011
        //0111
        //1011
        //1111
        accumulation_reg stageon_accum(.in(accumulation_in),.clk(clk),.enable(width_sel[0] & width_sel[1]),.out(accumulation_out));


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



module accumulation_reg_8(input logic [7:0] in,
                        input logic clk, enable, 
                        output logic [31:0] out);
                        
    logic [31:0] out_prev;
    logic [31:0] prev_shift;
    
    assign prev_shift = out_prev >> 8;
    assign out = {in,prev_shift[23:0]};
    
    //Accumulate in 32 bit increments on clk
    always @(posedge clk)
      begin
        out_prev <= out;   
      end

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
        if(enable == 1'b1)
          begin
            out_prev <= out;
          end
      end

endmodule
