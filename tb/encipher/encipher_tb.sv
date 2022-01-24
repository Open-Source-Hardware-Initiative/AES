/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains the AES single word rotate operation. Basically
* a one byte logicl shift
* Yoinked vector from : https://kavaliro.com/wp-content/uploads/2014/03/AES.pdf
* This is, of course. Only a 128 bit example. But the same principles apply for the
* datapath mostly except for the last and first round selection logic.
*/

module encipher_tb();
	//Start key
	logic [255:0] start_key;

	//roundkey inputs
	logic [3:0] RD;
	logic [1:0] mode;
	logic [127:0] data_in;
	logic [127:0] data_out;
	logic [127:0] prev_key;
	logic [127:0] current_key;
	logic [127:0] round_key;
	logic [127:0] r0_state;
	logic [127:0] cur_state;
	
	//Initialize the (in the scope of this tb) constants.
	logic [127:0] base_key = 128'h5468617473206D79204B756E67204675;
	logic [127:0] plaintext = 128'h54776F204F6E65204E696E652054776F;
	logic [127:0] correctCipher = 128'h5847088B15B61CBA59D4E2E8CD39DFCE;



	//Round keys (From python script to isolate this from key schedule bugs)
	/*
	 0: 5468617473206d79204b756e67204675
	 1: e232fcf191129188b159e4e6d679a293
	 2: 56082007c71ab18f76435569a03af7fa
	 3: d2600de7157abc686339e901c3031efb
	 4: a11202c9b468bea1d75157a01452495b
	 5: b1293b3305418592d210d232c6429b69
	 6: bd3dc287b87c47156a6c9527ac2e0e4e
	 7: cc96ed1674eaaa031e863f24b2a8316a
	 8: 8e51ef21fabb4522e43d7a0656954b6c
	 9: bfe2bf904559fab2a16480b4f7f1cbd8
	10: 28fddef86da4244accc0a4fe3b316f26
	*/

	assign r0_state = base_key ^ plaintext;
	assign mode = 2'h0;

/*
module aes_encipher(input logic [3:0] round,
		     input logic [1:0] mode, //00 for 128 01 for 192 and 10 for 256
		     input logic [127:0] prev_key,
		     input logic [127:0] current_key,
		     input logic [127:0] data_in,
		     output logic [127:0] data_out
		     output logic [127:0] round_key);
*/

	//For rounds after zero
	aes_encipher dut(.round(RD),
		     .mode(mode),
		     .prev_key(prev_key),
		     .current_key(current_key),
		     .data_in(data_in),
		     .data_out(data_out),
		     .round_key(round_key));
		     
	initial
	  begin
	  	//Round 0 is basically just an XOR so it can be done combinationally and checked here
	  	current_key = base_key;
	  	assert (r0_state == 128'h001F0E543C4E08596E221B0B4774311A);
	  	
	  	//Set round 1 round_key (above) and RD number and check output.
	  	prev_key = base_key;
	  	RD = 4'h1;
		data_in = r0_state;
		#10
		assert (data_out == 128'h5847088B15B61CBA59D4E2E8CD39DFCE);
		cur_state = data_out;
		//These are the same for AES128. Since it doesn't use even/odd nomenclature.
		prev_key = round_key;
		current_key = round_key;
		#100
		
		//Round 2
		data_in = cur_state;
		RD = 4'h2;
		#10
		assert (data_out == 128'h43C6A9620E57C0C80908EBFE3DF87F37);
		//These are the same for AES128. Since it doesn't use even/odd nomenclature.
		prev_key = round_key;
		current_key = round_key;
		cur_state = data_out;
		#100
		
		//Round 3
		data_in = cur_state;
		RD = 4'h3;
		#10
		assert (data_out == 128'h7876305470767d23993c375b4b3934f1);
		//These are the same for AES128. Since it doesn't use even/odd nomenclature.
		prev_key = round_key;
		current_key = round_key;
		cur_state = data_out;
		#100
		
				
		//Round 4
		data_in = cur_state;
		RD = 4'h4;
		#10
		assert (data_out == 128'hB1CA51ED08FC54E104B1C9D3E7B26C20);
		//These are the same for AES128. Since it doesn't use even/odd nomenclature.
		prev_key = round_key;
		current_key = round_key;
		cur_state = data_out;
		#100
		
		//THEY RALLY ROUND THA FAMILY! WITH A POCKET FULL OF SHELLS
		
		//Round 5
		data_in = cur_state;
		RD = 4'h5;
		#10
		assert (data_out == 128'h9B512068235F22F05D1CBD322F389156);
		//These are the same for AES128. Since it doesn't use even/odd nomenclature.
		prev_key = round_key;
		current_key = round_key;
		cur_state = data_out;
		#100

		/*
		TO ESCAPE FROM THE PAIN AND AN EXISTENCE MUNDANE
		I GOTTA NINE, A SIGN, A SET AND NOW I GOT A NAME
		*/
		
		
		
		//Round 6
		data_in = cur_state;
		RD = 4'h6;
		#10
		assert (data_out == 128'h149325778FA42BE8C06024405E0F9275);
		//These are the same for AES128. Since it doesn't use even/odd nomenclature.
		prev_key = round_key;
		current_key = round_key;
		cur_state = data_out;
		#100
	
	
		//Round 7
		data_in = cur_state;
		RD = 4'h7;
		#10
		assert (data_out == 128'h53398E5D430693F84F0A3B95855257BD);
		//These are the same for AES128. Since it doesn't use even/odd nomenclature.
		prev_key = round_key;
		current_key = round_key;
		cur_state = data_out;
		#100
	
		//Round 8
		data_in = cur_state;
		RD = 4'h8;
		#10
		assert (data_out == 128'h66253C7470CE5AA8AFD30F0AA3731354);
		//These are the same for AES128. Since it doesn't use even/odd nomenclature.
		prev_key = round_key;
		current_key = round_key;
		cur_state = data_out;
		#100
	
		//Round 9
		data_in = cur_state;
		RD = 4'h9;
		#10
		assert (data_out == 128'h09668B78A2D19A65F0FCE6C47B3B3089);
		//These are the same for AES128. Since it doesn't use even/odd nomenclature.
		prev_key = round_key;
		current_key = round_key;
		cur_state = data_out;
		#100
	
	
		//Round A
		data_in = cur_state;
		RD = 4'hA;
		#10
		assert (data_out == 128'h29C3505F571420F6402299B31A02D73A);
		//These are the same for AES128. Since it doesn't use even/odd nomenclature.
		prev_key = round_key;
		current_key = round_key;
		cur_state = data_out;
		#100
	
	
	    $display("Test Done! Check for assertion errors");
	
		$stop;
	  end
		
endmodule
