`ifndef SPI_S_AGENT_CONFIG
`define SPI_S_AGENT_CONFIG

class spi_s_agent_config extends uvm_object;

  `uvm_object_utils(spi_s_agent_config)

  bit active = 1;
  virtual spi_s_interface s_interface;

  function new (string name = "spi_s_agent_config");
    super.new(name);
  endfunction : new

endclass 

`endif 
