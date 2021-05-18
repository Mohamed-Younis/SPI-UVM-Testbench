package spi_ms_agent_pkg;
  import uvm_pkg::*;
  
  `include "uvm_macros.svh"

  `include "spi_ms_agent_config.sv"
  import spi_common_agent_pkg::*;
  typedef uvm_sequencer #(spi_seq_item) spi_ms_sequencer;
  `include "spi_ms_driver.sv"
  `include "spi_ms_driver_1.sv"
  `include "spi_ms_monitor.sv"
  `include "spi_ms_monitor_1.sv"
  `include "spi_ms_agent.sv"
endpackage