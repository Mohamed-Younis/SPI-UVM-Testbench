`ifndef SPI_MS_MONITOR
`define SPI_MS_MONITOR

`define M_MS_IF ms_monitor_interface.monitor_cb


class spi_ms_monitor extends uvm_monitor;

  `uvm_component_utils(spi_ms_monitor)

  uvm_analysis_port #(spi_seq_item) monitor_ap;
  spi_ms_agent_config ms_agent_config;
  virtual spi_ms_interface.monitor_mp ms_monitor_interface;
  spi_seq_item trn;

  function new(string name = "spi_ms_monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    monitor_ap = new("monitor_ap", this);
    if(!uvm_config_db #(spi_ms_agent_config)::get(this, "", "ms_agent_config", ms_agent_config)) begin
      `uvm_fatal(get_full_name(), "Failed to get the agent ms config object")
    end
    ms_monitor_interface = ms_agent_config.ms_interface;
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    forever begin
      trn = spi_seq_item::type_id::create("trn");
      wait(!ms_monitor_interface.SPI_CS_n);
      fork
        foreach(trn.data_m[i]) begin
          @(ms_monitor_interface.monitor_cb);
          trn.data_m[i] = `M_MS_IF.SPI_MOSI;
        end
        foreach(trn.data_ms[i]) begin
          @(ms_monitor_interface.monitor_cb);
          trn.data_ms[i] = `M_MS_IF.SPI_MISO;
        end
      join
      `uvm_info(get_full_name(),trn.convert2string(), UVM_HIGH)
      monitor_ap.write(trn);

     wait(ms_monitor_interface.SPI_CS_n);
    end
  endtask : run_phase
endclass 


`endif