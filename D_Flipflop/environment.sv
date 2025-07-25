class dff_env extends uvm_env;
  `uvm_component_utils(dff_env)

  dff_agent agt;
  dff_scoreboard scb;
  
  function new (string name = "dff_env", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    agt = dff_agent::type_id::create("agt",this);
    scb = dff_scoreboard::type_id::create("scb",this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agt.mon.item_collect_port.connect(scb.item_collect_export);
  endfunction
endclass