`ifndef SPI_ENV
`define SPI_ENV

class spi_env extends uvm_env;

  `uvm_component_utils(spi_env)
  spi_m_agent m_agent;
  spi_ms_agent ms_agent;
  spi_scoreboard scoreboard;
  function new(string name = "spi_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase (uvm_phase phase);
    m_agent = spi_m_agent::type_id::create("m_agent", this);
    ms_agent = spi_ms_agent::type_id::create("ms_agent", this);
    scoreboard = spi_scoreboard::type_id::create("scoreboard", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    m_agent.agent_m_ap.connect(scoreboard.m_trn_fifo.analysis_export);
    ms_agent.agent_ms_ap.connect(scoreboard.ms_trn_fifo.analysis_export);
  endfunction : connect_phase

endclass

`endif
