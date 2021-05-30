`ifndef MASTER_SLAVE_SPI_SCOREBOARD
`define MASTER_SLAVE_SPI_SCOREBOARD

class master_slave_spi_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(master_slave_spi_scoreboard)
  uvm_tlm_analysis_fifo #(spi_seq_item) m_trn_fifo;
  uvm_tlm_analysis_fifo #(spi_seq_item) s_trn_fifo;
  uvm_tlm_analysis_fifo #(spi_seq_item) ms_trn_fifo;
  spi_seq_item m_trn_item;
  spi_seq_item s_trn_item;
  spi_seq_item ms_trn_item;

  function new(string name = "master_slave_spi_scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    m_trn_fifo = new("m_trn_fifo", this);  
    s_trn_fifo = new("s_trn_fifo", this);  
    ms_trn_fifo = new("ms_trn_fifo", this);  
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      m_trn_fifo.get(m_trn_item);
      `uvm_info(get_full_name(),$sformatf("m_trn: \n data_m = %h data_ms = %h \n",m_trn_item.data_m,m_trn_item.data_ms), UVM_FULL)
      s_trn_fifo.get(s_trn_item);
      `uvm_info(get_full_name(),$sformatf("s_trn: \n data_s = %h data_sm = %h \n",s_trn_item.data_s,s_trn_item.data_sm), UVM_FULL)
      ms_trn_fifo.get(ms_trn_item);
      `uvm_info(get_full_name(),$sformatf("ms_trn: \n data_ms = %h data_sm = %h \n",ms_trn_item.data_m,ms_trn_item.data_ms), UVM_FULL)

      if(m_trn_item.data_m == s_trn_item.data_sm  &&
         s_trn_item.data_sm == ms_trn_item.data_m &&
         m_trn_item.data_ms == s_trn_item.data_s  &&
         s_trn_item.data_s == ms_trn_item.data_ms  )begin
        `uvm_info(get_full_name(), "Transactions match passed", UVM_HIGH)
      end 
      else begin
        `uvm_error(get_full_name(), "Transactions match failed")
      end
    end
  endtask
    
endclass
`endif 