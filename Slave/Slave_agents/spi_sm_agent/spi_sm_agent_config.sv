`ifndef SPI_SM_AGENT_CONFIG
`define SPI_SM_AGENT_CONFIG

class spi_sm_agent_config extends uvm_object;

  `uvm_object_utils(spi_sm_agent_config)

  bit active = 1;
  int mode = 0;
  virtual spi_sm_interface sm_interface;

  function new (string name = "spi_sm_agent_config");
    super.new(name);
  endfunction : new

endclass 

`endif 
