`ifndef SPI_SEQ_ITEM
`define SPI_SEQ_ITEM

class spi_seq_item extends uvm_sequence_item;

	`uvm_object_utils(spi_seq_item)

	rand bit [7:0] data_m;
	rand bit [7:0] data_ms;

	function new ( string name = "spi_seq_item");
		super.new(name);
	endfunction

	function void do_copy( uvm_object rhs);
		spi_seq_item to_copy;
		if (!$cast(to_copy, rhs)) begin 
		`uvm_fatal("do_copy", "non matching transaction type");
		end
		super.do_copy(rhs);
		this.data_m  = to_copy.data_m;
		this.data_ms  = to_copy.data_ms;

	endfunction : do_copy

	function string convert2string();
		string s;
		$sformat(s, "%s \n", super.convert2string());
		$sformat(s, "%s \n data_m: %0h = %b \n data_ms: %0h = %b \n" ,
									s, data_m, data_m, data_ms, data_ms);
		return s;
	endfunction : convert2string

endclass
`endif 
