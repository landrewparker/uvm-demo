// Copyright (c) 2024 Andrew Parker

class env extends uvm_env;
   `uvm_component_utils(env)

   parameter int AWIDTH = 8;
   parameter int DWIDTH = 8;

   // Types
   typedef reg_bus_item #(AWIDTH, DWIDTH) reg_bus_item_t;
   typedef reg_bus_agent #(AWIDTH, DWIDTH) reg_bus_agent_t;
   typedef reg_adapter #(AWIDTH, DWIDTH) reg_adapter_t;
   typedef uvm_reg_predictor #(reg_bus_item_t) reg_predictor_t;

   // Agents
   reg_bus_agent_t reg_bus_agent0;

   // Register model
   reg_block reg_model0;
   reg_adapter reg_adapter0;
   reg_predictor_t reg_predictor;

   // Function: new
   //
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction // new

   // Function: build_phase
   //
   function void build_phase(uvm_phase phase);
      super.build_phase(phase);

      // Create agents
      reg_bus_agent0 = reg_bus_agent_t::type_id::create("reg_bus_agent0", this);

      // Configure agents
      uvm_config_db #(uvm_active_passive_enum)::set(this, "reg_bus_agent0", "is_active",  UVM_ACTIVE);

      // Create register model, bus adapter, and predictor
      reg_model0 = reg_block::type_id::create("reg_model0", this);
      reg_model0.build();
      reg_adapter0 = reg_adapter_t::type_id::create("reg_adapter0", this);
      reg_predictor = reg_predictor_t::type_id::create("reg_predictor", this);
   endfunction: build_phase

   // Function: connect_phase
   //
   function void connect_phase(uvm_phase phase);
      super.connect_phase(phase);

      // Connect register model to bus agent, adapter, and predictor
      reg_model0.default_map.set_sequencer(reg_bus_agent0.sequencer, reg_adapter0);
      reg_model0.default_map.set_check_on_read();
      reg_predictor.adapter = reg_adapter0;
      reg_predictor.map = reg_model0.default_map;
      reg_bus_agent0.monitor.ap.connect(reg_predictor.bus_in);
   endfunction: connect_phase

endclass: env
