/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains a test vector based addroundkey testbench
*/

module addroundkey_tb();


	logic [127:0] data_in;
	logic [127:0] key_in;
	logic [127:0] data_out;
	integer i;
	
	
	//Test Vector Logic
	logic [383:0] shift_mem [10000:0];
	logic [127:0] expected_out;
	logic clk;
	
	aes_addroundkey dut(.data(data_in),
		     .round_key(key_in),
		     .sum(data_out));
	
	//Set CLK
	always
	  begin
		clk = 0; #5; clk = 1; #5;
	  end


	initial
	  begin
	    $readmemh("tv/tv.txt",shift_mem);
	    expected_out = shift_mem[0][127:0];
		key_in = shift_mem[0][255:128];
		data_in = shift_mem[0][383:256];
		
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
	        expected_out = shift_mem[i][127:0];
		    key_in = shift_mem[i][255:128];
		    data_in = shift_mem[i][383:256];
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
