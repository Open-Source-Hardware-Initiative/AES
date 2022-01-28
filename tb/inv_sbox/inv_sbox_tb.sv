/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains an exhaustive Inverse Substitution Box Test
*/

module inv_sbox_tb();


	logic [7:0] in;
	logic [7:0] out;
	integer i;
	
	
	//Test Vector Logic
	logic [15:0] sub_mem [255:0];
	logic [7:0] expected_out;
	logic clk;
	
	aes_inv_sbox dut(.in(in),
		     .out(out));
	
	//Set CLK
	always
	  begin
		clk = 0; #5; clk = 1; #5;
	  end


	initial
	  begin
	    $readmemh("tv/tv.txt",sub_mem);
	    in = sub_mem[0][15:8];
		expected_out = sub_mem[0][7:0];
		i = 1;
	  end


	always @(posedge clk)
	  begin
	  
		if(out != expected_out)
		  begin
			$display("Test Failed!\nInput : %h\nExpected Output : %h\nDUT Output : %h",in,expected_out,out);
			$stop;
		  end
		else
		  begin
		    in = sub_mem[i][15:8];
		    expected_out = sub_mem[i][7:0];
		  end
		
		if(i == 256)
		  begin
			$display("Completed All Vectors!");

			$stop;
		  end
		i = i+1;
	  end
endmodule
