// Copyright (c) 2024 Andrew Parker

interface reg_if #(int DWIDTH=8, int AWIDTH=8) (input logic clk, input logic rst);
   logic [1:0] op;
   logic [AWIDTH-1:0] addr;
   logic [DWIDTH-1:0] wdata;
   logic [DWIDTH-1:0] rdata;

   modport req (output op, output addr, output wdata, input rdata);
   modport rsp (input op, input addr, input wdata, output rdata);
endinterface: reg_if
