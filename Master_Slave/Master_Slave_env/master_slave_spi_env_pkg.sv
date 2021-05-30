package master_slave_spi_env_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import spi_common_agent_pkg::*;
  import spi_m_agent_pkg::*;
  import spi_ms_agent_pkg::*;
  import spi_s_agent_pkg::*;
  `include "master_slave_spi_scoreboard.sv"
  `include "master_slave_spi_env.sv"
endpackage