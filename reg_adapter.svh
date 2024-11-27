// Copyright (c) 2024 Andrew Parker

class reg_adapter #(int AWIDTH=8, int DWIDTH=8) extends uvm_reg_adapter;

   // Types
   typedef reg_adapter #(AWIDTH, DWIDTH) this_t;
   typedef reg_bus_item #(AWIDTH, DWIDTH) reg_bus_item_t;

   `uvm_object_utils(this_t)

   function new(string name="reg_adapter");
      super.new(name);
   endfunction

   virtual function uvm_sequence_item reg2bus(const ref uvm_reg_bus_op rw);
      reg_bus_item_t item;

      item = reg_bus_item_t::type_id::create("item");
      item.data = rw.data;
      item.addr = rw.addr;
      case (rw.kind)
        UVM_READ: item.op = reg_bus_item_t::READ;
        UVM_WRITE: item.op = reg_bus_item_t::WRITE;
      endcase
      return item;
   endfunction: reg2bus

   virtual function void bus2reg(uvm_sequence_item bus_item, ref uvm_reg_bus_op rw);
      reg_bus_item_t item;

      if (!$cast(item, bus_item))
        `uvm_fatal("CSTERR", "Cast of bus_item failed")

      rw.addr = item.addr;
      rw.data = item.data;
      case (item.op)
        reg_bus_item_t::READ: rw.kind = UVM_READ;
        reg_bus_item_t::WRITE: rw.kind = UVM_WRITE;
      endcase
      rw.status = UVM_IS_OK;

   endfunction: bus2reg
endclass: reg_adapter
