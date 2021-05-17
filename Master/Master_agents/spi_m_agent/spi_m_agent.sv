`ifndef SPI_M_AGENT
`define SPI_M_AGENT

class spi_m_agent extends uvm_agent;

  `uvm_component_utils(spi_m_agent)

  uvm_analysis_port #(spi_seq_item) agent_m_ap;
  spi_m_driver driver;
  spi_m_monitor monitor;
  spi_m_sequencer sequencer;
  spi_m_agent_config a_config;


  function new (string name = "spi_m_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);

    if(!uvm_config_db #(spi_m_agent_config)::get(this, "", "m_agent_config", a_config)) begin
      `uvm_fatal(get_full_name(), "Can't get config for agent m");
    end    
    if(a_config.active == 1) begin 
      driver =spi_m_driver::type_id::create("driver", this);
      sequencer = spi_m_sequencer::type_id::create("sequencer", this);
    end
    monitor = spi_m_monitor::type_id::create("monitor", this);
    agent_m_ap = new("agent_m_ap", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    if(a_config.active == 1) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
    monitor.monitor_ap.connect(agent_m_ap);
  endfunction : connect_phase

endclass

`endif
