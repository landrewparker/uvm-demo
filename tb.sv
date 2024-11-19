// Copyright (c) 2024 Andrew Parker

module tb;

   import uvm_pkg::*;

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
      forever begin
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

   // Configure and run test
   initial begin
      // Put virtual interface handles in config DB
      uvm_config_db #(virtual reg_if #(8,8).req)::set(uvm_root::get(), "*.reg_agent0.driver", "vif", reg_if0);
      uvm_config_db #(virtual reg_if #(8,8).mon)::set(uvm_root::get(), "*.reg_agent0.monitor", "vif", reg_if0);
      // Run UVM test
      run_test();
   end

endmodule: tb
