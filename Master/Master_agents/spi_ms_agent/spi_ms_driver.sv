`ifndef SPI_MS_DRIVER
`define SPI_MS_DRIVER

`define D_MS_IF ms_driver_interface.driver_mp.driver_cb

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

  task run_phase(uvm_phase phase);
    //#1 // the SPI_CS_n signal start 0 at time 0 so we wait for it to change 
    forever begin
      seq_item_port.get_next_item(trn);
      ms_driver_interface.SPI_MISO <= trn.data_ms[7];
      wait(!ms_driver_interface.SPI_CS_n)
      `uvm_info(get_full_name(),$sformatf("\ndata_ms = %h \n", trn.data_ms), UVM_HIGH)
      for (int i = 6; i >= 0; i--) begin
        @(`D_MS_IF)
        `D_MS_IF.SPI_MISO <= trn.data_ms[i];
      end
      @(negedge ms_driver_interface.SPI_Clk)
      wait(ms_driver_interface.SPI_CS_n)
      seq_item_port.item_done(trn);
    end

  endtask 


endclass

`endif