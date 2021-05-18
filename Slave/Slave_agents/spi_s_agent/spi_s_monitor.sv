`ifndef SPI_S_MONITOR
`define SPI_S_MONITOR

`define M_S_IF s_monitor_interface.monitor_cb


class spi_s_monitor extends uvm_monitor;

  `uvm_component_utils(spi_s_monitor)

  uvm_analysis_port #(spi_seq_item) monitor_ap;
  spi_s_agent_config s_agent_config;
  virtual spi_s_interface.monitor_mp s_monitor_interface;
  spi_seq_item trn;

  function new(string name = "spi_s_monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    monitor_ap = new("monitor_ap", this);
    if(!uvm_config_db #(spi_s_agent_config)::get(this, "", "s_agent_config", s_agent_config)) begin
      `uvm_fatal(get_full_name(), "Failed to get the agent s config object")
    end
    s_monitor_interface = s_agent_config.s_interface;
  endfunction : build_phase

  task run_phase(uvm_phase phase);
  forever begin
    trn = spi_seq_item::type_id::create("trn");
    forever begin
      @(posedge `M_S_IF)
      if(`M_S_IF.i_TX_DV ) begin
      trn.data_s = `M_S_IF.i_TX_Byte;
      end 
      if(`M_S_IF.o_RX_DV) begin
      trn.data_sm = `M_S_IF.o_RX_Byte;
      break;
      end 
    end
    `uvm_info(get_full_name(),trn.convert2string(), UVM_HIGH)
    monitor_ap.write(trn);

  end

  endtask : run_phase
endclass 


`endif