package spi_sm_agent_pkg;
  import uvm_pkg::*;
  
  `include "uvm_macros.svh"

  `include "spi_sm_agent_config.sv"
  import spi_common_agent_pkg::*;
  typedef uvm_sequencer #(spi_seq_item) spi_sm_sequencer;
  `include "spi_sm_driver.sv"
  `include "spi_sm_driver_1.sv"
  `include "spi_sm_monitor.sv"
  `include "spi_sm_monitor_1.sv"
  `include "spi_sm_agent.sv"
endpackage