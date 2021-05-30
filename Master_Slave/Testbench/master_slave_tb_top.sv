module master_slave_tb_top();
  import uvm_pkg::*;
  import master_slave_spi_test_pkg::*;

  bit Clk;
  parameter mode = 1;

  spi_m_interface m_interface(Clk);
  spi_s_interface s_interface(Clk);
  spi_ms_interface ms_interface();

  SPI_Master_With_Single_CS #(.SPI_MODE(mode))m_dut  (
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

  SPI_Slave #(.SPI_MODE(mode))s_dut  (
    .i_Rst_L(s_interface.i_Rst_L),   
    .i_Clk(Clk), 
    .o_RX_DV(s_interface.o_RX_DV),   
    .o_RX_Byte(s_interface.o_RX_Byte),  
    .i_TX_DV(s_interface.i_TX_DV),    
    .i_TX_Byte(s_interface.i_TX_Byte), 
    .i_SPI_Clk(ms_interface.SPI_Clk),
    .o_SPI_MISO(ms_interface.SPI_MISO),
    .i_SPI_MOSI(ms_interface.SPI_MOSI),
    .i_SPI_CS_n(ms_interface.SPI_CS_n)
  );

  bind m_dut master_assertions #(.SPI_MODE(SPI_MODE)) dut_assert (.*);

  initial begin
    forever #5 Clk = !Clk;
  end
  initial begin
    uvm_config_db #(virtual spi_s_interface)::set(null, "uvm_test_top", "a_s_interface", s_interface);
    uvm_config_db #(virtual spi_m_interface)::set(null, "uvm_test_top", "a_m_interface", m_interface);
    uvm_config_db #(virtual spi_ms_interface)::set(null, "uvm_test_top", "a_ms_interface", ms_interface);
    uvm_config_db #(int)::set(null, "uvm_test_top", "mode", mode);
  end

  initial begin
    $dumpfile ("dut_signals.vcd");
    $dumpvars (1, m_dut.i_Clk,
                  m_dut.i_Rst_L,
                  m_dut.i_TX_Count, 
                  m_dut.i_TX_Byte,
                  m_dut.i_TX_DV, 
                  m_dut.o_TX_Ready,
                  m_dut.o_RX_Count,  
                  m_dut.o_RX_DV,     
                  m_dut.o_RX_Byte,   
                  m_dut.o_SPI_Clk,
                  m_dut.i_SPI_MISO,
                  m_dut.o_SPI_MOSI,
                  m_dut.o_SPI_CS_n);
    $dumpvars (1, s_dut.i_Rst_L,   
                  s_dut.i_Clk, 
                  s_dut.o_RX_DV,   
                  s_dut.o_RX_Byte,  
                  s_dut.i_TX_DV,    
                  s_dut.i_TX_Byte, 
                  s_dut.i_SPI_Clk,
                  s_dut.o_SPI_MISO,
                  s_dut.i_SPI_MOSI,
                  s_dut.i_SPI_CS_n
  );
  end

  initial begin
    run_test();
  end
endmodule