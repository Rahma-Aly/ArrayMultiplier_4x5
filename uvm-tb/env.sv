`ifndef ENV_SV
`define ENV_SV 

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "Agent.sv"
`include "scoreboard.sv"
`include "coverage.sv"

class env extends  uvm_env;
	`uvm_component_utils(env)
	Agent 		m_agent;
	scoreboard  m_scrbrd;
	coverage    m_cov;

	function new (string name = "env",uvm_component parent = null );
		super.new(name,parent);
	endfunction 


	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m_agent  = Agent::type_id::create("m_agent",this);
		m_scrbrd = scoreboard::type_id::create("m_scrbrd",this);
		m_cov    = coverage::type_id::create("m_cov",this);
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		m_agent.m_monitor.m_analysis_port.connect(m_scrbrd.analysis_export);
		m_agent.m_monitor.m_analysis_port.connect(m_cov.analysis_export);
	endfunction 
endclass : env
`endif
