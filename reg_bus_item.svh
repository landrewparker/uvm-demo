// Copyright (c) 2024 Andrew Parker

// Class: reg_bus_item
//
class reg_bus_item #(AWIDTH=8, DWIDTH=8) extends uvm_sequence_item;

   // Types
   typedef reg_bus_item #(AWIDTH, DWIDTH) this_t;
   typedef enum {READ, WRITE} op_t;

   // Random variables
   rand op_t op;
   rand bit [AWIDTH-1:0] addr;
   rand bit [DWIDTH-1:0] data;
   rand int unsigned delay;

   // UVM object utils
   `uvm_object_param_utils_begin(this_t)
      `uvm_field_enum(op_t, op, UVM_DEFAULT)
      `uvm_field_int(addr, UVM_DEFAULT)
      `uvm_field_int(data, UVM_DEFAULT)
      `uvm_field_int(delay, UVM_DEFAULT | UVM_NOPACK | UVM_NOCOMPARE)
   `uvm_object_utils_end

   // Constraints
   constraint delay_c {
     delay inside {[0:1000]};
   }

   // Function: new
   //
   function new(string name = "reg_bus_item");
      super.new(name);
   endfunction

endclass: reg_bus_item
