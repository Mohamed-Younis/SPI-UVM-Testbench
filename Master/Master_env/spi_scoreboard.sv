`ifndef SPI_SCOREBOARD
`define SPI_SCOREBOARD

class spi_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(spi_scoreboard)
  uvm_tlm_analysis_fifo #(spi_seq_item) m_trn_fifo;
  uvm_tlm_analysis_fifo #(spi_seq_item) ms_trn_fifo;
  spi_seq_item m_trn_item;
  spi_seq_item ms_trn_item;

  function new(string name = "spi_scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    m_trn_fifo = new("m_trn_fifo", this);  
    ms_trn_fifo = new("ms_trn_fifo", this);  
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      m_trn_fifo.get(m_trn_item);
      `uvm_info(get_full_name(),$sformatf("m_trn: \n %s",m_trn_item.convert2string()), UVM_FULL)
      ms_trn_fifo.get(ms_trn_item);
      `uvm_info(get_full_name(),$sformatf("ms_trn: \n %s",ms_trn_item.convert2string()), UVM_FULL)

      if(m_trn_item.compare(ms_trn_item))begin
        `uvm_info(get_full_name(), "Transactions match passed", UVM_HIGH)
      end 
      else begin
        `uvm_error(get_full_name(), "Transactions match failed")
      end
    end
  endtask
    
endclass
`endif 