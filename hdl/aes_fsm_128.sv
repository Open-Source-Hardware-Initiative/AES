/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This module contains the control logic for
*	    a basic 128 bit key AES unit I hope to
	    make this more modular in the future or write 
	    something to generate an FSM
*/


module aes_fsm_128(input logic [1:0] mode,
		   input logic clk,
		   input logic reset,
		   input logic start, //Should be asserted when all info is provided
		   input logic enc_dec,
		   output logic [3:0] round,
		   output logic enc_dec_reg,
		   output logic done);
		   
		   
		logic [3:0] CURRENT_STATE;
		logic [3:0] NEXT_STATE;
		logic start_prev;
		//Register for mode so we can make sure it is the same for the whole operation
		logic [1:0] mode_reg;
		
		parameter [3:0]
		S0=4'h0, S1=4'h1, S2=4'h2, S3=4'h3, S4=4'h4, S5=4'h5,
		S6=4'h6, S7=4'h7, S8=4'h8, S9=4'h9, S10=4'hA, S11=4'hB,
		S12=4'hC, S13=4'hD, S14=4'hE, S15=4'hF;

		always @(posedge clk)
		  begin
			if(reset == 1'b1)
			  begin
				CURRENT_STATE <= S0;
				start_prev <= 1'b0;
			  end
			else
			  begin
				CURRENT_STATE <= NEXT_STATE;
				start_prev <= start;
			  end
		  end
		  
		  
		  
		//Start State change logic.
		always_comb
			case(CURRENT_STATE)
			
			
			//Begin State 0 (Round 0)
			S0: begin
				round = 4'h0;
				done = 1'b0;
				enc_dec_reg = enc_dec;
				
				if(~start_prev & start)
				  begin
				    NEXT_STATE = S1;
				  end
			end //S0
			
			//Begin State 1 (Round 1)
			S1 : begin
				round = 4'h1;
				done = 1'b0;
				NEXT_STATE = S2;
			end //S1
			
			//Begin State 2 (Round 2)
			S2 : begin
				round = 4'h2;
				done = 1'b0;
				NEXT_STATE = S3;
			end //S2
			
			//Begin State 3 (Round 3)
			S3 : begin
				round = 4'h3;
				done = 1'b0;
				NEXT_STATE = S4;
			end //S3
			
			//Begin State 4 (Round 4)
			S4 : begin
				round = 4'h4;
				done = 1'b0;
				NEXT_STATE = S5;
			end //S4
			
			//Begin State 5 (Round 5)
			S5 : begin
				round = 4'h5;
				done = 1'b0;
				NEXT_STATE = S6;
			end //S5
			
			//Begin State 6 (Round 6)
			S6 : begin
				round = 4'h6;
				done = 1'b0;
				NEXT_STATE = S7;
			end
			
			//Begin State 7 (Round 7)
			S7 : begin
				round = 4'h7;
				done = 1'b0;
				NEXT_STATE = S8;
			end
			
			//Begin State 8 (Round 8)
			S8 : begin
				round = 4'h8;
				done = 1'b0;
				NEXT_STATE = S9;
			end
			
			//Begin State 9 (Round 9)
			S9 : begin
				round = 4'h9;
				done = 1'b0;
				NEXT_STATE = S10;
			end
			
			//Begin State 10 (Round A)
			S10 : begin
				round = 4'hA;
				done = 1'b1;
				NEXT_STATE = S0;
			end
			
			
			endcase;
endmodule
			
