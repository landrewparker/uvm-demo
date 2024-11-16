// Copyright (c) 2024 Andrew Parker

`timescale  1 ns / 1 ps

parameter int DWIDTH=8;

module tb;

   logic clk;
   logic rst;
   logic [DWIDTH-1:0] din;
   logic [DWIDTH-1:0] dout;

   dut#(.DWIDTH(DWIDTH)) dut0(.clk(clk), .rst(rst), .din(din), .dout(dout));

   initial begin
      repeat (10) begin
         clk = 0;
         #10;
         clk = 1;
         #10;
      end
   end

   initial begin
      rst = 0;
      #5;
      rst = 1;
      #20;
      rst = 0;
   end

   initial begin
      din <= 0;
   end

endmodule // tb
