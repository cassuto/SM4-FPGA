
module sbox_32b(
   input CLK_i,
   input [31:0] X_i,
   output [31:0] Y_o
);

   sbox_8b SBOX1(
      .CLK_i   (CLK_i),
      .X_i     (X_i[7:0]),
      .Y_o     (Y_o[7:0])
   );
   sbox_8b SBOX2(
      .CLK_i   (CLK_i),
      .X_i     (X_i[15:8]),
      .Y_o     (Y_o[15:8])
   );
   sbox_8b SBOX3(
      .CLK_i   (CLK_i),
      .X_i     (X_i[23:16]),
      .Y_o     (Y_o[23:16])
   );
   sbox_8b SBOX4(
      .CLK_i   (CLK_i),
      .X_i     (X_i[31:24]),
      .Y_o     (Y_o[31:24])
   );

endmodule
