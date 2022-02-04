/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains a test vector based shift row testbench
*/

module mixWord_tb();


	logic [31:0] data_in;
	logic [31:0] data_out;
	integer i;
	
	
	//Test Vector Logic
	logic [63:0] mixword_mem [10000:0];
	logic [31:0] expected_out;
	logic clk;
	integer numVecs = 1000;
	
	mixword dut(.word(data_in),
		     .mixed_word(data_out));
	
	//Set CLK
	always
	  begin
		clk = 0; #5; clk = 1; #5;
	  end


	initial
	  begin
	    $readmemh("tv/tv.txt",mixword_mem);
	    data_in = mixword_mem[0][31:0];
		expected_out = mixword_mem[0][63:32];
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
		    data_in = mixword_mem[i][31:0];
		    expected_out = mixword_mem[i][63:32];
		  end
		
		if(i == numVecs)
		  begin
			$display("Completed All Vectors!");
			$display("-----------------------------\n    TEST SUCCEDED\n-----------------------------\n");




			$stop;
		  end
		i = i+1;
	  end
endmodule
