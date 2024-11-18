// Copyright (c) 2024 Andrew Parker

interface reg_if #(int DWIDTH=8, int AWIDTH=8) (input logic clk, input logic rst);

   typedef enum logic [1:0] {
     NOP = 2'b00,
     RD  = 2'b01,
     WR  = 2'b10
   } op_t;

   op_t               op;
   logic [AWIDTH-1:0] addr;
   logic [DWIDTH-1:0] wdata;
   logic [DWIDTH-1:0] rdata;

   modport req (output op, output addr, output wdata, input rdata);
   modport rsp (input op, input addr, input wdata, output rdata);
   modport mon (input op, input addr, input wdata, input rdata);

endinterface: reg_if
