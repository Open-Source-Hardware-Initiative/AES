/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains a test vector based shift row testbench
*/

module key_xor_tb();


	logic [127:0] key_in;
	logic [3:0] round;
	logic [31:0] word_in;
	logic [127:0] data_out;
	integer i;
	
	
	//Test Vector Logic
	logic [291:0] shift_mem [10001:0];
	logic [127:0] expected_out;
	logic clk;
	
	aes_key_xor dut(.RD(round),
		            .mode(2'b00),
		            .keyBox_out(word_in),
		            .old_key(key_in),
		            .new_key(data_out));




	
	//Set CLK
	always
	  begin
		clk = 0; #5; clk = 1; #5;
	  end


	initial
	  begin
	    $readmemh("tv/tv.txt",shift_mem);
	    expected_out = shift_mem[0][127:0];
	    round = shift_mem[0][131:128];
	    word_in = shift_mem[0][163:132];
		key_in = shift_mem[0][291:164];
		$display("-----------------------------\n   START TEST\n-----------------------------\n");
		i = 1;
	  end


	always @(posedge clk)
	  begin
	  
		if(data_out != expected_out)
		  begin
			$display("Test Failed!\n-----------------------------\nInput Key : %h\nInput Word : %h\nInput Round : %h\nExpected Output : %h\nDUT Output : %h",key_in,word_in,round,expected_out,data_out);
			$display("-----------------------------\n    ^ TEST FAILED ^\n-----------------------------\n");
			$stop;
		  end
		else
		  begin
	        expected_out = shift_mem[i][127:0];
	        round = shift_mem[i][131:128];
	        word_in = shift_mem[i][163:132];
		    key_in = shift_mem[i][291:164];
		  end
		
		if(i == 10000)
		  begin
			$display("Completed All Vectors!");
			$display("-----------------------------\n    TEST SUCCEDED\n-----------------------------\n");
			$stop;
		  end
		i = i+1;
	  end
endmodule
