/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This file contains the testbench for the generalized AES core
*/



module aes_core_gen_tb();

	logic [127:0] plaintext;
	logic [255:0] base_key;
	logic [127:0] ciphertext;
	

	
	
	//Internal logic signals
	logic start;
	logic clk;
	logic reset;
	logic enc_dec;
	logic init_done;
	logic [1:0] mode;
	logic [255:0] key;
	logic [127:0] data_in;
	logic [127:0] data_out;
	
	logic [383:0] vec_mem [100000:0];
	integer i;
	//Number of vectors
	integer vecnum = 100000;
	
	aes_core_gen dut(.start(start),
			 .clk(clk),
			 .reset(reset),
			 .enc_dec(enc_dec),
			 .mode(mode),
			 .key(key),
			 .data_in(data_in),
			 .data_out(data_out),
			 .done(done));
	
	//Generate clk signal	
	initial
	  begin
		clk = 1'b1;
		forever #5 clk = ~clk;
	  end 
	
	
	always @(posedge clk)
	  begin
	  
	  //Stop after vecnum vectors
	  if(i > vecnum)
	    begin
	      $display("Completed all vectors with no errors");
	      $stop;
	    end
	    

	  
	  if(done & init_done)
	    begin
	    

	    
	    
          if(~enc_dec)
            begin //Finish Encipher
            
                //Check for correct enciphered plaintext
                if(data_out != ciphertext)
                  begin
                   $display("Test failed getting ciphertext with vectors :\nPlaintext : %h\nKey :%h\nCiphertext :%h\nExpected Ciphertext : %h",plaintext,key,data_out,ciphertext);
                   $stop;
                  end
            
            
                init_done = 0;
                enc_dec = 1;
                data_in = ciphertext;
		        reset = 1'b1;
	          	#10
	          	//Set AES inputs and hope it workzz
		        start = 1'b1;
		        reset = 1'b0;
		        #10
		        start = 1'b0;                
                init_done = 1'b1;
            end
           else //Finish Decipher
             begin
             
             //Check for correct deciphered ciphertext
              if(data_out != plaintext)
                  begin
                   $display("Test failed getting plaintext with vectors :\nPlaintext : %h\nKey :%h\nCiphertext :%h\nExpected Ciphertext : %h",plaintext,key,data_out,ciphertext);
                   $stop;
                  end
  
          
	          if(i % 100 == 0)
	            begin
	                $display("Completed %d vectors with no errors",i);
	            end          
             
                init_done = 0;
                i = i + 1;
                plaintext = vec_mem[i][127:0];
                ciphertext = vec_mem[i][255:128];
		        base_key = vec_mem[i][383:256];   
		        enc_dec = 0;
		        //Set data in to initial plaintext and start operation
		        data_in = plaintext;
		        key = base_key;
		        reset = 1'b1;
	          	#10
	          	//Set AES inputs and hope it workzz
		        start = 1'b1;
		        reset = 1'b0;
		        enc_dec = 1'b0; //0 for encipher
		        mode = 2'h0;
		        
		        #10
		        start = 1'b0;
		        init_done = 1;

        
             
             end
	  end
	  
	  end
	
	
	//Run testbench
	initial
	  begin
        $readmemh("tv/tv.txt",vec_mem);
        //Set Initial Values
	    plaintext = vec_mem[0][127:0];
        ciphertext = vec_mem[0][255:128];
		base_key = vec_mem[0][383:256];
		enc_dec = 0;
		//Set data in to initial plaintext and start operation
		data_in = plaintext;
		reset = 1'b1;
	  	#100
	  	//Set AES inputs and hope it workzz
		start = 1'b1;
		reset = 1'b0;
		enc_dec = 1'b0; //0 for encipher
		mode = 2'h0;
		key = base_key;
		#20
		start = 1'b0;
		$display("-----------------------------\n   START TEST\n-----------------------------\n");
		init_done = 1'b1;
		i = 1;
		
	  end
	  
endmodule : aes_core_gen_tb
