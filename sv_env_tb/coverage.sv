`ifndef _COVERAGE_SV_
`define _COVERAGE_SV_

`include "transactions.sv"

class coverage #(parameter INPUT1_WIDTH = 4, INPUT2_WIDTH = 5);

    bit [INPUT1_WIDTH-1:0] x;
    bit [INPUT2_WIDTH-1:0] y;
    logic [INPUT1_WIDTH+INPUT2_WIDTH-1:0] z;  
    
    
    covergroup input_val;
        x_val : coverpoint x {
            bins zeros = {'b0};
            bins ones  = {{INPUT1_WIDTH{1'b1}}};
            bins others[] = {['b1:{INPUT1_WIDTH{1'b1}}-1]};
        }  
        y_val : coverpoint y {
            bins zeros = {'b0};
            bins ones  = {{INPUT1_WIDTH{1'b1}}};
            bins others[] = {['b1:{INPUT1_WIDTH{1'b1}}-1]};
        }       
        xy_val: cross x_val,y_val;
    endgroup
    
    covergroup output_val;
        z_val : coverpoint z {
            bins zeros = {'b0};
            bins ones  = {{(INPUT1_WIDTH+INPUT2_WIDTH){1'b1}}};
            bins others[] = {['b1: {(INPUT1_WIDTH+INPUT2_WIDTH){1'b1}}-1] };
        }
    endgroup
    
    function new();
        input_val = new();
        output_val = new();
    endfunction
    
    task execute (input transactions t);
        x = t.x;
        y = t.y;
        z = t.z;
        input_val.sample();
        output_val.sample();
    endtask
    
    
        
endclass


`endif
