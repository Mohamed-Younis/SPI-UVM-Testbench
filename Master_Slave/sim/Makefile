all: lib sv sim

lib:
	vlib work

sv:
	vlog +incdir+../../Master/Master_interfaces ../../Master/Master_interfaces/spi_m_interface.sv ../../Slave/Slave_interfaces/spi_s_interface.sv ../../Master/Master_interfaces/spi_ms_interface.sv \
	+incdir+../Master_Slave_common_agent   ../Master_Slave_common_agent/spi_common_agent_pkg.sv \
	+incdir+../../Master/Master_agents/spi_m_agent ../../Master/Master_agents/spi_m_agent/spi_m_agent_pkg.sv \
	+incdir+../../Slave/Slave_agents/spi_s_agent ../../Slave/Slave_agents/spi_s_agent/spi_s_agent_pkg.sv \
	+incdir+../../Master/Master_agents/spi_ms_agent ../../Master/Master_agents/spi_ms_agent/spi_ms_agent_pkg.sv \
	+incdir+../Master_Slave_env ../Master_Slave_env/master_slave_spi_env_pkg.sv \
	+incdir+../Master_Slave_test ../Master_Slave_test/master_slave_spi_test_pkg.sv \
	../../Master/Dut/SPI_Master.v ../../Master/Dut/SPI_Master_With_Single_CS.v \
	../../Master/Testbench/master_assertions.sv \
	../../Slave/Dut/SPI_Slave.sv \
	../Testbench/master_slave_tb_top.sv

	vopt master_slave_tb_top -o master_slave_tb_top_opt

sim:
	vsim -c master_slave_tb_top_opt +UVM_TESTNAME=master_slave_spi_base_test +UVM_VERBOSITY=UVM_HIGH -do "run -all; quit -f"
