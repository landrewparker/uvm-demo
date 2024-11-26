// Copyright (c) 2024 Andrew Parker

class reg_bus_monitor #(AWIDTH=8, DWIDTH=8) extends uvm_monitor;

   // Types
   typedef reg_bus_monitor #(AWIDTH, DWIDTH) this_t;
   typedef reg_bus_item #(AWIDTH, DWIDTH) item_t;
   typedef virtual reg_bus_if #(AWIDTH, DWIDTH).mon vif_t;

   // Config
   bit check_en = 1;
   bit cover_en = 1;
   vif_t vif;

   // UVM component utils
   `uvm_component_param_utils_begin(this_t)
      `uvm_field_int(check_en, UVM_DEFAULT)
      `uvm_field_int(cover_en, UVM_DEFAULT)
   `uvm_component_utils_end

   // Analysis port
   uvm_analysis_port #(item_t) ap;

   // Recovered transaction
   protected item_t item;

   // Covergroup: item_cg
   covergroup item_cg;
      option.per_instance = 1;
      op_cp: coverpoint item.op;
      addr_cp: coverpoint item.addr;
      data_cp: coverpoint item.data;
      all_cr: cross op_cp, addr_cp, data_cp;
   endgroup: item_cg

   // Function: new
   //
   function new(string name, uvm_component parent);
      super.new(name, parent);
      item_cg = new();
   endfunction: new

   // Function: build_phase
   //
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      item = new();
      ap = new("ap", this);
   endfunction: build_phase

   // Function: connect_phase
   //
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);
      // Get virtual interface handle
      assert(uvm_config_db #(vif_t)::get(this, "", "vif", vif))
        else `uvm_fatal("CFGERR", "vif not configured")
   endfunction: connect_phase

   // Task: run_phase
   task run_phase(uvm_phase phase);
      // Wait for reset
      wait (vif.rst == 1);
      wait (vif.rst == 0);

      // Collect transactions
      forever begin
         item_t item_clone;
         collect_item();
         if (check_en)
           do_check();
         if (cover_en)
           do_cover();
         `uvm_info("MON", item.sprint(uvm_line_printer::get_default()), UVM_MEDIUM)

         // Copy-on-write policy
         assert($cast(item_clone, item.clone())) else
           `uvm_fatal("CSTERR", "cast failed");
         ap.write(item_clone);
      end
   endtask: run_phase

   // Task: collect_item
   //
   protected task collect_item();
      // Measure delay
      item.delay = 0;
      do begin
         @(posedge vif.clk);
         item.delay++;
      end while (vif.op == vif.NOP);

      // Recover reg item transaction
      item.addr = vif.addr;
      if (vif.op == vif.RD) begin
         // TODO: Handle back-to-back reads
         item.op = item_t::READ;
         @(posedge vif.clk);
         item.data = vif.rdata;
      end else if (vif.op == vif.WR) begin
         item.op = item_t::WRITE;
         item.data = vif.wdata;
      end else begin
         `uvm_error("MON", $sformatf("unknown op: %h", vif.op))
      end
   endtask: collect_item

   // Function: do_check
   //
   protected function void do_check();
   endfunction: do_check

   // Function: do_cover
   //
   protected function void do_cover();
      item_cg.sample();
   endfunction: do_cover

endclass: reg_bus_monitor
