`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

import uvm_pkg::*;
import definitions::*;


`include "uvm_macros.svh"
`include "transaction.sv"

class scoreboard extends uvm_subscriber #(transaction);
	`uvm_component_utils(scoreboard)
	transaction m_trans;

	function new (string name = "scoreboard", uvm_component parent = null);
		super.new(name,parent);
	endfunction 

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m_trans = transaction::type_id::create("m_trans");
	endfunction 

	virtual function void write(transaction t);
		 logic [INPUT1_WIDTH+INPUT2_WIDTH-1:0] exp_out;
		 exp_out = t.x * t.y;
		 if (exp_out != t.z) begin
            `uvm_error("scoreboard",$sformatf("test failed : expected output = %0d, output = %0d", exp_out, t.z))
        end
        else begin
            `uvm_info("scoreboard",$sformatf("test Passed : expected output = %0d, output = %0d", exp_out, t.z),UVM_NONE)
        end  
	endfunction
endclass
`endif
