/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains the test for the rotate word operation for
*           the unit using test vectors in the tv directory
*/

module rotTest();


    //PUT NUMBER OF TEST VECTORS HERE
    int tvnum = 1000;

	logic [31:0] word;
	logic [31:0] rotWord;
	logic disableRot;
	
	
	//Testbench signals
	logic clk;
	logic [64:0] tv_mem [1000:0];
	logic [31:0] correctOut;
    int i;

	aesRotateWord dut(.disableRotate(disableRot),
					  .inWord(word),
					  .rotWord(rotWord));

    //Set Clock
	always
	  begin
	    clk = 1; #5; clk = 0; #5;
	  end

    //Initialize Testbench
	initial
	  begin
		$readmemb("tv/tv.txt",tv_mem);
		i = 1;
		word = tv_mem[0][31:0];
		correctOut = tv_mem[0][63:32];
		disableRot = tv_mem[0][64];
	  end



    always @(posedge clk)
      begin
      
      //Finished all Vectors
      if(i >= tvnum)
        begin
            $display("Finished Test with no errors!");
            $stop;
        end      
      
      
      
      //Vector Success
      if(correctOut == rotWord)
        begin
            word = tv_mem[i][31:0];
		    correctOut = tv_mem[i][63:32];
		    disableRot = tv_mem[i][64]; 
		    i = i + 1;
	    end
	  //Vector Failure  
	  else
	    begin
	      $display("Test Failed on vector\nInput       : %h\nExpected Output : %h\nDUT Output   : %h\n",word,correctOut,rotWord);
	      $stop;
	    end
	    
    end



endmodule
