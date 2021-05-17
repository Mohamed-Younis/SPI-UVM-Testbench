`ifndef SPI_M_MONITOR
`define SPI_M_MONITOR

`define M_M_IF m_monitor_interface.monitor_cb


class spi_m_monitor extends uvm_monitor;

  `uvm_component_utils(spi_m_monitor)

  uvm_analysis_port #(spi_seq_item) monitor_ap;
  spi_m_agent_config m_agent_config;
  virtual spi_m_interface.monitor_mp m_monitor_interface;
  spi_seq_item trn;

  function new(string name = "spi_m_monitor", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    monitor_ap = new("monitor_ap", this);
    if(!uvm_config_db #(spi_m_agent_config)::get(this, "", "m_agent_config", m_agent_config)) begin
      `uvm_fatal(get_full_name(), "Failed to get the agent m config object")
    end
    m_monitor_interface = m_agent_config.m_interface;
  endfunction : build_phase

  task run_phase(uvm_phase phase);
  forever begin
    trn = spi_seq_item::type_id::create("trn");
    forever begin
      @(posedge `M_M_IF)
      if(`M_M_IF.i_TX_DV ) begin
      trn.data_m = `M_M_IF.i_TX_Byte;
      end 
      if(`M_M_IF.o_RX_DV) begin
      trn.data_ms = `M_M_IF.o_RX_Byte;
      break;
      end 
    end
    `uvm_info(get_full_name(),trn.convert2string(), UVM_HIGH)
    monitor_ap.write(trn);

  end

  endtask : run_phase
endclass 


`endif