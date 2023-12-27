`ifndef MONITOR_SV
`define MONITOR_SV


`include "uvm_macros.svh"
`include "transaction.sv"

import uvm_pkg::*;

class monitor extends  uvm_monitor;
	`uvm_component_utils(monitor)
	virtual mult_interface vif;
	transaction m_trans;
	uvm_analysis_port #(transaction) m_analysis_port;


	function new( string name = "monitor", uvm_component parent = null);
		super.new(name,parent);
	endfunction 

	virtual function void build_phase( uvm_phase phase);
		super.build_phase(phase);
		if (!uvm_config_db#(virtual mult_interface)::get(this, "", "mult_interface",vif )) begin
			`uvm_fatal("Monitor", "Couldn't get virtual interface")
		end
		m_analysis_port = new("m_analysis_port",this);
	endfunction

	virtual task run_phase( uvm_phase phase);
		super.run_phase(phase);
		forever begin
			@(vif.cb_mult);
			if (vif.rst_n) begin
				m_trans = transaction::type_id::create("m_trans");
				m_trans.x = vif.x;
				m_trans.y = vif.y;
				m_trans.z = vif.cb_mult.z;

				m_analysis_port.write(m_trans);
				`uvm_info("monitor", $sformatf("transaction: ",m_trans.convert2string()),UVM_HIGH)
			end
		end
	endtask : run_phase

endclass : monitor

`endif
