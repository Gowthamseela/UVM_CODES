class dff_driver extends uvm_driver#(dff_seq_item);
  `uvm_component_utils(dff_driver) 
  
  virtual dff_intf vif;
  
  function new (string name = "dff_driver", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual dff_intf)::get(this,"","vif",vif))
      `uvm_fatal(get_type_name(),"virtual interface not set on top level");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      dff_seq_item req;
      seq_item_port.get_next_item(req);
      
      vif.d = req.d;
      vif.rst = req.rst;
      
      @(posedge vif.clk);
      
      seq_item_port.item_done();
    end
  endtask
endclass