/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains the AES single word rotate operation. Basically
* a one byte logicl shift
*/

module sbox_word_tb();


	logic [31:0] out;
	logic [31:0] correctOut; 
	logic [31:0] in;
	
	assign in = 32'h01243672;
	//Answer should be 
	// 01 : 7C
	// 24 : 36
	// 36 : 05
	// 72 : 40
	assign correctOut = 32'h7C360540;

	
	aes_sbox_word dut(.in(in),
			  .out(out));
	
	initial
	  begin
		#100;
		if(out != correctOut)
		  begin
			$display("ERROR : SBOX_WORD UNIT TEST FAILED");
		  end
		else
		  begin
			$display("SBOX_WORD TEST PASSED!");
		  end
		$stop;
	  end

endmodule
