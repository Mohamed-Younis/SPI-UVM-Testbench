`ifndef MASTER_SLAVE_SPI_ENV
`define MASTER_SLAVE_SPI_ENV

class master_slave_spi_env extends uvm_env;

  `uvm_component_utils(master_slave_spi_env)
  spi_m_agent m_agent;
  spi_s_agent s_agent;
  spi_ms_agent ms_agent;
  master_slave_spi_scoreboard scoreboard;
  function new(string name = "master_slave_spi_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase (uvm_phase phase);
    m_agent = spi_m_agent::type_id::create("m_agent", this);
    s_agent = spi_s_agent::type_id::create("s_agent", this);
    ms_agent = spi_ms_agent::type_id::create("ms_agent", this);
    scoreboard = master_slave_spi_scoreboard::type_id::create("scoreboard", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    m_agent.agent_m_ap.connect(scoreboard.m_trn_fifo.analysis_export);
    s_agent.agent_s_ap.connect(scoreboard.s_trn_fifo.analysis_export);
    ms_agent.agent_ms_ap.connect(scoreboard.ms_trn_fifo.analysis_export);
  endfunction : connect_phase

endclass

`endif
