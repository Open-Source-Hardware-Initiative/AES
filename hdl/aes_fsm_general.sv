/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This module contains a generalized version
	    of the AES FSM that should work regardless of
	    key size.
*/


module aes_fsm_gen(input logic [1:0] mode,
		   input logic clk,
		   input logic reset,
		   input logic start, //Should be asserted when all info is provided
		   input logic enc_dec,
		   input logic [3:0] roundAmount,
		   output logic [3:0] round, dec_key_schedule_round, 
		   output logic enc_dec_reg, dec_key_gen,
		   output logic [1:0] radix_width_sel,
		   output logic done, round_complete, round_start);
		   
		   
		logic [4:0] CURRENT_STATE;
		logic [4:0] NEXT_STATE;
		logic start_prev;
		//Register for mode so we can make sure it is the same for the whole operation
		logic [1:0] mode_reg;
        logic [3:0] dec_key_schedule_round_next;
        logic [1:0] radix_width_sel_next;
		
		parameter [4:0]
		S0=5'h00, S1=5'h01, S2=5'h02, S3=5'h03, S4=5'h04, S5=5'h05,
		S6=5'h06, S7=5'h07, S8=5'h08, S9=5'h09, S10=5'h0A, S11=5'h0B,
		S12=5'h0C, S13=5'h0D, S14=5'h0E, S15=5'h0F, S16=5'h10;

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
				dec_key_schedule_round <= dec_key_schedule_round_next;
				radix_width_sel <= radix_width_sel_next;
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
				
				
				if(start)
				  begin
				    if(enc_dec_reg == 1'b0)
				      begin
				        NEXT_STATE = S1;
				        dec_key_gen = 1'b0;
				        dec_key_schedule_round_next = 4'h0;
				        radix_width_sel_next = 2'b0;
				        round_complete = 1'b1;
				      end
				    else
				      begin
				        NEXT_STATE = S15;
				        dec_key_schedule_round_next = 4'h0;
				        radix_width_sel_next = 2'b0;
				      end
				  end
				else
				  begin
				    NEXT_STATE = S0;
				  end
			end //S0
			
			//Begin State 1 (Round 1)
			S1 : begin
			    dec_key_gen = 1'b0;
				round = 4'h1;
				done = 1'b0;
				round_complete = 1'b0;
				if(radix_width_sel == 2'b11)
				  begin
				    radix_width_sel_next = 2'b0;
				    round_complete = 1'b1;
			        NEXT_STATE = S2;
			        round_start = 1'b1;
				  end
				else
				  begin
				    radix_width_sel_next = radix_width_sel + 1;
				    NEXT_STATE = S1;
				    round_start = 1'b0;
				  end
				
				
			end //S1
			
			//Begin State 2 (Round 2)
			S2 : begin
				round = 4'h2;
				done = 1'b0;
				NEXT_STATE = S3;
				
				round_complete = 1'b0;
				if(radix_width_sel == 2'b11)
				  begin
				    radix_width_sel_next = 2'b0;
				    round_complete = 1'b1;
			        NEXT_STATE = S3;
			        round_start = 1'b1;
				  end
				else
				  begin
				    radix_width_sel_next = radix_width_sel + 1;
				    NEXT_STATE = S2;
				    round_start = 1'b0;
				  end
			end //S2
			
			//Begin State 3 (Round 3)
			S3 : begin
				round = 4'h3;
				done = 1'b0;

				round_complete = 1'b0;
				if(radix_width_sel == 2'b11)
				  begin
				    radix_width_sel_next = 2'b0;
				    round_complete = 1'b1;
			        NEXT_STATE = S4;
			        round_start = 1'b1;
				  end
				else
				  begin
				    radix_width_sel_next = radix_width_sel + 1;
				    NEXT_STATE = S3;
				    round_start = 1'b0;
				  end
			end //S3
			
			//Begin State 4 (Round 4)
			S4 : begin
				round = 4'h4;
				done = 1'b0;
				round_complete = 1'b0;
				if(radix_width_sel == 2'b11)
				  begin
				    radix_width_sel_next = 2'b0;
				    round_complete = 1'b1;
			        NEXT_STATE = S5;
			        round_start = 1'b1;
				  end
				else
				  begin
				    radix_width_sel_next = radix_width_sel + 1;
				    NEXT_STATE = S4;
				    round_start = 1'b0;
				  end
			end //S4
			
			//Begin State 5 (Round 5)
			S5 : begin
				round = 4'h5;
				done = 1'b0;
				round_complete = 1'b0;
				if(radix_width_sel == 2'b11)
				  begin
				    radix_width_sel_next = 2'b0;
				    round_complete = 1'b1;
			        NEXT_STATE = S6;
			        round_start = 1'b1;
				  end
				else
				  begin
				    radix_width_sel_next = radix_width_sel + 1;
				    NEXT_STATE = S5;
				    round_start = 1'b0;
				  end
			end //S5
			
			//Begin State 6 (Round 6)
			S6 : begin
				round = 4'h6;
				done = 1'b0;
				round_complete = 1'b0;
				if(radix_width_sel == 2'b11)
				  begin
				    radix_width_sel_next = 2'b0;
				    round_complete = 1'b1;
			        NEXT_STATE = S7;
			        round_start = 1'b1;
				  end
				else
				  begin
				    radix_width_sel_next = radix_width_sel + 1;
				    NEXT_STATE = S6;
				    round_start = 1'b0;
				  end
			end //S6
			
			//Begin State 7 (Round 7)
			S7 : begin
				round = 4'h7;
				done = 1'b0;
				round_complete = 1'b0;
				if(radix_width_sel == 2'b11)
				  begin
				    radix_width_sel_next = 2'b0;
				    round_complete = 1'b1;
			        NEXT_STATE = S8;
			        round_start = 1'b1;
				  end
				else
				  begin
				    radix_width_sel_next = radix_width_sel + 1;
				    NEXT_STATE = S7;
				    round_start = 1'b0;
				  end
			end //S7
			
			//Begin State 8 (Round 8)
			S8 : begin
				round = 4'h8;
				done = 1'b0;
				round_complete = 1'b0;
				if(radix_width_sel == 2'b11)
				  begin
				    radix_width_sel_next = 2'b0;
				    round_complete = 1'b1;
			        NEXT_STATE = S9;
			        round_start = 1'b1;
				  end
				else
				  begin
				    radix_width_sel_next = radix_width_sel + 1;
				    NEXT_STATE = S8;
				    round_start = 1'b0;
				  end
			end //S8
			
			//Begin State 9 (Round 9)
			S9 : begin
				round = 4'h9;
				done = 1'b0;
				round_complete = 1'b0;
				if(radix_width_sel == 2'b11)
				  begin
				    radix_width_sel_next = 2'b0;
				    round_complete = 1'b1;
			        NEXT_STATE = S10;
			        round_start = 1'b1;
				  end
				else
				  begin
				    radix_width_sel_next = radix_width_sel + 1;
				    NEXT_STATE = S9;
				    round_start = 1'b0;
				  end
			end //S9
			
			//Begin State 10 (Round A)
			S10 : begin
				    round = 4'hA;
				    //Last round for AES128
				    if(mode == 2'b00)
				      begin
				    
				    //Radix Management
				    round_complete = 1'b0;
				    if(radix_width_sel == 2'b11)
				      begin
                        done = 1'b1;
				        radix_width_sel_next = 2'b0;
				        round_complete = 1'b1;
			            NEXT_STATE = S0;
			            round_start = 1'b1;
				      end
				    else
				      begin
				        radix_width_sel_next = radix_width_sel + 1;
				        NEXT_STATE = S10;
				        round_start = 1'b0;
				      end
				      
				  end
				//If not AES 128 then move on
				else
				  begin
				    done = 1'b0;
				    //Radix Management
				    round_complete = 1'b0;
				    if(radix_width_sel == 2'b11)
				      begin
                        done = 1'b0;
				        radix_width_sel_next = 2'b0;
				        round_complete = 1'b1;
			            NEXT_STATE = S11;
			            round_start = 1'b1;
				      end
				    else
				      begin
				        radix_width_sel_next = radix_width_sel + 1;
				        NEXT_STATE = S10;
				        round_start = 1'b0;
				      end
				    
				      
				  end
			end //S10
			
			
			//Round 11
			S11 : begin
				round = 4'hB;
				done = 1'b0;
			    //Radix Management
				    round_complete = 1'b0;
				    if(radix_width_sel == 2'b11)
				      begin
                        done = 1'b0;
				        radix_width_sel_next = 2'b0;
				        round_complete = 1'b1;
			            NEXT_STATE = S12;
			            round_start = 1'b1;
				      end
				    else
				      begin
				        radix_width_sel_next = radix_width_sel + 1;
				        NEXT_STATE = S11;
				        round_start = 1'b0;
				      end
			     end //S11
				
				
		    //Round 12
			S12 : begin
				round = 4'hC;
				//Last Round for AES192
				if(mode == 2'b01)
				  begin
				    //Radix Management
				    round_complete = 1'b0;
				    if(radix_width_sel == 2'b11)
				      begin
                        done = 1'b1;
				        radix_width_sel_next = 2'b0;
				        round_complete = 1'b1;
			            NEXT_STATE = S0;
			            round_start = 1'b1;
				      end
				    else
				      begin
				        radix_width_sel_next = radix_width_sel + 1;
				        NEXT_STATE = S12;
				        round_start = 1'b0;
				      end
				  end
				//Otherwise go to S13
				else
				  begin
				    done = 1'b0;
				    //Radix Management
				    round_complete = 1'b0;
				    if(radix_width_sel == 2'b11)
				      begin
				        radix_width_sel_next = 2'b0;
				        round_complete = 1'b1;
			            NEXT_STATE = S13;
			            round_start = 1'b1;
				      end
				    else
				      begin
				        radix_width_sel_next = radix_width_sel + 1;
				        NEXT_STATE = S12;
				        round_start = 1'b0;
				      end	  
				  end
			end //S12
			
			//Round 13
			S13 : begin
				round = 4'hD;
				done = 1'b0;
				    //Radix Management
				    round_complete = 1'b0;
				    if(radix_width_sel == 2'b11)
				      begin
				        radix_width_sel_next = 2'b0;
				        round_complete = 1'b1;
			            NEXT_STATE = S14;
			            round_start = 1'b1;
				      end
				    else
				      begin
				        radix_width_sel_next = radix_width_sel + 1;
				        NEXT_STATE = S13;
				        round_start = 1'b0;
				      end
			      end


            //Round 14
		    S14 : begin
		      		//Last round for AES256
		      	        round = 4'hE;

		      	    //Radix Management
				    round_complete = 1'b0;
				    if(radix_width_sel == 2'b11)
				      begin
                        done = 1'b1;
				        radix_width_sel_next = 2'b0;
				        round_complete = 1'b1;
			            NEXT_STATE = S0;
			            round_start = 1'b1;
				      end
				    else
				      begin
				        radix_width_sel_next = radix_width_sel + 1;
				        NEXT_STATE = S14;
				        round_start = 1'b0;
				      end
		            end
		            
		    			
			//Loop State for generating reverse key schedule
			S15 : begin
			    done = 1'b0;
			    dec_key_gen = 1'b1;
			    
			    if(dec_key_schedule_round == roundAmount)
			      begin
			        round_start = 1'b1;
			        NEXT_STATE = S16;
			      end
			    else
			      begin
			        NEXT_STATE = S15;
			        dec_key_schedule_round_next = dec_key_schedule_round + 1;
			      end
			     			      
			    end //S15



			//Begin State 1 (Decipher Round 0)
			S16 : begin
			    dec_key_gen = 1'b0;
				round = 4'h0;
				done = 1'b0;
				round_complete = 1'b0;
				if(radix_width_sel == 2'b11)
				  begin
				    radix_width_sel_next = 2'b0;
				    round_complete = 1'b1;
			        NEXT_STATE = S1;
			        round_start = 1'b1;
				  end
				else
				  begin
				    radix_width_sel_next = radix_width_sel + 1;
				    NEXT_STATE = S16;
				    round_start = 1'b0;
				  end
				end


			      
			      
			endcase;
			

endmodule
		
			
