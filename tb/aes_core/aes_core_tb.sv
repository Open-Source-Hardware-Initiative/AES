/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains the testbench for the simple AES128 core
	    stole this vector from the secworks testbench :)
*/

module aes_core_tb();

	logic [127:0] plaintext = 128'h6bc1bee22e409f96e93d7e117393172a;
	logic [255:0] base_key = {128'h2b7e151628aed2a6abf7158809cf4f3c, 128'h0} ;
	logic [127:0] ciphertext = 128'h3ad77bb40d7a3660a89ecaf32466ef97;
	
	//Internal logic signals
	logic start;
	logic clk;
	logic reset;
	logic enc_dec;
	logic [1:0] mode;
	logic [255:0] key;
	logic [127:0] data_in;
	logic [127:0] data_out;
	
	
	aes_core_gen dut(.start(start),
			 .clk(clk),
			 .reset(reset),
			 .enc_dec(enc_dec),
			 .mode(mode),
			 .key(key),
			 .data_in(data_in),
			 .data_out(data_out),
			 .done(done));
	
	//Generate clk signal	
	initial
	  begin
		clk = 1'b1;
		forever #5 clk = ~clk;
	  end 
	
	//Run testbench
	initial
	  begin
	  
	  
	  
	  
	  	//Encipher
	  	reset = 1'b1;
	  	#100
	  	//Set AES inputs and hope it workzz
		start = 1'b1;
		reset = 1'b0;
		enc_dec = 1'b0; //0 for encipher
		mode = 2'h0;
		key = base_key;
		data_in = plaintext;
		#20
		start = 1'b0;
		while(~done) #1;
	  	assert(data_out == ciphertext);
	  
	  
	  	//Decipher
	  	reset = 1'b1;
	  	#100
	  	//Set AES inputs and hope it workzz
		start = 1'b1;
		reset = 1'b0;
		enc_dec = 1'b1; //1 for decipher
		mode = 2'h0;
		key = base_key;
		data_in = ciphertext;
		#20
		start = 1'b0;
		while(~done) #1;
	  	assert(data_out == plaintext);
		$stop;
		

        $display("Test Complete! check for assertion errors!");
		
	  end
	  
endmodule : aes_core_tb
