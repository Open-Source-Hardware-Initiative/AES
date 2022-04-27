module aes_core_pipe(input logic start,
		    input logic clk,
		    input logic reset,
		    input logic enc_dec, //1 for decipher 0 for encipher
		    input logic [1:0] mode,
		    input logic [255:0] key,
		    input logic [127:0] data_in,
		    output logic [127:0] data_out,
		    output logic done);




    aes_enc_pipe enc(.mode(mode),
                 .start(start),
                 .clk(clk),
                 .reset(reset),
                 .round_key(key),
                 .data_in(data_in),
                 .data_out(data_out),
                 .done(done));




endmodule



/*

module aes_rounddata(input logic [3:0] round,
		     input logic [1:0] mode, //00 for 128 01 for 192 and 10 for 256
		     input logic [127:0] round_key,
		     input logic [127:0] data_in,
		     output logic [127:0] data_out);

*/

module aes_enc_pipe(input logic [1:0] mode,
                    input logic start,
                    input logic clk, reset,
                    input logic [255:0] round_key,
                    input logic [127:0] data_in,
                    output logic [127:0] data_out,
                    output logic done);
       
     //Round key array and register
     logic [127:0] round_key_out [14:0];
     logic [255:0] round_key_reg [14:0];
     
     //Round data array
     logic [127:0] round_data_reg [14:0];
     logic [127:0] round_data_out [14:0];
     
     logic [127:0] data_out_d;
     
     //Data valid propagation
     logic valid [14:0];
     
    //Round 0 key/data
    aes_rounddata data0(.round(4'h0),
                        .mode(mode),
                        .round_key(round_key_out[0]),
                        .data_in(round_data_reg[0]),
                        .data_out(round_data_out[0]));
                  
    aes_roundkey_gen key0(.mode(mode),
		                  .key_in(round_key),
		                  .round(4'h0),
		                  .round_key(round_key_out[0]));
		                     
    //Round 1 key/data
    aes_rounddata data1(.round(4'h1),
                        .mode(mode),
                        .round_key(round_key_reg[1][127:0]),
                        .data_in(round_data_reg[1]),
                        .data_out(round_data_out[1]));
                  
    aes_roundkey_gen key1(.mode(mode),
		                  .key_in(round_key),
		                  .round(4'h1),
		                  .round_key(round_key_out[1]));		                    
		                     
    //Round 2 key/data
    aes_rounddata data2(.round(4'h2),
                        .mode(mode),
                        .round_key(round_key_reg[2][127:0]),
                        .data_in(round_data_reg[2]),
                        .data_out(round_data_out[2]));
                  
    aes_roundkey_gen key2(.mode(mode),
		                  .key_in(round_key_reg[1]),
		                  .round(4'h2),
		                  .round_key(round_key_out[2]));
    
    //Round 3 key/data
    aes_rounddata data3(.round(4'h3),
                        .mode(mode),
                        .round_key(round_key_reg[3][127:0]),
                        .data_in(round_data_reg[3]),
                        .data_out(round_data_out[3]));
                  
    aes_roundkey_gen key3(.mode(mode),
		                  .key_in(round_key_reg[2]),
		                  .round(4'h3),
		                  .round_key(round_key_out[3]));     
		                     
    //Round 4 key/data
    aes_rounddata data4(.round(4'h4),
                        .mode(mode),
                        .round_key(round_key_reg[4][127:0]),
                        .data_in(round_data_reg[4]),
                        .data_out(round_data_out[4]));
                  
    aes_roundkey_gen key4(.mode(mode),
		                  .key_in(round_key_reg[3]),
		                  .round(4'h4),
		                  .round_key(round_key_out[4]));
    //Round 5 key/data
    aes_rounddata data5(.round(4'h5),
                        .mode(mode),
                        .round_key(round_key_reg[5][127:0]),
                        .data_in(round_data_reg[5]),
                        .data_out(round_data_out[5]));
                  
    aes_roundkey_gen key5(.mode(mode),
		                  .key_in(round_key_reg[4]),
		                  .round(4'h5),
		                  .round_key(round_key_out[5]));

    //Round 6 key/data
    aes_rounddata data6(.round(4'h6),
                        .mode(mode),
                        .round_key(round_key_reg[6][127:0]),
                        .data_in(round_data_reg[6]),
                        .data_out(round_data_out[6]));
                  
    aes_roundkey_gen key6(.mode(mode),
		                  .key_in(round_key_reg[5]),
		                  .round(4'h6),
		                  .round_key(round_key_out[6]));


    //Round 7 key/data
    aes_rounddata data7(.round(4'h7),
                        .mode(mode),
                        .round_key(round_key_reg[7][127:0]),
                        .data_in(round_data_reg[7]),
                        .data_out(round_data_out[7]));
                  
    aes_roundkey_gen key7(.mode(mode),
		                  .key_in(round_key_reg[6]),
		                  .round(4'h7),
		                  .round_key(round_key_out[7]));
		                  
    //Round 8 key/data
    aes_rounddata data8(.round(4'h8),
                        .mode(mode),
                        .round_key(round_key_reg[8][127:0]),
                        .data_in(round_data_reg[8]),
                        .data_out(round_data_out[8]));
                  
    aes_roundkey_gen key8(.mode(mode),
		                  .key_in(round_key_reg[7]),
		                  .round(4'h8),
		                  .round_key(round_key_out[8]));		                
		                  
    //Round 9 key/data
    aes_rounddata data9(.round(4'h9),
                        .mode(mode),
                        .round_key(round_key_reg[9][127:0]),
                        .data_in(round_data_reg[9]),
                        .data_out(round_data_out[9]));
                  
    aes_roundkey_gen key9(.mode(mode),
		                  .key_in(round_key_reg[8]),
		                  .round(4'h9),
		                  .round_key(round_key_out[9]));



    //Round A key/data
    aes_rounddata dataA(.round(4'hA),
                        .mode(mode),
                        .round_key(round_key_reg[4'hA][127:0]),
                        .data_in(round_data_reg[4'hA]),
                        .data_out(round_data_out[4'hA]));
                  
    aes_roundkey_gen keyA(.mode(mode),
		                  .key_in(round_key_reg[4'h9]),
		                  .round(4'hA),
		                  .round_key(round_key_out[4'hA]));
		                  
		                  
    //Round B key/data
    aes_rounddata dataB(.round(4'hB),
                        .mode(mode),
                        .round_key(round_key_reg[4'hB][127:0]),
                        .data_in(round_data_reg[4'hB]),
                        .data_out(round_data_out[4'hB]));
                  
    aes_roundkey_gen keyB(.mode(mode),
		                  .key_in(round_key_reg[4'hA]),
		                  .round(4'hB),
		                  .round_key(round_key_out[4'hB]));
		                  
		                  
    //Round C key/data
    aes_rounddata dataC(.round(4'hC),
                        .mode(mode),
                        .round_key(round_key_reg[4'hC][127:0]),
                        .data_in(round_data_reg[4'hC]),
                        .data_out(round_data_out[4'hC]));
                  
    aes_roundkey_gen keyC(.mode(mode),
		                  .key_in(round_key_reg[4'hB]),
		                  .round(4'hC),
		                  .round_key(round_key_out[4'hC]));
		                  
		                  
    //Round D key/data
    aes_rounddata dataD(.round(4'hD),
                        .mode(mode),
                        .round_key(round_key_reg[4'hD][127:0]),
                        .data_in(round_data_reg[4'hD]),
                        .data_out(round_data_out[4'hD]));
                  
    aes_roundkey_gen keyD(.mode(mode),
		                  .key_in(round_key_reg[4'hC]),
		                  .round(4'hD),
		                  .round_key(round_key_out[4'hD]));
   
    //Round E key/data
    aes_rounddata dataE(.round(4'hE),
                        .mode(mode),
                        .round_key(round_key_reg[4'hE][127:0]),
                        .data_in(round_data_reg[4'hE]),
                        .data_out(data_out_d));
                  
    aes_roundkey_gen keyE(.mode(mode),
		                  .key_in(round_key_reg[4'hD]),
		                  .round(4'hE),
		                  .round_key(round_key_out[4'hE]));
		                  
		                  
    //Register process
    always @(posedge clk)
      begin
      
      
        if(start)
          begin
            round_data_reg[0] <= data_in;
            round_key_reg[0] <= round_key;
            round_key_reg[1] <= round_key;
            valid[0] <= 1'b1;
          end
        else
          begin
            valid[0] <= 1'b0;
          end
      
        if(valid[0] == 1'b1)
          begin
            round_data_reg[1] <= round_data_out[0];
          end
        
        round_data_reg[2] <= round_data_out[1];
        round_data_reg[3] <= round_data_out[2];
        round_data_reg[4] <= round_data_out[3];
        round_data_reg[5] <= round_data_out[4];
        round_data_reg[6] <= round_data_out[5];
        round_data_reg[7] <= round_data_out[6];
        round_data_reg[8] <= round_data_out[7];
        round_data_reg[9] <= round_data_out[8];
        round_data_reg[10] <= round_data_out[9];
        round_data_reg[11] <= round_data_out[10];
        round_data_reg[12] <= round_data_out[11];
        round_data_reg[13] <= round_data_out[12];
        round_data_reg[14] <= round_data_out[13];
        
        
        if(valid[12] == 1'b1)
          begin
            data_out <= data_out_d;
          end
        
        
        round_key_reg[2] <= {round_key_reg[1][127:0],round_key_out[2]};
        round_key_reg[3] <= {round_key_reg[2][127:0],round_key_out[3]};
        round_key_reg[4] <= {round_key_reg[3][127:0],round_key_out[4]};
        round_key_reg[5] <= {round_key_reg[4][127:0],round_key_out[5]};
        round_key_reg[6] <= {round_key_reg[5][127:0],round_key_out[6]};
        round_key_reg[7] <= {round_key_reg[6][127:0],round_key_out[7]};
        round_key_reg[8] <= {round_key_reg[7][127:0],round_key_out[8]};
        round_key_reg[9] <= {round_key_reg[8][127:0],round_key_out[9]};
        round_key_reg[10] <= {round_key_reg[9][127:0],round_key_out[10]};
        round_key_reg[11] <= {round_key_reg[10][127:0],round_key_out[11]};
        round_key_reg[12] <= {round_key_reg[11][127:0],round_key_out[12]};
        round_key_reg[13] <= {round_key_reg[12][127:0],round_key_out[13]};
        round_key_reg[14] <= {round_key_reg[13][127:0],round_key_out[14]};
        
        
        valid[1] <= valid[0];
        valid[2] <= valid[1];
        valid[3] <= valid[2];
        valid[4] <= valid[3];
        valid[5] <= valid[4];
        valid[6] <= valid[5];
        valid[7] <= valid[6];
        valid[8] <= valid[7];
        valid[9] <= valid[8];
        valid[10] <= valid[9];
        valid[11] <= valid[10];
        valid[12] <= valid[11];
        valid[13] <= valid[12];
        done <= valid[13];
         
        
      end
		                  
		                  
endmodule
