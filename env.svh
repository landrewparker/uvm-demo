// Copyright (c) 2024 Andrew Parker

class env extends uvm_env;
   `uvm_component_utils(env)

   parameter int AWIDTH = 8;
   parameter int DWIDTH = 8;

   // Types
   typedef reg_bus_agent #(AWIDTH, DWIDTH) reg_bus_agent_t;

   // Agents
   reg_bus_agent_t reg_bus_agent0;

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
   endfunction // build_phase

endclass: env
