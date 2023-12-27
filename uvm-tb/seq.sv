`ifndef SEQ_SV
`define SEQ_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.sv"


class seq extends  uvm_sequence;
	`uvm_object_utils(seq)
	transaction m_trans;

	int n = 3000;

	function new( string name = "sequence");
		super.new(name);
	endfunction 

	virtual task body();
		repeat(n) begin
			m_trans = transaction::type_id::create("m_trans");
			start_item(m_trans);
			assert(m_trans.randomize());
			finish_item(m_trans);
		end
	endtask : body
	
endclass : seq
`endif
