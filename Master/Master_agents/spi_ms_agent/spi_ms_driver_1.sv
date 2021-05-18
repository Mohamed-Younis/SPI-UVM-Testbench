`ifndef SPI_MS_DRIVER_1
`define SPI_MS_DRIVER_1

`define D_MS_IF_1 ms_driver_1_interface.driver_cb_1

class spi_ms_driver_1 extends spi_ms_driver;

  `uvm_component_utils(spi_ms_driver_1)

  virtual spi_ms_interface.driver_mp_1 ms_driver_1_interface;


  function new(string name = "spi_ms_driver_1", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
    ms_driver_1_interface = ms_agent_config.ms_interface;
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    //#1 // the SPI_CS_n signal start 0 at time 0 so we wait for it to change 
    forever begin
      seq_item_port.get_next_item(trn);
      wait(!ms_driver_1_interface.SPI_CS_n)
      `uvm_info(get_full_name(),$sformatf("\ndata_ms = %h \n", trn.data_ms), UVM_HIGH)
      for (int i = 7; i >= 0; i--) begin
        @(`D_MS_IF_1)
        `D_MS_IF_1.SPI_MISO <= trn.data_ms[i];
      end
      wait(ms_driver_1_interface.SPI_CS_n)
      seq_item_port.item_done(trn);
    end

  endtask 


endclass

`endif