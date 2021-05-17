all: lib sv sim

lib:
	vlib work

sv:
	vlog +incdir+../Master_interfaces ../Master_interfaces/spi_m_interface.sv ../Master_interfaces/spi_ms_interface.sv \
	+incdir+../Master_agents   ../Master_agents/spi_common_agent_pkg.sv \
	+incdir+../Master_agents/spi_m_agent ../Master_agents/spi_m_agent/spi_m_agent_pkg.sv \
	+incdir+../Master_agents/spi_ms_agent ../Master_agents/spi_ms_agent/spi_ms_agent_pkg.sv \
	+incdir+../Master_env ../Master_env/spi_env_pkg.sv \
	+incdir+../Master_test ../Master_test/spi_test_pkg.sv \
	../Dut/SPI_Master.v ../Dut/SPI_Master_With_Single_CS.v \
	../Testbench/master_tb_top.sv

	vopt master_tb_top -o master_tb_top_opt

sim:
	vsim -c master_tb_top_opt +UVM_TESTNAME=spi_base_test +UVM_VERBOSITY=UVM_HIGH -do "run -all; quit -f"
