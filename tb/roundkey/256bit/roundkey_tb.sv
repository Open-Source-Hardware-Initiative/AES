/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains the AES single word rotate operation. Basically
* a one byte logicl shift
* https://crypto.stackexchange.com/questions/9573/aes-key-expansion-256bit-key
* https://kavaliro.com/wp-content/uploads/2014/03/AES.pdf
*/

module rdkey_tb();
	//Start key
	logic [255:0] start_key;

	//roundkey inputs
	logic [3:0] RD;
	logic [1:0] mode;
	logic [127:0] prev_key;
	logic [127:0] current_key;
	//roundkey output
	logic [127:0] round_key;
	
	logic [127:0] round_key_temp;
	
	assign start_key = 256'h1;
	/*
	 0: 00000000000000000000000000000000
	 1: 00000000000000000000000000000001
	 2: 62637c6362637c6362637c6362637c63
	 3: aafb10fbaafb10fbaafb10fbaafb10fa
	 4: 6fa951cf0dca2dac6fa951cf0dca2dac
	 5: 7d8fc86ad774d8917d8fc86ad774d890
	 6: f9c831c1f4021c6d9bab4da29661600e
	 7: ed6018c13a14c050479b083a90efd0aa
	 8: 2eb89da1daba81cc4111cc6ed770ac60
	 9: e3318911d92549419ebe417b0e5191d1
	10: ef39a30a358322c67492eea8a3e242c8
	11: e9a9a5f9308cecb8ae32adc3a0633c12
	12: 34d26aea0151482c75c3a684d621e44c
	13: 1f54ccd02fd8206881ea8dab2189b1b9
	14: d31a3c17d24b743ba788d2bf71a936f3
	*/
	assign mode = 2'b10; //AES256

	aes_roundkey dut(.RD(RD),
		     .mode(mode),
		     .prev_key(prev_key),
		     .current_key(current_key),
		     .round_key(round_key));
		     
	initial
	  begin
	  	//Calculate and check Round 2 key
	  	RD = 4'h2;
		prev_key = start_key[255:128];
		current_key = start_key[127:0];
		#10
		assert (round_key == 128'h62637c6362637c6362637c6362637c63);
		round_key_temp = round_key;
		
		//Calculate and check Round 3 key
		#100;
		RD = 4'h3;
		prev_key = current_key;
		current_key = round_key_temp;
		#10
		assert (round_key == 128'haafb10fbaafb10fbaafb10fbaafb10fa);
		round_key_temp = round_key;


		//Calculate and check Round 4 Key
		#100;
		RD = 4'h4;
		prev_key = current_key;
		current_key = round_key_temp;
		#10
		assert (round_key == 128'h6fa951cf0dca2dac6fa951cf0dca2dac);
		round_key_temp = round_key;


		//Calculate and check Round 5 Key
		#100;
		RD = 4'h5;
		prev_key = current_key;
		current_key = round_key_temp;
		#10
		assert (round_key == 128'h7d8fc86ad774d8917d8fc86ad774d890);
		round_key_temp = round_key;


		//Calculate and check Round 6 Key
		#100;
		RD = 4'h6;
		prev_key = current_key;
		current_key = round_key_temp;
		#10
		assert (round_key == 128'hf9c831c1f4021c6d9bab4da29661600e);
		round_key_temp = round_key;

		//Calculate and check Round 7 Key
		#100;
		RD = 4'h7;
		prev_key = current_key;
		current_key = round_key_temp;
		#10
		assert (round_key == 128'hed6018c13a14c050479b083a90efd0aa);
		round_key_temp = round_key;

		//Calculate and check Round 8 Key
		#100;
		RD = 4'h8;
		prev_key = current_key;
		current_key = round_key_temp;
		#10
		assert (round_key == 128'h2eb89da1daba81cc4111cc6ed770ac60);
		round_key_temp = round_key;


		//Calculate and check Round 9 Key
		#100;
		RD = 4'h9;
		prev_key = current_key;
		current_key = round_key_temp;
		#10
		assert (round_key == 128'he3318911d92549419ebe417b0e5191d1);
		round_key_temp = round_key;

		//Calculate and check Round 10 Key
		#100;
		RD = 4'hA;
		prev_key = current_key;
		current_key = round_key_temp;
		#10
		assert (round_key == 128'hef39a30a358322c67492eea8a3e242c8);
		round_key_temp = round_key;


		//Calculate and check Round 11 Key
		#100;
		RD = 4'hB;
		prev_key = current_key;
		current_key = round_key_temp;
		#10
		assert (round_key == 128'he9a9a5f9308cecb8ae32adc3a0633c12);
		round_key_temp = round_key;

		//Calculate and check Round 12 Key
		#100;
		RD = 4'hC;
		prev_key = current_key;
		current_key = round_key_temp;
		#10
		assert (round_key == 128'h34d26aea0151482c75c3a684d621e44c);
		round_key_temp = round_key;


		//Calculate and check Round 13 Key
		#100;
		RD = 4'hD;
		prev_key = current_key;
		current_key = round_key_temp;
		#10
		assert (round_key == 128'h1f54ccd02fd8206881ea8dab2189b1b9);
		round_key_temp = round_key;

		//Calculate and check Round 14 Key
		#100;
		RD = 4'hE;
		prev_key = current_key;
		current_key = round_key_temp;
		#10
		assert (round_key == 128'hd31a3c17d24b743ba788d2bf71a936f3);
		round_key_temp = round_key;

		$display("Generated all round keys correctly for key : 0000000000000000000000000000000000000000000000000000000000000001");

		#100
		$stop;
	  end
		
endmodule
