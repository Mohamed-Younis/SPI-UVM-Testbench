`ifndef SPI_S_AGENT
`define SPI_S_AGENT

class spi_s_agent extends uvm_agent;

  `uvm_component_utils(spi_s_agent)

  uvm_analysis_port #(spi_seq_item) agent_s_ap;
  spi_s_driver driver;
  spi_s_monitor monitor;
  spi_s_sequencer sequencer;
  spi_s_agent_config a_config;


  function new (string name = "spi_s_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);

    if(!uvm_config_db #(spi_s_agent_config)::get(this, "", "s_agent_config", a_config)) begin
      `uvm_fatal(get_full_name(), "Can't get config for agent s");
    end    
    if(a_config.active == 1) begin 
      driver =spi_s_driver::type_id::create("driver", this);
      sequencer = spi_s_sequencer::type_id::create("sequencer", this);
    end
    monitor = spi_s_monitor::type_id::create("monitor", this);
    agent_s_ap = new("agent_s_ap", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    if(a_config.active == 1) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
    monitor.monitor_ap.connect(agent_s_ap);
  endfunction : connect_phase

endclass

`endif
