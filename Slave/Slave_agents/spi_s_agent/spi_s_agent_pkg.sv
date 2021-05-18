package spi_m_agent_pkg;
  import uvm_pkg::*;
  
  `include "uvm_macros.svh"

  `include "spi_s_agent_config.sv"
  import spi_common_agent_pkg::*;
  typedef uvm_sequencer #(spi_seq_item) spi_s_sequencer;
  `include "spi_s_driver.sv"
  `include "spi_s_monitor.sv"
  `include "spi_s_agent.sv"
endpackage