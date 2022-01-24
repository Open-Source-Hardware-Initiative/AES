/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains the AES single word rotate operation. Basically
* a one byte logicl shift
*/

module rotTest();

	logic [31:0] word;
	logic [31:0] correctRot;
	logic [31:0] rotWord;
	
	//A word and it's correct rotation
	assign word = 32'hE3771889;
	assign correctRot = 32'h771889E3;

	aesRotateWord dut(.disableRotate(1'b0),
					  .inWord(word),
					  .rotWord(rotWord));

	initial
	  begin
		#100;
		if(rotWord != correctRot)
		  begin
			$display("ERROR : ROTATE UNIT TEST FAILED");
		  end
		else
		  begin
			$display("ROTATE WORD TEST PASSED!");
		  end
		$stop;
	  end

endmodule
