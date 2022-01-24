/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains the AES single word rotate operation. Basically
* a one byte logicl shift
*/

module aesRotateWord
		(input logic disableRotate,
		 input logic [31:0] inWord,
		 output logic [31:0] rotWord);

	 //Logic to store the rotated word
	 logic [31:0] rotatedWord;

	 //Barrel shift the rows one byte to the left
	 assign rotatedWord[7:0] = inWord[31:24];
	 assign rotatedWord[15:8] = inWord[7:0];
	 assign rotatedWord[23:16] = inWord[15:8];
	 assign rotatedWord[31:24] = inWord[23:16];

	//Ternary for selection of the disabled or nondisabled output
	//If disable is '1' then the output will not rotate and take the input.
	//If disable is '0' then the output will take a barrel shifted input.
	 assign rotWord = disableRotate ? inWord : rotatedWord;
endmodule
