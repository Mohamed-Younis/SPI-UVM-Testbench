`ifndef SPI_MS_DRIVER
`define SPI_MS_DRIVER

class spi_ms_driver extends uvm_driver #(spi_seq_item);

  `uvm_component_utils(spi_ms_driver)

  spi_seq_item trn;
  virtual spi_ms_interface ms_driver_interface;
  spi_ms_agent_config ms_agent_config;

  function new(string name = "spi_ms_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(spi_ms_agent_config)::get(this, "", "ms_agent_config", ms_agent_config)) begin
      `uvm_fatal(get_full_name(), "Failed to get the agent ms config object")
    end
    ms_driver_interface = ms_agent_config.ms_interface;
  endfunction : build_phase




endclass

`endif