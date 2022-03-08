/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This module contains a memory for the decipher
*           round keys for the AES unit.
*/
module decipher_key_mem(input logic clk, dec_key_gen, enc_dec,
                        input logic [127:0] round_key_in,
                        input logic [3:0] writeRound, readRound,
                        input logic [3:0] roundAmount,
                        output logic [127:0] key_out);
                        
    logic [127:0] key_mem [14:0];             

    //Bounce key back to begin decrypt on 0th round, read registered for other rounds
    assign r0_flag = ~(|(readRound));
    assign key_out = r0_flag ? round_key_in : key_mem[roundAmount - readRound];
              
    always @(posedge clk)
      begin
      
        //If write enable then save the key to current round location
        if(dec_key_gen)
          begin
            key_mem[writeRound] <= round_key_in;
          end
      end
                        
endmodule
