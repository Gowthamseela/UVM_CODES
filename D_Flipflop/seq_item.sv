class dff_seq_item extends uvm_sequence_item;
  rand bit d;
  rand bit rst;
  bit q;
  
  function new (string name = "dff_seq_item");
    super.new(name);
  endfunction
  
  `uvm_object_utils_begin(dff_seq_item)
  `uvm_field_int(d,UVM_ALL_ON)
  `uvm_field_int(rst,UVM_ALL_ON)
  `uvm_field_int(q,UVM_ALL_ON)
  `uvm_object_utils_end
  
  function string convert2string();
    return $psprintf("d=%0d /n q=%0d /n rst=%0d",d,q,rst);
  endfunction
endclass