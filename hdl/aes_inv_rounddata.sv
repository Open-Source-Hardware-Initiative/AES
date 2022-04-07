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
		     input logic clk,
		     input logic [3:0] width_sel, //selects sub-word for radix
		     output logic [127:0] data_out);

		
		logic [127:0] shiftRow_in;
		logic [127:0] shiftRow_out;
		logic [127:0] ark_out;
		
		logic [7:0] gm9_out, gm11_out, gm13_out, gm14_out;
		logic [31:0] gm9_accum_out, gm11_accum_out, gm13_accum_out, gm14_accum_out;
		
		
		logic [7:0] sbox_in;
		logic [7:0] sbox_out;
		logic [31:0] mixCol_out;
		logic [31:0] mixCol_reg;
		logic [7:0] mixCol_out_mux;
		logic [7:0] ark_out_mux;
		
		
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
				    

        //Select current word from output of shiftrow using 16 input mux
        always_comb
		      begin
		    	case(width_sel)
		    	  4'h0 : ark_out_mux = ark_out[7:0];
		    	  4'h1 : ark_out_mux = ark_out[15:8];
		    	  4'h2 : ark_out_mux = ark_out[23:16];
		    	  4'h3 : ark_out_mux = ark_out[31:24];
		    	  4'h4 : ark_out_mux = ark_out[39:32];
		    	  4'h5 : ark_out_mux = ark_out[47:40];
		    	  4'h6 : ark_out_mux = ark_out[55:48];
		    	  4'h7 : ark_out_mux = ark_out[63:56];
		    	  4'h8 : ark_out_mux = ark_out[71:64];
		    	  4'h9 : ark_out_mux = ark_out[79:72];
		    	  4'hA : ark_out_mux = ark_out[87:80];
		    	  4'hB : ark_out_mux = ark_out[95:88];
		    	  4'hC : ark_out_mux = ark_out[103:96];
		    	  4'hD : ark_out_mux = ark_out[111:104];
		    	  4'hE : ark_out_mux = ark_out[119:112];
		    	  4'hF : ark_out_mux = ark_out[127:120];
		    	  default : ark_out_mux = ark_out[7:0];
		    	endcase
		      end

		//AES Mix Columns operation
		aes_inv_mixcol_gm_radix8 mixcol(.byte_in(ark_out_mux),
				                        .gm14_out(gm14_out),
				                        .gm13_out(gm13_out),
				                        .gm9_out(gm9_out),
				                        .gm11_out(gm11_out));





        //Accumulation Register for Galois Mult by 9
        accumulation_reg_8 accum_gm9(.in(gm9_out),
                                     .clk(clk),
                                     .enable(1'b1),
                                     .out(gm9_accum_out));
        //Accumulation Register for Galois Mult by 11
        accumulation_reg_8 accum_gm11(.in(gm11_out),
                                      .clk(clk),
                                      .enable(1'b1),
                                      .out(gm11_accum_out));
        //Accumulation Register for Galois Mult by 13
        accumulation_reg_8 accum_gm13(.in(gm13_out),
                                      .clk(clk),
                                      .enable(1'b1),
                                      .out(gm13_accum_out));
        //Accumulation Register for Galois Mult by 14       
        accumulation_reg_8 accum_gm14(.in(gm14_out),
                                      .clk(clk),
                                      .enable(1'b1),
                                      .out(gm14_accum_out));
        //Recombination for Inverse Mix Columns
        inv_mixcol_recomb_radix8 recomb(.gm9_in(gm9_accum_out),
                                        .gm11_in(gm11_accum_out),
                                        .gm13_in(gm13_accum_out),
                                        .gm14_in(gm14_accum_out),
                                        .mixed_out(mixCol_out));
        
        //Register mixcol_out so next stage can operate without it changing
        //We want it registered on 3,7,11,15
        always @(posedge clk)
          begin
          
            if(width_sel[0] & width_sel[1])
            begin
                mixCol_reg <= mixCol_out;
            end
          
          
          end
        
        
        //Mux 32 bit output from mixcol register back to 8 bits
        always_comb
		      begin
		    	case(width_sel)
		    	  //Last segment, this is used to allow data
		    	  //to propagate through on the next round
		    	  //so we don't lose cycles
		    	  4'h0 : mixCol_out_mux = mixCol_reg[7:0];
		    	  4'h1 : mixCol_out_mux = mixCol_reg[15:8];
		    	  4'h2 : mixCol_out_mux = mixCol_reg[23:16];
		    	  4'h3 : mixCol_out_mux = mixCol_reg[31:24];
		    	  //Lowest word
		    	  4'h4 : mixCol_out_mux = mixCol_reg[7:0];
		    	  4'h5 : mixCol_out_mux = mixCol_reg[15:8];
		    	  4'h6 : mixCol_out_mux = mixCol_reg[23:16];
		    	  4'h7 : mixCol_out_mux = mixCol_reg[31:24];
		    	  //2nd word (from right)
		    	  4'h8 : mixCol_out_mux = mixCol_reg[7:0];
		    	  4'h9 : mixCol_out_mux = mixCol_reg[15:8];
		    	  4'hA : mixCol_out_mux = mixCol_reg[23:16];
		    	  4'hB : mixCol_out_mux = mixCol_reg[31:24];
		    	  //3rd word (from right)
		    	  4'hC : mixCol_out_mux = mixCol_reg[7:0];
		    	  4'hD : mixCol_out_mux = mixCol_reg[15:8];
		    	  4'hE : mixCol_out_mux = mixCol_reg[23:16];
		    	  4'hF : mixCol_out_mux = mixCol_reg[31:24];
		    	  //Default Case
		    	  default : mixCol_out_mux = mixCol_out[7:0];
		    	endcase
		      end
        
        
        
		//We want to skip mix columns (alter the input to shiftRow) on round 0
		assign sbox_in = r0_flag ? ark_out_mux : mixCol_out_mux;


		//AES Substitution Box operation
		aes_inv_sbox sbox(.in(sbox_in),
				          .out(sbox_out));



        //Accumulate 8 bit words for multiple cycles
        accumulation_reg_8_128 accum(.in(sbox_out),
                               .clk(clk),
                               .enable(1'b1),
                               .out(shiftRow_in));


		//AES Shift rows operation
		aes_inv_shiftrow srow(.dataIn(shiftRow_in),
				  .dataOut(shiftRow_out));



		//Check if this is the last round of whatever mode we are in
		assign last_round = (r10_flag & AES_128_MODE) | (r12_flag & AES_192_MODE) | (r14_flag & AES_256_MODE);

		//Assign data out to the output of the ark if it is the last round or the sbox otherwise
		assign data_out = last_round ? ark_out : shiftRow_out;
		
endmodule



//Accumulation reg with 8 bit input and 128 bit output
module accumulation_reg_8_128(input logic [7:0] in,
                        input logic clk, enable, 
                        output logic [127:0] out);
                        
    logic [127:0] out_prev;
    logic [127:0] prev_shift;
    
    assign prev_shift = out_prev >> 8;
    assign out = {in,prev_shift[119:0]};
    
    //Accumulate in 32 bit increments on clk
    always @(posedge clk)
      begin
        if(enable == 1'b1)
          begin
            out_prev <= out;
          end
      end

endmodule
