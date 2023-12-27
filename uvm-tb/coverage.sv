`ifndef COVERGAE_SV
`define COVERGAE_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.sv"

class coverage extends uvm_subscriber #(transaction);
	`uvm_component_utils(coverage)
	transaction m_trans;

	covergroup input_val;
        x_val : coverpoint m_trans.x {
            bins zeros = {'b0};
            bins ones  = {{INPUT1_WIDTH{1'b1}}};
            bins others[] = {['b1:{INPUT1_WIDTH{1'b1}}-1]};
        }  
        y_val : coverpoint m_trans.y {
            bins zeros = {'b0};
            bins ones  = {{INPUT1_WIDTH{1'b1}}};
            bins others[] = {['b1:{INPUT1_WIDTH{1'b1}}-1]};
        }       
        xy_val: cross x_val,y_val;
    endgroup
    
    covergroup output_val;
        z_val : coverpoint m_trans.z {
            bins zeros = {'b0};
            bins ones  = {{(INPUT1_WIDTH+INPUT2_WIDTH){1'b1}}};
            bins others[] = {['b1: {(INPUT1_WIDTH+INPUT2_WIDTH){1'b1}}-1] };
        }
    endgroup

	function new (string name = "coverage",uvm_component parent = null);
		super.new(name,parent);
		input_val = new();
        output_val = new();
	endfunction 

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m_trans = transaction::type_id::create("m_trans");
	endfunction

	virtual function void write(transaction t);
		m_trans = t;
		input_val.sample();
        output_val.sample();
	endfunction 
	
endclass
`endif
