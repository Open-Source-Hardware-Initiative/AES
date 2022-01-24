/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains aes_shiftrow. The first module
	    takes in the first data line and outputs the 
*/
module aes_inv_shiftrow(input logic [127:0] dataIn,
		    output logic [127:0] dataOut);
		    
		    
		    
	//(This form of writing it may seem like more effort but I feel
	// like it is more self-explanatory this way without losing efficiency)
		    
	//Seperate the first (Least Significant) word into bytes
	wire [7:0] w0_b0 = dataIn[7:0];
	wire [7:0] w0_b1 = dataIn[15:8];
	wire [7:0] w0_b2 = dataIn[23:16];
	wire [7:0] w0_b3 = dataIn[31:24];
	//Seperate the second word into bytes
	wire [7:0] w1_b0 = dataIn[39:32];
	wire [7:0] w1_b1 = dataIn[47:40];
	wire [7:0] w1_b2 = dataIn[55:48];
	wire [7:0] w1_b3 = dataIn[63:56];
	//Seperate the third word into bytes
	wire [7:0] w2_b0 = dataIn[71:64];
	wire [7:0] w2_b1 = dataIn[79:72];
	wire [7:0] w2_b2 = dataIn[87:80];
	wire [7:0] w2_b3 = dataIn[95:88];
	//Seperate the fourth (Most significant) word into bytes
	wire [7:0] w3_b0 = dataIn[103:96];
	wire [7:0] w3_b1 = dataIn[111:104];
	wire [7:0] w3_b2 = dataIn[119:112];
	wire [7:0] w3_b3 = dataIn[127:120];
	
	//The output words are composed of sets of the input bytes.
	wire [31:0] out_w0 = {w3_b3, w0_b2, w1_b1, w2_b0};
	wire [31:0] out_w1 = {w2_b3, w3_b2, w0_b1, w1_b0};
	wire [31:0] out_w2 = {w1_b3, w2_b2, w3_b1, w0_b0};
	wire [31:0] out_w3 = {w0_b3, w1_b2, w2_b1, w3_b0};
	
	assign dataOut = {out_w0, out_w1, out_w2, out_w3};
	
endmodule


	
/*
* Purpose : This next module provides an alternative way to shift the values.
	    in which it takes the shift number (essentially row number) as 
	    an input and shifts cyclically to the left by that number of bits.
	    the complexity here is removed from the module and is more complex in
	    input selection (eww more thinking bad return to monkeh)
*/


module aes_shiftword(input logic[1:0] shiftAmt,
		     input logic [31:0] dataIn,
		     output logic [31:0] dataOut);
		     

	logic [7:0] b0 = dataIn[7:0];
	logic [7:0] b1 = dataIn[15:8];
	logic [7:0] b2 = dataIn[23:16];
	logic [7:0] b3 = dataIn[31:24];
	
	always_comb
	  begin
		case(shiftAmt)
			
			//00 : Barrel Shift no bytes
			2'b00 : dataOut = {b3, b2, b1, b0};
			//01 : Barrel Shift one byte
			2'b01 : dataOut = {b0, b3, b2, b1};
			//10 : Barrel Shift two bytes
			2'b10 : dataOut = {b1, b0, b3, b2};
			//11 : Barrel Shift three bytes
			default : dataOut = {b2, b1, b0, b3};
		endcase
	  end
endmodule			
