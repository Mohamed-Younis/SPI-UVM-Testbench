interface spi_m_interface (input logic i_Clk );

  logic i_Rst_L;     

  logic o_TX_Ready;       // Transmit Ready for next byte

  // TX (MOSI) Signals
  logic [7:0]  i_TX_Byte;        // Byte to transmit on MOSI
  logic i_TX_DV;          // Data Valid Pulse with i_TX_Byte

  logic [7:0] o_RX_Byte;   // Byte received on MISO
  logic o_RX_DV;     // Data Valid pulse (1 clock cycle)

  clocking driver_cb @(posedge i_Clk);
    default input #1 output #1;
    output i_TX_Byte;
    output i_TX_DV;
    input o_TX_Ready;
    input o_RX_Byte;
    input o_RX_DV;
  endclocking

  clocking monitor_cb @(posedge i_Clk);
    default input #1 output #1;
    input i_TX_Byte;
    input i_TX_DV;
    input o_TX_Ready;
    input o_RX_Byte;
    input o_RX_DV;
  endclocking

  modport driver_mp ( clocking driver_cb, input i_Rst_L, i_Clk );
  modport monitor_mp ( clocking monitor_cb, input i_Rst_L, i_Clk );
endinterface