// Copyright (c) 2024 Andrew Parker

class random_test extends uvm_test;
   `uvm_component_utils(random_test)

   env env0;

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction

   function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env0 = env::type_id::create("env0", this);
   endfunction

   function void end_of_elaboration_phase(uvm_phase phase);
      super.end_of_elaboration_phase(phase);
      // Print the component hierarchy
      this.print();
   endfunction

   task main_phase(uvm_phase phase);
      reg_bus_random_seq seq;
      phase.raise_objection(this, "random_test");
      seq = reg_bus_random_seq::type_id::create("seq");
      if (!seq.randomize()) begin
         `uvm_fatal("RNDERR", "Randomize failed");
      end
      seq.start(env0.reg_bus_agent0.sequencer);
      phase.drop_objection(this, "random_test");
   endtask
endclass
