`ifndef SPI_SEQUENCE
`define SPI_SEQUENCE

class spi_sequence extends uvm_sequence #(spi_seq_item);

  `uvm_object_utils(spi_sequence)

  spi_seq_item trn;

  function new(string name = "spi_sequence");
    super.new(name);
  endfunction

  task body();
    trn = spi_seq_item::type_id::create("trn");  
    start_item(trn);
    if(!trn.randomize()) begin
      `uvm_error(get_full_name(), "Failed to randomize the seq item")
    end
    finish_item(trn);
  endtask


endclass

`endif