class dff_monitor extends uvm_monitor;
  `uvm_component_utils(dff_monitor)
  
  uvm_analysis_port#(dff_seq_item) item_collect_port;
  virtual dff_intf vif;  
  dff_seq_item mon_item;
  
  function new (string name = "dff_monitor", uvm_component parent = null);
    super.new(name,parent);
    item_collect_port = new("item_collect_port",this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(virtual dff_intf)::get(this,"","vif",vif))
      `uvm_fatal(get_type_name(),"virtual interface not set on top level");
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    mon_item = dff_seq_item::type_id::create("mon_item");
    
    forever begin  
      @(posedge vif.clk)
      mon_item.d = vif.d;
      mon_item.rst = vif.rst;
      mon_item.q = vif.q;
      
      item_collect_port.write(mon_item);
    end
  endtask
endclass
