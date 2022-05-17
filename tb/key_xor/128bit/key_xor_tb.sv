/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains the AES single word rotate operation. Basically
* a one byte logicl shift
*/

//Yoinked this example from the presentation at https://kavaliro.com/wp-content/uploads/2014/03/AES.pdf

module keyxor_tb();


	logic [3:0] RD;
	logic [1:0] mode;
	logic [31:0] keyBox_out;
	logic [127:0] old_key;
	logic [127:0] new_key;
	logic [127:0] new_key_correct;
	
	assign RD = 4'h1;
	assign keyBox_out = 32'hB75A9D85;
	assign old_key = 128'h5468617473206D79204B756E67204675;
	assign new_key_correct = 128'hE232FCF191129188B159E4E6D679A293;

	
	aes_key_xor dut(.RD(RD),
			.mode(mode),
			.keyBox_out(keyBox_out),
			.old_key(old_key),
			.new_key(new_key));
	
	initial
	  begin
		#100;
		if(new_key != new_key_correct)
		  begin
			$display("ERROR : KEY_XOR UNIT TEST FAILED");
		  end
		else
		  begin
			$display("KEY_XOR TEST PASSED!");
		  end
		$stop;
	  end

endmodule
