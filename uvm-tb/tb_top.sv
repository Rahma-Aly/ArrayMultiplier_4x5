

`timescale 1ns/1ns
import definitions::*;
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "test.sv"

module tb_top ();

mult_interface #(
      .INPUT1_WIDTH(INPUT1_WIDTH),
      .INPUT2_WIDTH(INPUT2_WIDTH)
  ) mult_inter();  

ArrayMultiplier_4x5 DUT (
    .clk(mult_inter.clk),
    .rst_n(mult_inter.rst_n), 
    .x(mult_inter.x),
    .y(mult_inter.y),
    .z(mult_inter.z)
  );

localparam CLK_PERIOD = 100;
always #(CLK_PERIOD/2) mult_inter.clk = ~mult_inter.clk;

initial begin
	mult_inter.clk   <= 0;
	mult_inter.rst_n <= 1;
	uvm_config_db#(virtual mult_interface)::set(null, "uvm_test_top", "mult_interface", mult_inter);
	run_test("test");
end

endmodule
