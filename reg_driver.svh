// Copyright (c) 2024 Andrew Parker

class reg_driver #(AWIDTH=8, DWIDTH=8) extends uvm_driver #(reg_item #(AWIDTH, DWIDTH));

   // Types
   typedef reg_driver #(AWIDTH, DWIDTH) this_t;
   typedef reg_item #(AWIDTH, DWIDTH) item_t;
   typedef virtual reg_if #(AWIDTH, DWIDTH).req vif_t;

   // Config
   vif_t vif;

   // UVM component utils
   `uvm_component_param_utils(this_t)

   // Function: new
   //
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   // Function: connect_phase
   //
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      // Get virtual interface handle from config DB
      assert(uvm_config_db #(vif_t)::get(this, "", "vif", vif))
        else `uvm_fatal("CFGERR", "vif not configured")
   endfunction: connect_phase

   // Task: run_phase
   //
   task run_phase(uvm_phase phase);
      item_t item;

      // Drive reset
      wait (vif.rst == 1);
      drive_reset();
      wait (vif.rat == 0);

      // Sync to clock
      @(posedge vif.clk);

      // Drive transaction items
      forever begin
         seq_item_port.get_next_item(item);
         drive_item(item);
         `uvm_info("DRV", item.sprint(), UVM_HIGH)
         seq_item_port.item_done();
      end
   endtask: run_phase

   // Task: drive_reset
   virtual protected task drive_reset();
      vif.op <= reg_if.NOP;
   endtask

   // Task: drive_item
   //
   virtual protected task drive_item(item_t item);
      // Insert delay
      repeat (item.delay) @(posedge vif.clk);

      // Drive item
      if (item.op == item_t::READ) begin
         vif.op <= reg_if.RD;
      end
      else begin
         vif.op <= reg_if.WR;
      end
      vif.addr <= item.addr;

      // Wait for item to be sampled by DUT
      @(posedge vif.clk);
      vif.op <= reg_if.NOP;

      // Collect read data
      if (item.op == item_t::READ) begin
         // TODO: Support back-to-back overlapping reads without bubbles
         @(posedge vif.clk);
         item.data = vif.rdata;
      end
   endtask: drive_item

endclass: reg_driver
