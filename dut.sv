// Copyright (c) 2024 Andrew Parker

module dut #(int DWIDTH=8, int AWIDTH=8)
   (input logic               clk,
    input logic               rst,
    input logic [1:0]         reg_op,
    input logic [AWIDTH-1:0]  reg_addr,
    input logic [DWIDTH-1:0]  reg_wdata,
    output logic [DWIDTH-1:0] reg_rdata);

   logic [DWIDTH-1:0] reg0;
   logic [DWIDTH-1:0] reg1;

   always_ff @(posedge clk) begin
      if (rst) begin
         reg0 <= 0;
         reg1 <= 0;
         reg_rdata <= 0;
      end else begin
         if (reg_op == reg_if.RD) begin
            case (reg_addr)
              8'h00: reg_rdata <= reg0;
              8'h01: reg_rdata <= reg1;
            endcase
         end
         else if (reg_op == reg_if.WR) begin
            case (reg_addr)
              8'h00: reg0 <= reg_wdata;
              8'h01: reg1 <= reg_wdata;
            endcase
         end
      end
   end
endmodule: dut
