/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains a test vector based inverse shift row testbench
*/

module shiftRow_tb();


	logic [127:0] data_in;
	logic [127:0] data_out;
	integer i;
	
	
	//Test Vector Logic
	logic [255:0] shift_mem [10000:0];
	logic [127:0] expected_out;
	logic clk;
	
	aes_inv_shiftrow dut(.dataIn(data_in),
		     .dataOut(data_out));
	
	//Set CLK
	always
	  begin
		clk = 0; #5; clk = 1; #5;
	  end


	initial
	  begin
	    $readmemh("tv/tv.txt",shift_mem);
	    data_in = shift_mem[0][127:0];
		expected_out = shift_mem[0][255:128];
		$display("-----------------------------\n   START TEST\n-----------------------------\n");
		i = 1;
	  end


	always @(posedge clk)
	  begin
	  
		if(data_out != expected_out)
		  begin
			$display("Test Failed!\n-----------------------------\nInput : %h\nExpected Output : %h\nDUT Output : %h",data_in,expected_out,data_out);
			$display("-----------------------------\n    ^ TEST FAILED ^\n-----------------------------\n");
			$stop;
		  end
		else
		  begin
		    data_in = shift_mem[i][127:0];
		    expected_out = shift_mem[i][255:128];
		  end
		
		if(i == 1000)
		  begin
			$display("Completed All Vectors!");
			$display("-----------------------------\n    TEST SUCCEDED\n-----------------------------\n");




			$stop;
		  end
		i = i+1;
	  end
endmodule
