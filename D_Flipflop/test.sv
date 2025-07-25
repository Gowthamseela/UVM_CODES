class dff_test extends uvm_test;
  `uvm_component_utils(dff_test)
  
  dff_env env_o;
  dff_sequence seq;
  
  function new (string name = "dff_test", uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_o = dff_env :: type_id :: create ("env_o",this);
    seq = dff_sequence :: type_id :: create ("seq",this);
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    seq.start(env_o.agt.seqr);
    #1000;
    phase.drop_objection(this);
  endtask
  
  function void end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
  endfunction
endclass