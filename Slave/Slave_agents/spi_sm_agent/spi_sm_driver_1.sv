`ifndef SPI_SM_DRIVER_1
`define SPI_SM_DRIVER_1

`define D_SM_IF_1 sm_driver_1_interface.driver_mp_1.driver_cb_1

class spi_sm_driver_1 extends spi_sm_driver;

  `uvm_component_utils(spi_sm_driver_1)

  virtual spi_sm_interface sm_driver_1_interface;


  function new(string name = "spi_sm_driver_1", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
  super.build_phase(phase);
    sm_driver_1_interface = sm_agent_config.sm_interface;
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    sm_driver_1_interface.SPI_Clk = 0;
    sm_driver_1_interface.SPI_CS_n = 1;
    forever begin
      sm_driver_1_interface.SPI_Clk = 0;
      #100;
      sm_driver_1_interface.SPI_CS_n = 0;
      seq_item_port.get_next_item(trn);
      fork begin
        #10;
        forever begin
          #20 sm_driver_1_interface.SPI_Clk = !sm_driver_1_interface.SPI_Clk;
        end
      end
      join_none
      `uvm_info(get_full_name(),$sformatf("\ndata_sm = %h \n", trn.data_sm), UVM_HIGH)
      for (int i = 7; i >= 0; i--) begin
        @(`D_SM_IF_1)
        `D_SM_IF_1.SPI_MOSI <= trn.data_sm[i];
      end
      @(`D_SM_IF_1)
      #10;
      sm_driver_1_interface.SPI_CS_n = 1;
      disable fork;
      seq_item_port.item_done(trn);
    end

  endtask 


endclass

`endif