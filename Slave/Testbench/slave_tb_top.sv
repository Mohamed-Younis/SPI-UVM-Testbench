module slave_tb_top();
  import uvm_pkg::*;
  import spi_test_pkg::*;

  bit Clk;
  parameter mode = 0;

  spi_s_interface s_interface(Clk);
  spi_sm_interface sm_interface();

  SPI_Slave #(.SPI_MODE(mode))dut  (
  .i_Rst_L(s_interface.i_Rst_L),   
  .i_Clk(Clk), 
  .o_RX_DV(s_interface.o_RX_DV),   
  .o_RX_Byte(s_interface.o_RX_Byte),  
  .i_TX_DV(s_interface.i_TX_DV),    
  .i_TX_Byte(s_interface.i_TX_Byte), 
  .i_SPI_Clk(sm_interface.SPI_Clk),
  .o_SPI_MISO(sm_interface.SPI_MISO),
  .i_SPI_MOSI(sm_interface.SPI_MOSI),
  .i_SPI_CS_n(sm_interface.SPI_CS_n)
  );

  initial begin
    forever #5 Clk = !Clk;
  end
  initial begin
    uvm_config_db #(virtual spi_s_interface)::set(null, "uvm_test_top", "a_s_interface", s_interface);
    uvm_config_db #(virtual spi_sm_interface)::set(null, "uvm_test_top", "a_sm_interface", sm_interface);
    uvm_config_db #(int)::set(null, "uvm_test_top", "mode", mode);
  end

  initial begin
    $dumpfile ("dut_signals.vcd");
    $dumpvars (1, dut.i_Rst_L,   
                  dut.i_Clk, 
                  dut.o_RX_DV,   
                  dut.o_RX_Byte,  
                  dut.i_TX_DV,    
                  dut.i_TX_Byte, 
                  dut.i_SPI_Clk,
                  dut.o_SPI_MISO,
                  dut.i_SPI_MOSI,
                  dut.i_SPI_CS_n
  );
  end

  initial begin
    run_test();
  end
endmodule