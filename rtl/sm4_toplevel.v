
module sm4_toplevel #(
   parameter MODE = 0, /* 0: Encryptor, 1(>0): Decryptor */
   parameter ENABLE_FIXED_RK = 0,
   parameter [1023:0] FIXED_RK = 1024'h0
)
(
   input CLK_i,
   input RST_N_i,
   input [127:0] MK_i,
   input MK_VALID_i,
   input [127:0] DAT_i,
   input DAT_VALID_i,
   output [127:0] DAT_o,
   output DAT_READY_o
);

wire RK_ready;
wire [1023:0] RK_pre, RK;
genvar i;

/* key expand algorithm module */
generate
   if (ENABLE_FIXED_RK == 0)
      begin
         keyexp KEYEXP(
            .CLK_i      (CLK_i),
            .RST_N_i    (RST_N_i),
            .MK_i       (MK_i),
            .MK_VALID_i (MK_VALID_i),
            .RK_o       (RK_pre),
            .RK_READY_o (RK_ready)
         );
      end
   else
      begin
         assign RK_pre = FIXED_RK;
         assign RK_ready = 1'b1;
      end
endgenerate

generate
   if (MODE == 0)
      assign RK = RK_pre;
   else
      begin
         /* Decryptor: reserve order */
         for(i=0;i<32;i=i+1)
            assign RK[32*(i+1)-1:32*i] = RK_pre[32*(32-i)-1:32*(31-i)];
      end
endgenerate

/* main pipeline */
decenc DECENC(
   .CLK_i       (CLK_i),
   .RST_N_i     (RST_N_i),
   .RK_i        (RK),
   .DAT_i       (DAT_i),
   .DAT_VALID_i (RK_ready & DAT_VALID_i),
   .DAT_o       (DAT_o),
   .DAT_READY_o (DAT_READY_o)
);

endmodule
