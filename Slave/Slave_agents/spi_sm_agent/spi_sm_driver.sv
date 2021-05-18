`ifndef SPI_SM_DRIVER
`define SPI_SM_DRIVER

`define D_SM_IF sm_driver_interface.driver_mp.driver_cb

class spi_sm_driver extends uvm_driver #(spi_seq_item);

  `uvm_component_utils(spi_sm_driver)

  spi_seq_item trn;
  virtual spi_sm_interface sm_driver_interface;
  spi_sm_agent_config sm_agent_config;
  bit generated_SPI_Clk;

  function new(string name = "spi_sm_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(spi_sm_agent_config)::get(this, "", "sm_agent_config", sm_agent_config)) begin
      `uvm_fatal(get_full_name(), "Failed to get the agent ms config object")
    end
    sm_driver_interface = sm_agent_config.sm_interface;
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(trn);
      sm_driver_interface.SPI_MISO <= trn.data_sm[7]; // preload the first bit since the first in mood0 edge is the sampling edge
      wait(!sm_driver_interface.SPI_CS_n)
      `uvm_info(get_full_name(),$sformatf("\ndata_sm = %h \n", trn.data_sm), UVM_HIGH)
      for (int i = 6; i >= 0; i--) begin
        @(`D_SM_IF)
        `D_SM_IF.SPI_MISO <= trn.data_sm[i];
      end
      wait(sm_driver_interface.SPI_CS_n)
      seq_item_port.item_done(trn);
    end

  endtask 


endclass

`endif