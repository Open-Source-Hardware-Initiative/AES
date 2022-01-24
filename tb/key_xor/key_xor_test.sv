/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains the AES single word rotate operation. Basically
* a one byte logicl shift
*/

module keyxorTest();

	//aes_key_xor inputs
	logic [3:0] RD;
	logic [31:0] keyBox_out;
	logic [127:0] old_key;
	logic [127:0] new_key;
	//aes_key_xor outputs
	
	
	//A word and it's correct rotation
	assign old_key = 128'h0;


	aes_key_xor dut(.RD(RD),
			.keyBox_out(keyBox_out),
			.old_key(old_key),
			.new_key(new_key));

	initial
	  begin
		RD = 4'b0001;
		#100;
		RD = 4'b0010;
		#100;
		RD = 4'b0011;
		#100;
		RD = 4'b0100;
		#100;
		RD = 4'b0101;
		#100;
		RD = 4'b0110;
		#100;
		RD = 4'b0111;
		#100;
		RD = 4'b1001;
		#100;
		RD = 4'b1010;
		#100;
		RD = 4'b1001;
		#100;
		RD = 4'b1010;
		#100;
		RD = 4'b1011;
		#100;
		RD = 4'b1100;
		#100;
		RD = 4'b1101;
		#100;
		RD = 4'b1110;
		#100;

	  end

endmodule
