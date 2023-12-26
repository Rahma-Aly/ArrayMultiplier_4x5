`ifndef TRANSACTIONS_SV
`define TRANSACTIONS_SV

class transactions #(parameter INPUT1_WIDTH = 4, INPUT2_WIDTH = 5);
    bit                                      clk;
    bit                                      rst_n;
    rand bit [INPUT1_WIDTH-1:0]              x;
    rand bit [INPUT2_WIDTH-1:0]              y;
    logic [INPUT1_WIDTH+INPUT2_WIDTH-1:0]    z; 
    
    
endclass

`endif
