// Copyright (c) 2024 Andrew Parker

class reg_random_seq extends uvm_sequence #(reg_item);
   `uvm_object_utils(reg_random_seq)

   function new(string name = "");
      super.new(name);
   endfunction // new

   task body();
      reg_item req;
      repeat (10) begin
         req = reg_item #(8,8)::type_id::create("req");
         start_item(req);
         req.randomize();
         finish_item(req);
      end
   endtask

endclass: reg_random_seq
