`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/01/29 21:37:18
// Design Name: 
// Module Name: toplevel
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module toplevel(
   input clk_50M,
   input rst_btn_n
);
   
   wire clk; 
   reg rst_n;
   wire [127:0] MK;
   wire MK_VALID;
   wire [127:0] plaintext;
   wire plaintext_valid;
   wire [127:0] ciphertext;
   wire ciphertext_valid;
   wire [127:0] DAT_o;
   wire DAT_READY;

   wire locked;

   clk_main PLL(
      // Clock in ports
      .clk_in1(clk_50M),
      // Clock out ports
      .clk_out1(clk),
      // Status and control signals
      .resetn(rst_btn_n),
      .locked(locked)
   );
   
   always@(posedge clk or negedge locked) begin
      if(~locked) rst_n <= 1'b0;
      else        rst_n <= 1'b1;
   end
    
   /* test data */
   assign plaintext = 128'h0123456789ABCDEFFEDCBA9876543210;
   assign plaintext_valid = 1'b1;
   
   ila_0 ILA0(
      .clk(clk),
      .probe0(ciphertext),
      .probe1(ciphertext_valid),
      .probe2(DAT_o),
      .probe3(DAT_READY),
      .probe4(rst_btn_n)
   );
   
   sm4_toplevel #(
      .MODE(0), /* Encryptor */
      .ENABLE_FIXED_RK(1),
      .FIXED_RK(1024'hf12186f941662b615a6ab19a7ba92077367360f4776a0c61b6bb89b324763151a520307cb7584dbdc30753ed7ee55b576988608c30d895b744ba14af104495a1d120b42873b55fa3cc87496692244439e89e641f98ca015ac715906099e1fd2eb79bd80c1d2115b00e228aebf1780c81428d36546229349601cf72e59124a012)
   )
   ENCRYPTOR(
      .CLK_i      (clk),
      .RST_N_i    (rst_n),
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
      .RST_N_i    (rst_n),
      .MK_i       (),
      .MK_VALID_i (),
      .DAT_i      (ciphertext),
      .DAT_VALID_i (ciphertext_valid),
      .DAT_o      (DAT_o),
      .DAT_READY_o (DAT_READY)
   );
   
   

endmodule
