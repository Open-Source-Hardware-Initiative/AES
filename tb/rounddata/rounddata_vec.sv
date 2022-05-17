/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains a test vector based shift row testbench
*/

`include "../../hdl/aes_rounddata.sv"

module rounddata_tb();


	logic [127:0] key_in;
	logic [3:0] round;
	logic [31:0] word_in;
	logic [127:0] data_out;
	logic [127:0] round_key;
	logic [127:0] data_in;
	integer i;
	
	
	//Test Vector Logic
	logic [383:0] shift_mem [10001:0];
	logic [127:0] expected_out;
	logic clk;
	
    integer debug = 1;
	
	
	aes_rounddata dut(.round(round),
		            .mode(2'b00),
		            .round_key(round_key),
		            .data_in(data_in),
		            .data_out(data_out));
	
	//Set CLK
	always
	  begin
		clk = 0; #5; clk = 1; #5;
	  end


	initial
	  begin
	    $readmemh("tv/tv.txt",shift_mem);
	    round_key = shift_mem[0][127:0];
		data_in = shift_mem[0][255:128];
		expected_out = shift_mem[0][383:256];
		$display("-----------------------------\n   START TEST\n-----------------------------\n");
		i = 1;
		round = 2'h1;
	  end


	always @(posedge clk)
	  begin
	  
	  		if(debug == 1)
		  begin
		  			$display("Debug Test Output\n-----------------------------\nInput Key : %h\nInput Data : %h\nExpected Output : %h\nDUT Output : %h",round_key,data_in,expected_out,data_out);
		  
		  end
	  
	  
	  
		if(data_out != expected_out)
		  begin
			$display("Test Failed!\n-----------------------------\nInput Key : %h\nInput Word : %h\nInput Round : %h\nExpected Output : %h\nDUT Output : %h",key_in,word_in,round,expected_out,data_out);
			$display("-----------------------------\n    ^ TEST FAILED ^\n-----------------------------\n");
			$stop;
		  end
		else
		  begin
	        round_key = shift_mem[i][127:0];
		    data_in = shift_mem[i][255:128];
		    expected_out = shift_mem[i][383:256];
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
