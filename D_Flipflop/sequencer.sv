class dff_sequencer extends uvm_sequencer#(dff_seq_item);
  `uvm_component_utils(dff_sequencer) 
  
  function new (string name = "dff_sequencer", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
endclass