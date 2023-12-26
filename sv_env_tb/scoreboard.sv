`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV


`include "transactions.sv"

class scoreboard #(parameter INPUT1_WIDTH = 4, INPUT2_WIDTH = 5);
    
    logic [INPUT1_WIDTH+INPUT2_WIDTH-1:0] exp_out;
    
    function void predictor (input transactions t);    
        exp_out = t.x * t.y;
    endfunction
    
    task evaluate (input transactions t);
        predictor(t);
        if (exp_out != t.z) begin
            $error("test failed : expected output = %0d, output = %0d", exp_out, t.z);
        end
        else begin
            $display("test passed : expected output = %0d, output = %0d", exp_out, t.z);
        end    
    endtask
    
    
endclass


`endif
