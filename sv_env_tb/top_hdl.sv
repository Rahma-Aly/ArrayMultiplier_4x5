`timescale 1ns/1ns

module top_hdl #(parameter INPUT1_WIDTH = 4, INPUT2_WIDTH = 5)
    (mult_interface mult_inter);


localparam CLK_PERIOD = 100;


ArrayMultiplier_4x5 ArrayMultiplier_4x5_instance(
    .clk(mult_inter.clk),
    .rst_n(mult_inter.rst_n),
    .x(mult_inter.x),
    .y(mult_inter.y),
    .z(mult_inter.z)
);   

always #(CLK_PERIOD/2) mult_inter.clk = ~mult_inter.clk;

initial begin
  mult_inter.clk <= 'b0;
  mult_inter.rst_n <= 'b1;
  #(CLK_PERIOD/4)
  mult_inter.rst_n <= 'b0;
  #(CLK_PERIOD/4)
  mult_inter.rst_n <= 'b1;
  
end

 
endmodule 
