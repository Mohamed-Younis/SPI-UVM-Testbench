interface spi_sm_interface();

  // SPI Interface
  logic SPI_Clk;
  logic SPI_MISO;
  logic SPI_MOSI;
  logic SPI_CS_n;


  clocking driver_cb @(negedge SPI_Clk);
    default input #1 output #1;
    input SPI_MISO;
    output SPI_MOSI;
  endclocking

  clocking driver_cb_1 @(posedge SPI_Clk);
    default input #1 output #1;
    input SPI_MISO;
    output SPI_MOSI;
  endclocking

  clocking monitor_cb @(posedge SPI_Clk);
    default input #1 output #1;
    input SPI_MISO;
    input SPI_MOSI;
  endclocking

    clocking monitor_cb_1 @(negedge SPI_Clk);
    default input #1 output #1;
    input SPI_MISO;
    input SPI_MOSI;
  endclocking

  modport driver_mp ( clocking driver_cb, output SPI_CS_n);
  modport driver_mp_1 ( clocking driver_cb_1, output SPI_CS_n);
  modport monitor_mp ( clocking monitor_cb, input SPI_CS_n);
  modport monitor_mp_1 ( clocking monitor_cb_1, input SPI_CS_n);
endinterface