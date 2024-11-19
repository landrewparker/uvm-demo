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

   task main_phase(uvm_phase phase);
      reg_random_seq seq;
      phase.raise_objection(this, "random_test");
      seq = reg_random_seq::type_id::create("seq");
      if (!seq.randomize()) begin
         `uvm_fatal("RNDERR", "Randomize failed");
      end
      seq.start(env0.reg_agent0.sequencer);
      phase.drop_objection(this, "random_test");
   endtask
endclass
