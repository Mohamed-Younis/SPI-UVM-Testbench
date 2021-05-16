package spi_m_agent_pkg;
  import uvm_pkg::*;
  
  `include "uvm_macros.svh"

  `include "spi_m_agent_config.sv"
  import spi_common_agent_pkg::*;
  typedef uvm_sequencer #(spi_seq_item) spi_m_sequencer;
  `include "spi_m_driver.sv"
  `include "spi_m_monitor.sv"
  `include "spi_m_agent.sv"
endpackage