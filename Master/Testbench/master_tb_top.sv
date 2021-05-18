module master_tb_top();
  import uvm_pkg::*;
  import spi_test_pkg::*;

  bit Clk;
  localparam mode = 0;

  spi_m_interface m_interface(Clk);
  spi_ms_interface ms_interface();

  SPI_Master_With_Single_CS #(.SPI_MODE(mode))dut  (
    .i_Clk(Clk),
    .i_Rst_L(m_interface.i_Rst_L),
    .i_TX_Count(2'd1),  
    .i_TX_Byte(m_interface.i_TX_Byte),       
    .i_TX_DV(m_interface.i_TX_DV),         
    .o_TX_Ready(m_interface.o_TX_Ready),      
    .o_RX_Count(),  
    .o_RX_DV(m_interface.o_RX_DV),     
    .o_RX_Byte(m_interface.o_RX_Byte),   
    .o_SPI_Clk(ms_interface.SPI_Clk),
    .i_SPI_MISO(ms_interface.SPI_MISO),
    .o_SPI_MOSI(ms_interface.SPI_MOSI),
    .o_SPI_CS_n(ms_interface.SPI_CS_n)
  );

  initial begin
    forever #5 Clk = !Clk;
  end
  initial begin
    uvm_config_db #(virtual spi_m_interface)::set(null, "uvm_test_top", "a_m_interface", m_interface);
    uvm_config_db #(virtual spi_ms_interface)::set(null, "uvm_test_top", "a_ms_interface", ms_interface);
    uvm_config_db #(int)::set(null, "uvm_test_top", "mode", mode);
  end

  initial begin
    run_test();
  end
endmodule