/*
* Contact : swann.l.ryan@gmail.com
* Purpose : This module contains a memory for the decipher
*           round keys for the AES unit.
*/
module decipher_key_mem(input logic clk, dec_key_gen, enc_dec,
                        input logic [127:0] round_key_in,
                        input logic [3:0] round,
                        output logic [127:0] key_out);
                        
    logic [127:0] key_mem [13:0];             
              
    always @(posedge clk)
      begin
      
        //If write enable then save the key to current round location
        if(dec_key_gen)
          begin
            key_mem[round] <= round_key_in;
          end
        if(enc_dec)
          begin
            key_out <= key_mem[round];
          end
      end
                        
endmodule
