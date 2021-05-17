`ifndef SPI_M_DRIVER
`define SPI_M_DRIVER

`define D_M_IF m_driver_interface.driver_cb

class spi_m_driver extends uvm_driver #(spi_seq_item);

  `uvm_component_utils(spi_m_driver)

  spi_seq_item trn;
  virtual spi_m_interface.driver_mp m_driver_interface;
  spi_m_agent_config m_agent_config;

  function new(string name = "spi_m_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    if(!uvm_config_db #(spi_m_agent_config)::get(this, "", "m_agent_config", m_agent_config)) begin
      `uvm_fatal(get_full_name(), "Failed to get the agent m config object")
    end
    m_driver_interface = m_agent_config.m_interface;
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    do_reset();

    forever begin
      seq_item_port.get_next_item(trn);
      forever begin
        @(posedge `D_M_IF);
        if(`D_M_IF.o_TX_Ready) begin
          `uvm_info(get_full_name(),$sformatf("\ndata_m  = %h \n", trn.data_m), UVM_HIGH)
          `D_M_IF.i_TX_DV <= 1;
          `D_M_IF.i_TX_Byte <= trn.data_m;
          @(posedge `D_M_IF);
          break;
        end
      end
      seq_item_port.item_done(trn);
      `D_M_IF.i_TX_DV <= 0;
    end
  endtask : run_phase

  task do_reset();
    m_driver_interface.i_Rst_L = 0;
    `D_M_IF.i_TX_DV <= 0;
    `D_M_IF.i_TX_Byte <= 0;
    repeat(2)
      @(m_driver_interface.i_Clk);
    m_driver_interface.i_Rst_L = 1;
    
  endtask : do_reset

endclass

`endif