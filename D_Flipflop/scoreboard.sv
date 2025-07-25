class dff_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(dff_scoreboard)
  
  uvm_analysis_imp#(dff_seq_item, dff_scoreboard) item_collect_export;
  
  bit expected_q;
  
  covergroup dff_coverage with function sample(bit d, bit rst, bit q);
    d_cp: coverpoint d {
//       bins low = {0};
//       bins high = {1};
      bins d_values = {0,1};
    }
    
    rst_cp: coverpoint rst {
//       bins low = {0};
//       bins high = {1};
      bins rst_values = {0,1};
    }
    
    q_cp: coverpoint q {
//       bins low = {0};
//       bins high = {1};
      bins q_values = {0,1};
    }
    
    all_cross: cross d_cp, rst_cp, q_cp;
  endgroup
  
  real cov_percentage;
  
  function new(string name = "dff_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    item_collect_export = new("item_collect_export", this);
    dff_coverage = new();
  endfunction

  virtual function void write(dff_seq_item t);
    $display("-------------------------------------------------");
    if (t.rst) begin
      expected_q = 0;
    end else begin
      expected_q = t.d;
    end
    
    if (expected_q != t.q) begin
      `uvm_error("DFF Scoreboard", $sformatf("Mismatch! Expected: %0b, Got: %0b", expected_q, t.q))
    end else begin
      `uvm_info("DFF Scoreboard", "Match found", UVM_LOW)
    end
    
    dff_coverage.sample(t.d, t.rst, t.q);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "Scoreboard started", UVM_LOW);
    
    #1000ns;  
    
    phase.raise_objection(this);
    
    cov_percentage = dff_coverage.get_inst_coverage();
    `uvm_info(get_type_name(), $sformatf("Coverage Collected: %0.2f%%", cov_percentage), UVM_LOW)
    
    phase.drop_objection(this);
  endtask

  function void report_phase(uvm_phase phase);
    cov_percentage = dff_coverage.get_inst_coverage();
    `uvm_info(get_type_name(), $sformatf("Final Coverage: %0.2f%%", cov_percentage), UVM_LOW)
  
    $display("---------------------------------------");
    $display("Overall Coverage:                               %0.2f%%", $get_coverage());
    $display("Coverage of covergroup 'dff_coverage':         %0.2f%%", dff_coverage.get_coverage());
    
     $display("Coverage of coverpoint 'd_cp' = %0f", dff_coverage.d_cp.get_coverage());
    $display("Coverage of coverpoint 'rst_cp' = %0f", dff_coverage.rst_cp.get_coverage());
    $display("Coverage of coverpoint 'q_cp' = %0f", dff_coverage.q_cp.get_coverage());
     
    $display("-------------------------------------------------");

    $display("-------------------------------------------");
    
  endfunction
endclass