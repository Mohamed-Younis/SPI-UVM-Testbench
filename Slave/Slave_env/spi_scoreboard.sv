`ifndef SPI_SCOREBOARD
`define SPI_SCOREBOARD

class spi_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(spi_scoreboard)
  uvm_tlm_analysis_fifo #(spi_seq_item) s_trn_fifo;
  uvm_tlm_analysis_fifo #(spi_seq_item) sm_trn_fifo;
  spi_seq_item s_trn_item;
  spi_seq_item sm_trn_item;

  function new(string name = "spi_scoreboard", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    s_trn_fifo = new("s_trn_fifo", this);  
    sm_trn_fifo = new("sm_trn_fifo", this);  
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      s_trn_fifo.get(s_trn_item);
      `uvm_info(get_full_name(),$sformatf("m_trn: \n %s",s_trn_item.convert2string()), UVM_FULL)
      sm_trn_fifo.get(sm_trn_item);
      `uvm_info(get_full_name(),$sformatf("ms_trn: \n %s",sm_trn_item.convert2string()), UVM_FULL)

      if(s_trn_item.compare(sm_trn_item))begin
        `uvm_info(get_full_name(), "Transactions match passed", UVM_HIGH)
      end 
      else begin
        `uvm_error(get_full_name(), "Transactions match failed")
      end
    end
  endtask
    
endclass
`endif 