// Copyright (c) 2024 Andrew Parker

// Class: reg_item
//
class reg_item #(AWIDTH=8, DWIDTH=8) extends uvm_sequence_item;

   // Types
   typedef reg_item #(AWIDTH, DWIDTH) this_t;
   typedef enum {READ, WRITE} op_t;

   // Random variables
   rand op_t op;
   rand bit [AWDITH-1:0] addr;
   rand bit [DWIDTH-1:0] data;
   rand int delay;

   // UVM object utils
   `uvm_object_param_utils_begin(this_t)
      `uvm_field_enum(op_t, op, UVM_DEFAULT)
      `uvm_field_int(addr, UVM_DEFAULT)
      `uvm_field_int(data, UVM_DEFAULT)
      `uvm_field_int(delay, UVM_DEFAULT | UVM_NOPACK | UVM_NOPCOMPARE)
   `uvm_object_utils_end

   // Function: new
   //
   function new(string name = "reg_item");
      super.new(name);
   endfunction

endclass: reg_item
