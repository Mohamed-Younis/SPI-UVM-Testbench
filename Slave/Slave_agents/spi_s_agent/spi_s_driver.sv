`ifndef SPI_S_DRIVER
`define SPI_S_DRIVER

`define D_S_IF s_driver_interface.driver_cb

class spi_s_driver extends uvm_driver #(spi_seq_item);

  `uvm_component_utils(spi_s_driver)

  spi_seq_item trn;
  virtual spi_s_interface.driver_mp s_driver_interface;
  spi_s_agent_config s_agent_config;

  function new(string name = "spi_s_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(spi_s_agent_config)::get(this, "", "s_agent_config", s_agent_config)) begin
      `uvm_fatal(get_full_name(), "Failed to get the agent m config object")
    end
    s_driver_interface = s_agent_config.s_interface;
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    do_reset();

    forever begin
      seq_item_port.get_next_item(trn);
      @(`D_S_IF);
      `uvm_info(get_full_name(),$sformatf("\ndata_s  = %h \n", trn.data_s), UVM_HIGH)
      `D_S_IF.i_TX_DV <= 1;
      `D_S_IF.i_TX_Byte <= trn.data_s;
      @(`D_S_IF);
      seq_item_port.item_done(trn);
      `D_S_IF.i_TX_DV <= 0;
      wait(`D_S_IF.o_RTX_DV);
    end
  endtask : run_phase

  task do_reset();
    s_driver_interface.i_Rst_L = 0;
    `D_S_IF.i_TX_DV <= 0;
    `D_S_IF.i_TX_Byte <= 0;
    repeat(2)
      @(`D_S_IF);
    s_driver_interface.i_Rst_L = 1;
    
  endtask : do_reset

endclass

`endif