import uvm_pkg::*;
`include "uvm_macros.svh"
`include "interface.sv"
`include "package.sv"

module top;
  
  bit clk;
  
  
  always #10 clk = ~clk;
  
    dff_intf vif(clk);
  

  dff dut(
    .clk(vif.clk),
    .rst(vif.rst),
    .d(vif.d),
    .q(vif.q)
  );
  

  initial begin

    uvm_config_db#(virtual dff_intf)::set(null, "*", "vif", vif);
    

    run_test("dff_test");
  end
  
endmodule