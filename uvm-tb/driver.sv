`ifndef DRIVER_SV
`define DRIVER_SV 


import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.sv"

class driver extends uvm_driver #(transaction);
	`uvm_component_utils(driver)
	virtual mult_interface vif;
	


	function new( string name = "driver", uvm_component parent = null);
		super.new(name,parent);
	endfunction 
	
	virtual function void build_phase( uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual mult_interface)::get(this, "", "mult_interface", vif)) begin
			`uvm_fatal("Driver","Couldn't find virtual interface")
		end
	endfunction 

	virtual task run_phase (uvm_phase phase);
		transaction m_trans;
		super.run_phase(phase);
		forever begin
			`uvm_info("Driver","Wait for transaction from sequencer", UVM_HIGH)
			seq_item_port.get_next_item(m_trans);
			@(vif.cb_mult)
				vif.x <= m_trans.x;
				vif.y <= m_trans.y;
			seq_item_port.item_done();
		end
    endtask

endclass

`endif
