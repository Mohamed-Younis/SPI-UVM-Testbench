`ifndef SPI_Ms_AGENT_CONFIG
`define SPI_Ms_AGENT_CONFIG

class spi_ms_agent_config extends uvm_object;

  `uvm_object_utils(spi_ms_agent_config)

  bit active = 1;
  int mode = 0;
  virtual spi_ms_interface ms_interface;

  function new (string name = "spi_ms_agent_config");
    super.new(name);
  endfunction : new

endclass 

`endif 
