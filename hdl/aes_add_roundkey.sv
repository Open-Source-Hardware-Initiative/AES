/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains addroundkey which is the last step
* 	    in the AES datapath
*/

module aes_addroundkey(input logic [127:0] data,
			input logic [127:0] round_key,
			output logic [127:0] sum);
			
	//The add_roundkey step is essentially just an XOR operation
	assign sum = data ^ round_key;
	
endmodule
