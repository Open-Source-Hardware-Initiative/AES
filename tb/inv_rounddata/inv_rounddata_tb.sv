/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file calculate the inverse round data calculation.
* Yoinked vector from SECWORKS AES testbench
* Unfortunately you use the same Round keys but in opposite order for decryption
* this means that you will be forced to calculate all of the round keys before beginning decryption.
* More info : https://crypto.stackexchange.com/questions/5603/on-the-fly-computation-of-aes-round-keys-for-decryption
* Will have to read more about the ROM table method mentioned in that post.
* https://crypto.stackexchange.com/questions/5603/on-the-fly-computation-of-aes-round-keys-for-decryption
*/

module rdkey_tb();
	//Start key
	logic [255:0] start_key;

	//roundkey inputs
	logic [3:0] RD;
	logic [1:0] mode;
	logic [127:0] data_in;
	logic [127:0] data_out; //Not technically an accurate name but ¯\_(ツ)_/¯
	logic [127:0] round_key;
	logic [127:0] r0_state;
	logic [127:0] cur_state;
	
	//Initialize the (in the scope of this tb) constants.
	logic [127:0] base_key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
	logic [127:0] plaintext = 128'h6bc1bee22e409f96e93d7e117393172a;
	logic [127:0] ciphertext = 128'h3ad77bb40d7a3660a89ecaf32466ef97;
	
	logic [127:0] roundkey_arr [10:0];

	/*
	# key[00] = 0x2b7e151628aed2a6abf7158809cf4f3c
	# key[01] = 0xa0fafe1788542cb123a339392a6c7605
	# key[02] = 0xf2c295f27a96b9435935807a7359f67f
	# key[03] = 0x3d80477d4716fe3e1e237e446d7a883b
	# key[04] = 0xef44a541a8525b7fb671253bdb0bad00
	# key[05] = 0xd4d1c6f87c839d87caf2b8bc11f915bc
	# key[06] = 0x6d88a37a110b3efddbf98641ca0093fd
	# key[07] = 0x4e54f70e5f5fc9f384a64fb24ea6dc4f
	# key[08] = 0xead27321b58dbad2312bf5607f8d292f
	# key[09] = 0xac7766f319fadc2128d12941575c006e
	# key[10] = 0xd014f9a8c9ee2589e13f0cc8b6630ca6
	*/

	assign r0_state = base_key ^ plaintext;
	assign mode = 2'b00;


	//Eye checking this module shows that it generates the appropriate keys.
	aes_roundkey_128 rk_128(.mode(mode),
		       		.key_in(base_key),
		       		.round_key(roundkey_arr));

	//For rounds after zero
	aes_inv_rounddata dut(.round(RD),
		   	      .mode(mode),
		              .round_key(round_key),
		              .data_in(data_in),
		              .data_out(data_out));
		     
	initial
	  begin
	  
	  
	  	//Stole this test from the secworks core :)
	  	
	  	
	  	//Round 0 (AES128)
	  	RD = 4'h0;
	  	round_key = 128'hd014f9a8c9ee2589e13f0cc8b6630ca6;
	  	data_in = ciphertext;
	  	#1000
	  	assert(data_out == 128'hbb36c7eb88334d49a4e7112e74f182c4)
	  	cur_state = data_out;
	  	#10
	  	
	  	//Round 1
	  	RD = 4'h1;
	  	data_in = cur_state;
	  	round_key = 128'hac7766f319fadc2128d12941575c006e;
	  	#1000
	  	assert(data_out == 128'h41d7c6537d669140dd2f179d02acc51b)
	  	cur_state = data_out;
	  	
	  	//Round 2
	  	RD = 4'h2;
	  	data_in = cur_state;
	  	round_key = 128'head27321b58dbad2312bf5607f8d292f;
	  	#1000
	  	assert(data_out == 128'he26dbb7d40d22134e3b7fda26b9b077c)
	  	cur_state = data_out;
	  	
	  	//Round 3
	  	RD = 4'h3;
	  	data_in = cur_state;
	  	round_key = 128'h4e54f70e5f5fc9f384a64fb24ea6dc4f;
	  	#1000
	  	assert(data_out == 128'hcd4dc0137eb3ba1993b939ff2bd3bcf7)
	  	cur_state = data_out;
	  	
	  	//Round 4
	  	RD = 4'h4;
	  	data_in = cur_state;
	  	round_key = 128'h6d88a37a110b3efddbf98641ca0093fd;
	  	#1000
	  	assert(data_out == 128'h2c4af31432c3efc9c8a9b87b252ecda7)
	  	cur_state = data_out;
	  	
	  	//Round 5
	  	RD = 4'h5;
	  	data_in = cur_state;
	  	round_key = 128'hd4d1c6f87c839d87caf2b8bc11f915bc;
	  	#1000
	  	assert(data_out == 128'ha2616e5f44a54d39c029e20092b764e9)
	  	cur_state = data_out;
	  	
	  	//Round 6
	  	RD = 4'h6;
	  	data_in = cur_state;
	  	round_key = 128'hef44a541a8525b7fb671253bdb0bad00;
	  	#1000
	  	assert(data_out == 128'hacd1ec9ca242e2c31f690f7ab704b90f)
	  	cur_state = data_out;
	  	
	  	//Round 7
	  	RD = 4'h7;
	  	data_in = cur_state;
	  	round_key = 128'h3d80477d4716fe3e1e237e446d7a883b;
	  	#1000
	  	assert(data_out == 128'hfdf37cdb4b0c8c1bf7fcd8e94aa9bbf8)
	  	cur_state = data_out;
	  	
	  	//Round 8
	  	RD = 4'h8;
	  	data_in = cur_state;
	  	round_key = 128'hf2c295f27a96b9435935807a7359f67f;
	  	#1000
	  	assert(data_out == 128'hf265e8d51fd2397bc3b9976d9076505c)
	  	cur_state = data_out;
	  	
	  	//Round 9
	  	RD = 4'h9;
	  	data_in = cur_state;
	  	round_key = 128'ha0fafe1788542cb123a339392a6c7605;
	  	#1000
	  	assert(data_out == 128'h40bfabf406ee4d3042ca6b997a5c5816)
	  	cur_state = data_out;
	  	
	  	//Round A
	  	RD = 4'hA;
	  	data_in = cur_state;
	  	round_key = 128'h2b7e151628aed2a6abf7158809cf4f3c;
	  	#1000
	  	assert(data_out == 128'h6bc1bee22e409f96e93d7e117393172a)
	  	cur_state = data_out;
	  	
	  	$display("Test Finished, check for assertion failures above");
	  		
	  	$stop;
	  end
		
endmodule
