`ifndef MULT_INTERFACE_SV
`define MULT_INTERFACE_SV
`timescale 1ns/1ns

interface mult_interface #(parameter INPUT1_WIDTH = 4, INPUT2_WIDTH = 5);
    bit                                   clk;
    bit                                   rst_n;
    logic [INPUT1_WIDTH-1:0]              x;
    logic [INPUT2_WIDTH-1:0]              y;
    logic [INPUT1_WIDTH+INPUT2_WIDTH-1:0] z;    
    
    
    default clocking cb_mult @(posedge clk);
        default input #0ns output #10ns;
        output  rst_n;
        output  x,y;
        input   z;
    endclocking
    
endinterface


`endif
