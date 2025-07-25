class dff_agent extends uvm_agent;
  `uvm_component_utils(dff_agent);
  
  dff_sequencer seqr;
  dff_driver drv;
  dff_monitor mon;
  
  function new(string name ="dff_agent",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(get_is_active == UVM_ACTIVE) begin
      drv = dff_driver :: type_id :: create("drv",this);
      seqr = dff_sequencer :: type_id :: create("seqr",this);
    end
    mon = dff_monitor :: type_id :: create("mon",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    if(get_is_active == UVM_ACTIVE) begin
      drv.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction
endclass