// Copyright (c) 2024 Andrew Parker

class reg_agent #(AWIDTH=8, DWIDTH=8) extends uvm_agent;

   // Types
   typedef reg_agent #(AWIDTH, DWIDTH) this_t;
   typedef reg_item #(AWIDTH, DWIDTH) item_t;
   typedef reg_monitor #(AWIDTH, DWIDTH) monitor_t;
   typedef reg_driver #(AWIDTH, DWIDTH) driver_t;
   typedef uvm_sequencer #(item_t) sequencer_t;

   // Config
   uvm_active_passive_enum is_active;

   // UVM component utils
   `uvm_component_param_utils(this_t)

   // Monitor, driver, and sequencer
   monitor_t monitor;
   driver_t driver;
   sequencer_t sequencer;

   // Function: new
   //
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction: new

   // Function: build_phase
   //
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      // Get config (TODO: auto configure)
      assert(uvm_config_db #(uvm_active_passive_enum)::get(this, "", "is_active", is_active))
        else `uvm_fatal("CFGERR", "is_active not configured")

      // Create monitor
      monitor = monitor_t::type_id::create("monitor", this);

      // Create driver and sequencer when active
      if (is_active == UVM_ACTIVE) begin
         driver = driver_t::type_id::create("driver", this);
         sequencer = sequencer_t::type_id::create("sequencer", this);
      end
   endfunction: build_phase

   // Function: connect_phase
   //
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);

      // Connect driver and sequencer if active
      if (is_active == UVM_ACTIVE) begin
         driver.seq_item_port.connect(sequencer.seq_item_export);
      end
   endfunction: connect_phase

endclass: reg_agent
