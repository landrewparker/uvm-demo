// Copyright (c) 2024 Andrew Parker

class reg_bus_random_seq extends uvm_sequence #(reg_bus_item);
   `uvm_object_utils(reg_bus_random_seq)

   function new(string name = "");
      super.new(name);
   endfunction // new

   task body();
      reg_bus_item req;
      repeat (10) begin
         req = reg_bus_item #(8,8)::type_id::create("req");
         start_item(req);
         if (!req.randomize() with {addr inside {'h00, 'h01};})
           `uvm_fatal("RNDERR", "Randomize failed")
         finish_item(req);
      end
   endtask

endclass: reg_bus_random_seq
