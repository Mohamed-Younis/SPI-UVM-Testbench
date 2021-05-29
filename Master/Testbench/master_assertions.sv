module master_assertions #(parameter SPI_MODE = 0)(
   input        i_Rst_L,     
   input        i_Clk,       
   input [7:0]  i_TX_Byte,       
   input        i_TX_DV,         
   input       o_TX_Ready,     
   input       o_RX_DV,     
   input [7:0] o_RX_Byte,   
   input o_SPI_Clk,
   input  i_SPI_MISO,
   input o_SPI_MOSI,
   input o_SPI_CS_n
   );
//when reset is low the out signals are 0     note:o_SPI_Clk is checked in a seprate assertion
property reset_check;
  @(negedge i_Rst_L) 1'b1 |-> @(posedge i_Clk) (!o_TX_Ready && !o_RX_DV && o_RX_Byte == 0 && o_SPI_CS_n && !o_SPI_MOSI);
endproperty

//when the data valid is asserted the output ready is deasserted 
property DV_Ready;
  @(posedge i_Clk) disable iff (!i_Rst_L) i_TX_DV |-> !o_TX_Ready;
endproperty

//when their is innput data chip sellect goes low to start transmition
property DV_CS;
  @(posedge i_Clk) disable iff (!i_Rst_L) i_TX_DV |=> !o_SPI_CS_n;
endproperty

//when chip sellect goes low it stays low for 34 cycles and then goes up
property CS_low_for34cycles;
  @(posedge i_Clk) disable iff (!i_Rst_L) $fell(o_SPI_CS_n) |-> !o_SPI_CS_n [*34] ##1 o_SPI_CS_n ;
endproperty

//the sampled data is valid works at SPI_MODE 0 and 2
property CS_low_knownstate_02;
  @(posedge o_SPI_Clk ) disable iff (!i_Rst_L || (SPI_MODE == 1 || SPI_MODE == 3)) (!$isunknown(o_SPI_MOSI)&&!$isunknown(i_SPI_MISO)) ;
endproperty

//the sampled data is valid works at SPI_MODE 1 and 3
property CS_low_knownstate_13;
  @(negedge o_SPI_Clk ) disable iff (!i_Rst_L || (SPI_MODE == 0 || SPI_MODE == 2)) (!$isunknown(o_SPI_MOSI)&&!$isunknown(i_SPI_MISO)) ;
endproperty

//when chip sellect is low SPI clock switches 8 times during which cs will stay low
property SPI_CLK_8edges;
  @(posedge i_Clk ) disable iff (!i_Rst_L)  $fell(o_SPI_CS_n) |-> ($rose(o_SPI_Clk)[=8]) within (!o_SPI_CS_n [*34]);
endproperty

reset_check_assert: assert property(reset_check)
  else $error("Assertion reset_check failed!");

DV_Ready_assert: assert property(DV_Ready)
  else $error("Assertion DV_Ready failed!");

DV_CS_assert: assert property(DV_CS)
  else $error("Assertion DV_CS failed!");

CS_low_for34cycles_assert: assert property(CS_low_for34cycles)
  else $error("Assertion CS_low_for34cycles failed!");

CS_low_knownstate_02_assert: assert property(CS_low_knownstate_02)
  else $error("Assertion CS_low_knownstate_02 failed!");

CS_low_knownstate_13_assert: assert property(CS_low_knownstate_13)
  else $error("Assertion CS_low_knownstate_13 failed!");

SPI_CLK_8edges_assert: assert property(SPI_CLK_8edges)
  else $error("Assertion SPI_CLK_8edges failed!");

endmodule