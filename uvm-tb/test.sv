`ifndef TEST_SV
`define TEST_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "env.sv"
`include "seq.sv"

class test extends uvm_test;
	`uvm_component_utils(test)
	virtual mult_interface vif;
	env m_env;
	seq m_seq;

	function new (string name = "test", uvm_component parent = null);
		super.new(name,parent);
	endfunction 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if (!uvm_config_db#(virtual mult_interface)::get(this, "", "mult_interface",vif )) begin
			`uvm_fatal("test","Couldn't find virtual interface")
		end
		uvm_config_db#(virtual mult_interface)::set(this, "m_env.m_agent.*", "mult_interface", vif);

		m_env = env::type_id::create("m_env",this);
		m_seq = seq::type_id::create("m_seq");

	endfunction 

	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		apply_rst();
		m_seq.start(m_env.m_agent.m_sequencer);
		#100;
		phase.drop_objection(this);
	endtask : run_phase

	virtual task  apply_rst();
		vif.rst_n <= 1'b1;
		vif.x     <= 0;
		vif.y     <= 0;
		@(negedge vif.clk)
		vif.rst_n <= 1'b0;
		@(negedge vif.clk)
		vif.rst_n <= 1'b1;
	endtask 
endclass
`endif
