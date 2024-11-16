// Copyright (c) 2024 Andrew Parker

`default_nettype none

module dut #(DWIDTH=8)
   (input logic               clk,
    input logic               rst,
    input logic [DWIDTH-1:0]  din,
    output logic [DWIDTH-1:0] dout);

   always_ff @(posedge clk) begin
      if (rst) begin
         dout <= 0;
      end else begin
         dout <= din;
      end
   end
endmodule: dut
