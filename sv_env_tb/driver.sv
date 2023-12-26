`ifndef DRIVER_SV
`define DRIVER_SV

`include "transactions.sv"

class driver #(parameter INPUT1_WIDTH = 4, INPUT2_WIDTH = 5);
    
    transactions #(INPUT1_WIDTH, INPUT2_WIDTH) mult_trans;
    virtual mult_interface #(INPUT1_WIDTH, INPUT2_WIDTH) vif;
    integer n = 3000;
    
    function new(input virtual mult_interface vif);
        this.vif = vif;
    endfunction
    
    task driver();
        mult_trans = new();
        repeat(n) begin
            assert(mult_trans.randomize());
            @(vif.cb_mult);
            vif.cb_mult.x <= mult_trans.x;
            vif.cb_mult.y <= mult_trans.y;
            
            $display("Driver: X = %0d, Y = %0d ",vif.cb_mult.x ,vif.cb_mult.y );
            
        end
        
    endtask
    
    
endclass


`endif
