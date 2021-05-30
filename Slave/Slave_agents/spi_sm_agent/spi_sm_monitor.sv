`ifndef SPI_SM_MONITOR
`define SPI_SM_MONITOR

`define M_SM_IF sm_monitor_interface.monitor_cb


class spi_sm_monitor extends uvm_monitor;

  `uvm_component_utils(spi_sm_monitor)

  uvm_analysis_port #(spi_seq_item) monitor_ap;
  spi_sm_agent_config sm_agent_config;
  virtual spi_sm_interface.monitor_mp sm_monitor_interface;
  spi_seq_item trn;

  function new(string name = "spi_sm_monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    monitor_ap = new("monitor_ap", this);
    if(!uvm_config_db #(spi_sm_agent_config)::get(this, "", "sm_agent_config", sm_agent_config)) begin
      `uvm_fatal(get_full_name(), "Failed to get the agent ms config object")
    end
    sm_monitor_interface = sm_agent_config.sm_interface;
  endfunction : build_phase

  task run_phase(uvm_phase phase);
    forever begin
      trn = spi_seq_item::type_id::create("trn");
      wait(!sm_monitor_interface.SPI_CS_n);
      fork
        foreach(trn.data_sm[i]) begin
          @(sm_monitor_interface.monitor_cb);
          trn.data_sm[i] = `M_SM_IF.SPI_MOSI;
        end
        foreach(trn.data_s[i]) begin
          @(sm_monitor_interface.monitor_cb);
          trn.data_s[i] = `M_SM_IF.SPI_MISO;
        end
      join
      `uvm_info(get_full_name(),trn.convert2string(), UVM_HIGH)
      monitor_ap.write(trn);

     wait(sm_monitor_interface.SPI_CS_n);
    end
  endtask : run_phase
endclass 


`endif