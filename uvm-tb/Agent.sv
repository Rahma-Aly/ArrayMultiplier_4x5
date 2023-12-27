`ifndef AGENT_SV
`define AGENT_SV 

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.sv"
`include "monitor.sv"
`include "driver.sv"

class Agent extends uvm_agent;
	`uvm_component_utils(Agent)
	driver m_driver;
	monitor m_monitor;
	uvm_sequencer #(transaction) m_sequencer;


	function new (string name = "Agent", uvm_component parent = null);
		super.new(name,parent);
	endfunction 

	virtual function void build_phase( uvm_phase phase);
		super.build_phase(phase);
		m_driver    = driver::type_id::create("m_driver",this);
		m_monitor   = monitor::type_id::create("m_monitor",this);
		m_sequencer = uvm_sequencer#(transaction) ::type_id::create("m_sequencer",this);

	endfunction 

	virtual function void connect_phase( uvm_phase phase);
		super.connect_phase(phase);
		m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
	endfunction
endclass


`endif
