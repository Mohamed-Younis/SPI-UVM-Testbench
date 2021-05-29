`ifndef SPI_ENV
`define SPI_ENV

class spi_env extends uvm_env;

  `uvm_component_utils(spi_env)
  spi_s_agent s_agent;
  spi_sm_agent sm_agent;
  spi_scoreboard scoreboard;
  function new(string name = "spi_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase (uvm_phase phase);
    s_agent = spi_s_agent::type_id::create("s_agent", this);
    sm_agent = spi_sm_agent::type_id::create("sm_agent", this);
    scoreboard = spi_scoreboard::type_id::create("scoreboard", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    s_agent.agent_s_ap.connect(scoreboard.s_trn_fifo.analysis_export);
    sm_agent.agent_sm_ap.connect(scoreboard.sm_trn_fifo.analysis_export);
  endfunction : connect_phase

endclass

`endif
