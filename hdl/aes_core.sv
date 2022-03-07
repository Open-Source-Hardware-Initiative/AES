/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This module contains a base design for a
*	    generalized AES core
*/


module aes_core_gen(input logic start,
		    input logic clk,
		    input logic reset,
		    input logic enc_dec, //1 for decipher 0 for encipher
		    input logic [1:0] mode,
		    input logic [255:0] key,
		    input logic [127:0] data_in,
		    output logic [127:0] data_out,
		    output logic done);
		    
		    
		    logic [127:0] round_keys [14:0];
		    //Logic value to hold round number from FSM
		    logic [3:0] round;
		    //Encipher Data
		    logic [127:0] data_out_enc;
		    //Decipher Data
		    logic [127:0] data_out_dec;
		    //Save Current State
		    logic [127:0] aes_state;
		    logic [127:0] enc_dec_state;
		    logic [127:0] internal_data;
		    logic [127:0] dec_key_out;
		    //Register to hold encipher_decipher state for whole operation
		    logic enc_dec_reg;
		    logic r0_flag;
		    //Value to hold number of rounds for generalization of vector select
		    logic [3:0] roundAmount;
		    
		    //Decipher Key Signaling
		    logic dec_key_gen;
		    logic [3:0] dec_key_schedule_round;
		    
		    //Set roundAmount based on mode
		    //TODO THIS SHOULD BE MOVED TO THE FSM AND NOT DONE THIS WAY
		    always_comb
		      begin
		    	case(mode)
		    	  2'b00 : roundAmount = 4'd10;
		    	  2'b01 : roundAmount = 4'd12;
		    	  2'b10 : roundAmount = 4'd14;
		    	  default : roundAmount = 4'd14;
		    	endcase
		      end

		    
		    //AES round key
		    aes_roundkey_gen rkgen(.mode(mode),
		    			   .key_in(key),
		    			   .round_key(round_keys));
		    
		    //AES FSM 128
		    aes_fsm_gen fsm(.mode(mode),
		    		    .clk(clk),
		    		    .reset(reset),
		    		    .start(start),
		    		    .enc_dec(enc_dec),
		    		    .enc_dec_reg(enc_dec_reg),
		    		    .round(round),
		    		    .done(done),
		    		    .dec_key_schedule_round(dec_key_schedule_round),
		    		    .dec_key_gen(dec_key_gen));


		    //Encipher Datapath
		    aes_rounddata enc_data(.round(round),
		    			   .mode(mode),
		    			   .round_key(round_keys[round]),
		    			   .data_in(internal_data),
		    			   .data_out(data_out_enc));
		    			   
		    //Decipher Datapath
		    aes_inv_rounddata dec_data(.round(round),
		    		      	       .mode(mode),
		    		      	       .round_key(round_keys[roundAmount -round]),
		    		               .data_in(internal_data),
                                   .data_out(data_out_dec));
		    			   
		    //Select between encipher or decipher state
		    assign enc_dec_state = enc_dec_reg ? data_out_dec : data_out_enc;
		    
		    //Register the loopback encipher/decipher data
		    always @(posedge clk)
		      begin
			aes_state = enc_dec_state;
		      end //always @(posedge clk)

		    //Check for round 0
		    assign r0_flag = ~(round[0] | round[1] | round[2] | round[3]);
		    assign internal_data = r0_flag ? data_in : aes_state;	
		    
		    //TODO make this only happen on done?
		    assign data_out = enc_dec_state;
		    
		    
		    //Instantiate a key memory to hold decipher keys
		    decipher_key_mem dkm(.clk(clk),
		                         .dec_key_gen(dec_key_gen),
		                         .enc_dec(enc_dec),
		                         .round_key_in(round_keys[dec_key_schedule_round]),
		                         .round(dec_key_schedule_round),
		                         .key_out(dec_key_out));
		    

		    
		    
endmodule


/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This module contains a inefficient design for
	    an AES unit. This is not currently an efficient
	    model. Just a proof of concept for now.
*/

module aes_core_128(input logic start,
		    input logic clk,
		    input logic reset,
		    input logic enc_dec, //1 for decipher 0 for encipher
		    input logic [1:0] mode,
		    input logic [127:0] key,
		    input logic [127:0] data_in,
		    output logic [127:0] data_out,
		    output logic done);
		    
		    
		    logic [127:0] round_keys [10:0];
		    //Logic value to hold round number from FSM
		    logic [3:0] round;
		    //Encipher Data
		    logic [127:0] data_out_enc;
		    //Decipher Data
		    logic [127:0] data_out_dec;
		    //Save Current State
		    logic [127:0] aes_state;
		    logic [127:0] enc_dec_state;
		    logic [127:0] internal_data;
		    //Register to hold encipher_decipher state for whole operation
		    logic enc_dec_reg;
		    logic r0_flag;
		    

		    
		    //AES round key
		    aes_roundkey_128 rk128(.mode(mode),
		    			   .key_in(key),
		    			   .round_key(round_keys));
		    
		    //AES FSM 128
		    aes_fsm_gen fsm(.mode(mode),
		    		    .clk(clk),
		    		    .reset(reset),
		    		    .start(start),
		    		    .enc_dec(enc_dec),
		    		    .enc_dec_reg(enc_dec_reg),
		    		    .round(round),
		    		    .done(done));
		    
		    //Encipher Datapath
		    aes_rounddata enc_data(.round(round),
		    			   .mode(mode),
		    			   .round_key(round_keys[round]),
		    			   .data_in(internal_data),
		    			   .data_out(data_out_enc));
		    			   
		    //Decipher Datapath
		    aes_inv_rounddata dec_data(.round(round),
		    		      	       .mode(mode),
		    		      	       .round_key(round_keys[10-round]),
		    		               .data_in(internal_data),
                                                .data_out(data_out_dec));
		    			   
		    //Select between encipher or decipher state
		    assign enc_dec_state = enc_dec_reg ? data_out_dec : data_out_enc;
		    
		    //Register the loopback encipher/decipher data
		    always @(posedge clk)
		      begin
			aes_state = enc_dec_state;
		      end //always @(posedge clk)

		    //Check for round 0
		    assign r0_flag = ~(round[0] | round[1] | round[2] | round[3]);
		    assign internal_data = r0_flag ? data_in : aes_state;	
		    
		    //TODO make this only happen on done?
		    assign data_out = enc_dec_state;
		    
		    
		    
		    
endmodule
