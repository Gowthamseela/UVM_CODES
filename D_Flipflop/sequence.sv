	class dff_sequence extends uvm_sequence#(dff_seq_item);
  `uvm_object_utils(dff_sequence)
  
  function new (string name = "dff_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    `uvm_info(get_type_name(),$sformatf("Generate random sequences"),UVM_LOW)
   
    repeat(20)begin
      req=dff_seq_item::type_id::create("req");
      start_item(req);
      assert(req.randomize());
      finish_item(req);
    end
  endtask
endclass