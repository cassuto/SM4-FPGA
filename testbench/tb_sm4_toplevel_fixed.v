
`timescale 1ns / 1ps

module tb_sm4_toplevel_fixed;

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

   /* test data */
   assign plaintext = 128'h0123456789ABCDEFFEDCBA9876543210;
   assign plaintext_valid = 1'b1;
   
   sm4_toplevel #(
      .MODE(0), /* Encryptor */
      .ENABLE_FIXED_RK(1),
      .FIXED_RK(1024'hf12186f941662b615a6ab19a7ba92077367360f4776a0c61b6bb89b324763151a520307cb7584dbdc30753ed7ee55b576988608c30d895b744ba14af104495a1d120b42873b55fa3cc87496692244439e89e641f98ca015ac715906099e1fd2eb79bd80c1d2115b00e228aebf1780c81428d36546229349601cf72e59124a012)
   )
   ENCRYPTOR(
      .CLK_i      (clk),
      .RST_N_i    (rst),
      .MK_i       (),
      .MK_VALID_i (),
      .DAT_i      (plaintext),
      .DAT_VALID_i (plaintext_valid),
      .DAT_o      (ciphertext),
      .DAT_READY_o (ciphertext_valid)
   );
   
   sm4_toplevel #(
      .MODE(1), /* Decryptor */
      .ENABLE_FIXED_RK(1),
      .FIXED_RK(1024'hf12186f941662b615a6ab19a7ba92077367360f4776a0c61b6bb89b324763151a520307cb7584dbdc30753ed7ee55b576988608c30d895b744ba14af104495a1d120b42873b55fa3cc87496692244439e89e641f98ca015ac715906099e1fd2eb79bd80c1d2115b00e228aebf1780c81428d36546229349601cf72e59124a012)
   )
   DECRYPTOR(
      .CLK_i      (clk),
      .RST_N_i    (rst),
      .MK_i       (),
      .MK_VALID_i (),
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
   
endmodule
