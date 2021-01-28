
`timescale 1ns / 1ps

module tb_keyexp;

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
   wire [1023:0] RK;
   wire RK_READY;
   
   /* test key */
   assign MK = 128'h0123456789ABCDEFFEDCBA9876543210;
   assign MK_VALID = 1'b1;
   
   keyexp KEYEXP(
      .CLK_i      (clk),
      .RST_N_i    (rst),
      .MK_i       (MK),
      .MK_VALID_i (MK_VALID),
      .RK_o       (RK),
      .RK_READY_o (RK_READY)
   );
   
   always @(posedge clk)
      if (RK_READY)
         begin
            if (RK != 1024'hf12186f941662b615a6ab19a7ba92077367360f4776a0c61b6bb89b324763151a520307cb7584dbdc30753ed7ee55b576988608c30d895b744ba14af104495a1d120b42873b55fa3cc87496692244439e89e641f98ca015ac715906099e1fd2eb79bd80c1d2115b00e228aebf1780c81428d36546229349601cf72e59124a012)
               $fatal("Error output of RK");
            else
               $display("Succeeded !");
         end
      else
         $display("Testing...");
   
endmodule
