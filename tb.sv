// Copyright (c) 2024 Andrew Parker

module tb;

   logic clk;
   logic rst;

   // Interfaces
   reg_if reg_if0(clk, rst);

   // DUT
   dut dut0
     (.clk(clk),
      .rst(rst),
      .reg_op(reg_if0.op),
      .reg_addr(reg_if0.addr),
      .reg_wdata(reg_if0.wdata),
      .reg_rdata(reg_if0.rdata));

   // Clock driver
   initial begin
      repeat (10) begin
         clk = 0;
         #10;
         clk = 1;
         #10;
      end
   end

   // Reset driver
   initial begin
      rst = 0;
      #5;
      rst = 1;
      #20;
      rst = 0;
   end
endmodule: tb
