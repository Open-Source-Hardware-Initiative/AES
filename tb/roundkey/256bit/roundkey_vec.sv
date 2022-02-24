/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains a test vector based shift row testbench
*/

`include "../../../hdl/aes_roundkey.sv"

module roundkey_tb();


	logic [127:0] cur_key_in;
	logic [127:0] prev_key_in;
	logic [3:0] round;
	logic [31:0] word_in;
	logic [127:0] data_out;
	integer i;
	
	
	//Test Vector Logic
	logic [387:0] shift_mem [10001:0];
	logic [127:0] expected_out;
	logic clk;
	
	aes_roundkey dut(.RD(round),
		            .mode(2'b10),
		            .prev_key(prev_key_in),
		            .current_key(cur_key_in),
		            .round_key(data_out));
	
	//Set CLK
	always
	  begin
		clk = 0; #5; clk = 1; #5;
	  end


	initial
	  begin
	    $readmemh("tv/tv.txt",shift_mem);
	    expected_out = shift_mem[0][127:0];
		cur_key_in = shift_mem[0][255:128];
		prev_key_in = shift_mem[0][383:256];
		round = shift_mem[0][387:384];
		$display("-----------------------------\n   START TEST\n-----------------------------\n");
		i = 1;
	  end


	always @(posedge clk)
	  begin
	  
		if(data_out != expected_out)
		  begin
			$display("Test Failed!\n-----------------------------\nInput Prev Key : %h\nInput current key : %h\nInput Word : %h\nInput Round : %h\nExpected Output : %h\nDUT Output : %h",prev_key_in,cur_key_in,word_in,round,expected_out,data_out);
			$display("-----------------------------\n    ^ TEST FAILED ^\n-----------------------------\n");
			$stop;
		  end
		else
		  begin
	    expected_out = shift_mem[i][127:0];
		cur_key_in = shift_mem[i][255:128];
		prev_key_in = shift_mem[i][383:256];
		round = shift_mem[i][387:384];
		  end
		
		
		
		if(i == 900)
		  begin
			$display("Completed All Vectors!");
			$display("-----------------------------\n    TEST SUCCEDED\n-----------------------------\n");
			$stop;
		  end
		i = i+1;
	  end
	  
endmodule
