`ifndef SPI_SM_MONITOR_1
`define SPI_SM_MONITOR_1

`define M_SM_IF_1 sm_monitor_interface_1.monitor_cb_1


class spi_sm_monitor_1 extends spi_sm_monitor;

  `uvm_component_utils(spi_sm_monitor_1)

  virtual spi_sm_interface.monitor_mp_1 sm_monitor_interface_1;


  function new(string name = "spi_sm_monitor_1", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sm_monitor_interface_1 = sm_agent_config.sm_interface;
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    forever begin
      trn = spi_seq_item::type_id::create("trn");
      wait(!sm_monitor_interface_1.SPI_CS_n);
      #1 //negedge happends right after the cs is low 
      fork
        foreach(trn.data_sm[i]) begin
          @(`M_SM_IF_1);
          trn.data_sm[i] = `M_SM_IF_1.SPI_MOSI;
        end
        foreach(trn.data_s[i]) begin
          @(`M_SM_IF_1)
          trn.data_s[i] = `M_SM_IF_1.SPI_MISO;
        end
      join
      `uvm_info(get_full_name(),trn.convert2string(), UVM_HIGH)
      monitor_ap.write(trn);

     wait(sm_monitor_interface_1.SPI_CS_n);
    end
  endtask : run_phase
endclass 


`endif