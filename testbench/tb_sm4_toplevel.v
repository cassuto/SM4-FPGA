
`timescale 1ns / 1ps

module tb_sm4_toplevel;

   reg clk = 1'b1;
   reg rst = 1'b1;
   
   always #5 clk = ~clk;
   
   initial
      begin
         #20 rst = 1'b0;
         #10 rst = 1'b1;
      end
   
   wire [127:0] MK;
   wire MK_VALID;
   wire [127:0] plaintext;
   wire plaintext_valid;
   wire [127:0] ciphertext;
   wire ciphertext_valid;
   wire [127:0] DAT_o;
   wire DAT_READY;

   /* test key */
   assign MK = 128'h0123456789ABCDEFFEDCBA9876543210;
   assign MK_VALID = 1'b1;
   
   /* test data */
   assign plaintext = 128'h0123456789ABCDEFFEDCBA9876543210;
   assign plaintext_valid = 1'b1;
   
   sm4_toplevel #(
      .MODE(0), /* Encryptor */
      .ENABLE_FIXED_RK(0)
   )
   ENCRYPTOR(
      .CLK_i      (clk),
      .RST_N_i    (rst),
      .MK_i       (MK),
      .MK_VALID_i (MK_VALID),
      .DAT_i      (plaintext),
      .DAT_VALID_i (plaintext_valid),
      .DAT_o      (ciphertext),
      .DAT_READY_o (ciphertext_valid)
   );
   
   sm4_toplevel #(
      .MODE(1), /* Decryptor */
      .ENABLE_FIXED_RK(0)
   )
   DECRYPTOR(
      .CLK_i      (clk),
      .RST_N_i    (rst),
      .MK_i       (MK),
      .MK_VALID_i (MK_VALID),
      .DAT_i      (ciphertext),
      .DAT_VALID_i (ciphertext_valid),
      .DAT_o      (DAT_o),
      .DAT_READY_o (DAT_READY)
   );
   
   always @(posedge clk)
      if (DAT_READY)
         begin
            if (DAT_o != plaintext)
               $fatal("Error output");
            else
               $display("Succeeded !");
         end
      else
         $display("Testing...");
   
   always @(posedge clk)
      if (ciphertext_valid && ciphertext != 128'h681edf34d206965e86b3e94f536e4246)
         $fatal("Error output of ENCRYPTOR");
   
endmodule
