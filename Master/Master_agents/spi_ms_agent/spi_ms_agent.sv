`ifndef SPI_MS_AGENT
`define SPI_MS_AGENT

class spi_ms_agent extends uvm_agent;

  `uvm_component_utils(spi_ms_agent)

  uvm_analysis_port #(spi_seq_item) agent_ms_ap;
  spi_ms_driver driver;
  spi_ms_monitor monitor;
  spi_ms_sequencer sequencer;
  spi_ms_agent_config a_config;


  function new (string name = "spi_ms_agent", uvm_component parent = null);
      super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);

    if(!uvm_config_db #(spi_ms_agent_config)::get(this, "", "ms_agent_config", a_config)) begin
      `uvm_fatal(get_full_name(), "Can't get config for agent ms");
    end    
    if(a_config.active == 1) begin 
      driver = spi_ms_driver::type_id::create("driver", this);
      sequencer = spi_ms_sequencer::type_id::create("sequencer", this);
    end
   monitor = spi_ms_monitor::type_id::create("monitor", this);
  agent_ms_ap = new("agent_ms_ap", this);

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    if(a_config.active == 1) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
    monitor.monitor_ap.connect(agent_ms_ap);

  endfunction : connect_phase

endclass

`endif
