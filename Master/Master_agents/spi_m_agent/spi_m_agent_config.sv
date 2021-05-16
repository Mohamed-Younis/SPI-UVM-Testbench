`ifndef SPI_M_AGENT_CONFIG
`define SPI_M_AGENT_CONFIG

class spi_m_agent_config extends uvm_object;

  `uvm_object_utils(spi_m_agent_config)

  bit active = 1;
  virtual spi_m_interface m_interface;

  function new (string name = "spi_m_agent_config");
    super.new(name);
  endfunction : new

endclass 

`endif 
