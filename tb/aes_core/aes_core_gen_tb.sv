/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains the testbench for the generalized AES core
*/

module aes_core_gen_tb();

	logic [127:0] plaintext = 128'h6bc1bee22e409f96e93d7e117393172a;
	logic [255:0] base_key = 256'h603deb1015ca71be2b73aef0857d77811f352c073b6108d72d9810a30914dff4;
	logic [127:0] ciphertext = 128'hf3eed1bdb5d2a03c064b5a7e3db181f8;
	
	
	/*
	 0: 603deb1015ca71be2b73aef0857d7781
	 1: 1f352c073b6108d72d9810a30914dff4
	 2: 9ba354118e6925afa51a8b5f2067fcde
	 3: a8b09c1a93d194cdbe49846eb75d5b9a
	 4: d59aecb85bf3c917fee94248de8ebe96
	 5: b5a9328a2678a647983122292f6c79b3
	 6: 812c81addadf48ba24360af2fab8b464
	 7: 98c5bfc9bebd198e268c3ba709e04214
	 8: 68007bacb2df331696e939e46c518d80
	 9: c814e20476a9fb8a5025c02d59c58239
	10: de1369676ccc5a71fa2563959674ee15
	11: 5886ca5d2e2f31d77e0af1fa27cf73c3
	12: 749c47ab18501ddae2757e4f7401905a
	13: cafaaae3e4d59b349adf6acebd10190d
	14: fe4890d1e6188d0b046df344706c631e
	*/

	
	
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
		mode = 2'h2;
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
		mode = 2'h2;
		key = base_key;
		data_in = ciphertext;
		#20
		start = 1'b0;
		while(~done) #1;
	  	assert(data_out == plaintext);
	  	
	  	
	  	$display("Test Done! Check for assertion errors");
	  	
		$stop;
		
		
	  end
	  
endmodule : aes_core_gen_tb
