`ifndef TRANSACTION_SV
`define TRANSACTION_SV 

import uvm_pkg::*;
`include "uvm_macros.svh"

import definitions::*;


class transaction extends uvm_sequence_item;
	`uvm_object_utils(transaction)

	rand bit [INPUT1_WIDTH-1:0] x;
	rand bit [INPUT2_WIDTH-1:0] y;
	logic [INPUT1_WIDTH + INPUT2_WIDTH -1:0] z;

	function new (string name = "transaction");
		super.new(name);
	endfunction 

	virtual function string convert2string();
		return $sformatf("x = %0d, y = %0d, multiplier output = %0d", x,y,z);
	endfunction

endclass : transaction
`endif
