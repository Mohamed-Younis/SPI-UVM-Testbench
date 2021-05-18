`ifndef SPI_SM_AGENT
`define SPI_SM_AGENT

class spi_sm_agent extends uvm_agent;

  `uvm_component_utils(spi_sm_agent)

  uvm_analysis_port #(spi_seq_item) agent_sm_ap;
  spi_sm_driver driver;
  spi_sm_monitor monitor;
  spi_sm_sequencer sequencer;
  spi_sm_agent_config a_config;


  function new (string name = "spi_sm_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);

    if(!uvm_config_db #(spi_sm_agent_config)::get(this, "", "sm_agent_config", a_config)) begin
      `uvm_fatal(get_full_name(), "Can't get config for agent ms");
    end    

    if(a_config.mode == 1) begin 
    spi_sm_driver::type_id::set_type_override(spi_sm_driver_1::get_type());
    spi_sm_monitor::type_id::set_type_override(spi_sm_monitor_1::get_type());
    end

    if(a_config.active == 1) begin 
      driver = spi_sm_driver::type_id::create("driver", this);
      sequencer = spi_sm_sequencer::type_id::create("sequencer", this);
    end
   monitor = spi_sm_monitor::type_id::create("monitor", this);
  agent_sm_ap = new("agent_sm_ap", this);

  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    if(a_config.active == 1) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
    monitor.monitor_ap.connect(agent_sm_ap);

  endfunction : connect_phase

endclass

`endif
