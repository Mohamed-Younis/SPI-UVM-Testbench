# SPI-UVM-Testbench
The target from this project is to verify the Spi_master and Spi_slave designed by nanland found in https://github.com/nandland.

Three different tesbenches have been used 
* Master testbench which is an environment to test the master module only.
* Slave testbench used to verify the slave module only.
* Master_Slave testbench that test both the master and the slave and the connections between them.

Note: The testbenches support only two modes of operation mode 0 and mode 1. The desired mode of operation can be sellected through the mode parameter found in each testbench top. To read about the differences between each mode https://www.analog.com/en/analog-dialogue/articles/introduction-to-spi-interface.html 

## Master testbench
![Picture1](https://user-images.githubusercontent.com/46727826/120229791-36596d00-c24e-11eb-881c-9e952ab72ce3.png)

## Slave testbench
![Picture2](https://user-images.githubusercontent.com/46727826/120229798-39ecf400-c24e-11eb-833d-0112a0605297.png)

## Master_Slave testbench 
![Picture3](https://user-images.githubusercontent.com/46727826/120229785-2fcaf580-c24e-11eb-89ce-baa0129d580f.png)

## Test results 
No major problems were found in the Master SPI, on the other hand, the Slave suffered from many issues. Follows are the list of bugs that have been found and there current status.

* Design: SPI_Master_With_Single_CS 

  * Bug discription: Output ready signal is active during reset.
    * Present at all modes.
    * Status: Design modified and bug fixed. 
    
* Design: SPI_Slave 

  * Bug description: The data is driven on the MISO line at the wrong edge.
    * Present at all modes.
    * Status: Design modified and bug fixed. 
    
  * Bug description: The output byte on the MISO line is shifted by one bit.
    * Present at mode 0.
    * Status: Design modified and bug fixed. 
    
  * Bug description: The signal r_Preload_MISO is driven at the wrong edge.
    * Present at mode 0.
    * Status: Design modified and bug fixed. 
    
## Simulation 
To run the simulation run the make file found in the sim folder in its respective testbench.
  
