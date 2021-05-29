all: lib sv sim

lib:
	vlib work

sv:
	vlog +incdir+../Slave_interfaces ../Slave_interfaces/spi_s_interface.sv ../Slave_interfaces/spi_sm_interface.sv \
	+incdir+../Slave_agents   ../Slave_agents/spi_common_agent_pkg.sv \
	+incdir+../Slave_agents/spi_s_agent ../Slave_agents/spi_s_agent/spi_s_agent_pkg.sv \
	+incdir+../Slave_agents/spi_sm_agent ../Slave_agents/spi_sm_agent/spi_sm_agent_pkg.sv \
	+incdir+../Slave_env ../Slave_env/spi_env_pkg.sv \
	+incdir+../Slave_test ../Slave_test/spi_test_pkg.sv \
	../Dut/SPI_Slave.sv \
	../Testbench/slave_tb_top.sv

	vopt slave_tb_top -o slave_tb_top_opt

sim:
	vsim -c slave_tb_top_opt +UVM_TESTNAME=spi_base_test +UVM_VERBOSITY=UVM_HIGH -do "run -all; quit -f"
