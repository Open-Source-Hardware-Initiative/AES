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
	logic [127:0] vec_key;
	
	logic [127:0] round_key_temp;
	logic [131:0] kmem [15001:0];
	
	integer i;
	integer j;
	integer k;
	integer errorCnt;
	
	
	
	//assign start_key = 256'h1;
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
	assign mode = 2'b10;

	aes_roundkey dut(.RD(RD),
		     .mode(mode),
		     .prev_key(prev_key),
		     .current_key(current_key),
		     .round_key(round_key));
		
	initial
	  begin
	  	$readmemh("roundkey_tv.txt",kmem);
		errorCnt = 0;
	  	for (i=0; i<1000; i = i+1) begin
	  		$display("Starting round key generation with key: %h%h" , kmem[15*i], kmem[15*i+1]);
	  		for( j=0; j<14; j++) begin
	  			k = (15*i) + j;
	  			
	  			RD = kmem[k][131:128] + 1;
	  			prev_key = current_key;
	  			current_key = kmem[k][127:0];
	  			//$display("%h", kmem[k+1][127:0]);
	  			//$display("%h", round_key);
	  			#10;
	  			if(RD != 4'h0 & RD != 4'h1)
	  				assert (round_key == kmem[k+1][127:0]) else errorCnt = errorCnt + 1;
	  		end
	  		
	  	end
		$display("Completed round key generation testing with %d errors\n\n\n\n\n",errorCnt);
		#100
		$stop;
	  end
		
endmodule
