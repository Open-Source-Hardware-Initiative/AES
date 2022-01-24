/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains a printing method for all the outputs of SBOX
	    (for visual debugging)
*/

module sbox_tb();


	logic [7:0] in;
	logic [7:0] out;
	integer i;
	
	
	aes_sbox dut(.in(in),
		     .out(out));
	
	initial
	  begin
		for (i = 0; i<256; i = i + 1)
		  begin
		    in = i;
		    $display("SBOX output for %h is %h",in,out);
		    #10;
		  
		  end
	  
	  end

endmodule
