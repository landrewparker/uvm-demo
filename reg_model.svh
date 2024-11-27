// Copyright (c) 2024 Andrew Parker

class reg0_reg extends uvm_reg;
   `uvm_object_utils(reg0_reg)

   rand uvm_reg_field field0;

   function new(string name="reg0_reg");
      super.new(name, 8, UVM_NO_COVERAGE);
   endfunction // new

   virtual function void build();
      field0 = uvm_reg_field::type_id::create("field0");
      field0.configure(this, 8, 0, "RW", 0, 0, 1, 1, 1);
   endfunction
endclass: reg0_reg


class reg1_reg extends uvm_reg;
   `uvm_object_utils(reg1_reg)

   rand uvm_reg_field field1;

   function new(string name="reg1_reg");
      super.new(name, 8, UVM_NO_COVERAGE);
   endfunction // new

   virtual function void build();
      field1 = uvm_reg_field::type_id::create("field1");
      field1.configure(this, 8, 0, "RW", 0, 0, 1, 1, 1);
   endfunction
endclass: reg1_reg


class reg_block extends uvm_reg_block;
   `uvm_object_utils(reg_block)

   rand reg0_reg reg0;
   rand reg1_reg reg1;

   function new(string name="reg_block");
      super.new(name, UVM_NO_COVERAGE);
   endfunction // new

   virtual function void build();
      reg0 = reg0_reg::type_id::create("reg0");
      reg1 = reg1_reg::type_id::create("reg1");

      reg0.configure(this, null, "");
      reg1.configure(this, null, "");

      reg0.build();
      reg1.build();

      default_map = create_map("default_map", 8'h00, 1, UVM_LITTLE_ENDIAN);

      default_map.add_reg(reg0, 8'h00, "RW");
      default_map.add_reg(reg1, 8'h01, "RW");

      lock_model();
   endfunction: build
endclass: reg_block
