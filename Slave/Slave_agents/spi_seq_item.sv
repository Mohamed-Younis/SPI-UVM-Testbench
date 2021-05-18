`ifndef SPI_SEQ_ITEM
`define SPI_SEQ_ITEM

class spi_seq_item extends uvm_sequence_item;

	`uvm_object_utils(spi_seq_item)

	rand bit [7:0] data_s;
	rand bit [7:0] data_sm;

	function new ( string name = "spi_seq_item");
		super.new(name);
	endfunction

	function void do_copy( uvm_object rhs);
		spi_seq_item to_copy;
		if (!$cast(to_copy, rhs)) begin 
		`uvm_fatal(get_full_name(), "non matching transaction type");
		end
		super.do_copy(rhs);
		this.data_s  = to_copy.data_s;
		this.data_sm  = to_copy.data_sm;

	endfunction : do_copy

  function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    spi_seq_item to_compare;
    if (!$cast(to_compare, rhs)) begin
      return 0;
    end
    return (super.do_compare(rhs, comparer) &&
            this.data_s == to_compare.data_s &&
            this.data_sm == to_compare.data_sm
            );
  endfunction

	function string convert2string();
		string s;
		$sformat(s, "%s \n", super.convert2string());
		$sformat(s, "%s \n data_s:  %h  \n data_sm: %h \n" ,
									s, data_s, data_sm);
		return s;
	endfunction : convert2string

endclass
`endif 
