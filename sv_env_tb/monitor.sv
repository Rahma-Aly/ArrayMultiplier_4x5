`ifndef MONITOR_SV
`define MONITOR_SV

`include "transactions.sv"
`include "coverage.sv"
`include "scoreboard.sv"

class monitor #(parameter INPUT1_WIDTH = 4, INPUT2_WIDTH = 5);
    
    virtual mult_interface #(INPUT1_WIDTH,INPUT2_WIDTH) vif; 
    transactions #(INPUT1_WIDTH,INPUT2_WIDTH) mult_trans; 
    scoreboard   #(INPUT1_WIDTH,INPUT2_WIDTH) scrbrd;
    coverage     #(INPUT1_WIDTH,INPUT2_WIDTH) mult_cov;
    
    function new( input virtual mult_interface vif, coverage mult_cov, scoreboard  scrbrd);
        this.vif = vif;
        this.mult_cov = mult_cov;
        this.scrbrd = scrbrd;
    endfunction
    
    task monitor();
        while(1) begin
            @(vif.cb_mult);
            if (vif.rst_n) begin
                mult_trans = new();
                mult_trans.x = vif.x;
                mult_trans.y = vif.y;
                mult_trans.z = vif.cb_mult.z;
                
//                 @(vif.cb_mult);
                scrbrd.evaluate(mult_trans);
                mult_cov.execute(mult_trans);
            end
            
        end
        
    endtask
    
endclass


`endif
