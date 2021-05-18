`ifndef SPI_MS_MONITOR_1
`define SPI_MS_MONITOR_1

`define M_MS_IF_1 ms_monitor_interface_1.monitor_cb_1


class spi_ms_monitor_1 extends spi_ms_monitor;

  `uvm_component_utils(spi_ms_monitor_1)

  virtual spi_ms_interface.monitor_mp_1 ms_monitor_interface_1;


  function new(string name = "spi_ms_monitor_1", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ms_monitor_interface_1 = ms_agent_config.ms_interface;
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    forever begin
      trn = spi_seq_item::type_id::create("trn");
      wait(!ms_monitor_interface_1.SPI_CS_n);
      fork
        foreach(trn.data_m[i]) begin
          @(ms_monitor_interface_1.monitor_cb_1);
          trn.data_m[i] = `M_MS_IF_1.SPI_MOSI;
        end
        foreach(trn.data_ms[i]) begin
          @(ms_monitor_interface_1.monitor_cb_1);
          trn.data_ms[i] = `M_MS_IF_1.SPI_MISO;
        end
      join
      `uvm_info(get_full_name(),trn.convert2string(), UVM_HIGH)
      monitor_ap.write(trn);

     wait(ms_monitor_interface_1.SPI_CS_n);
    end
  endtask : run_phase
endclass 


`endif