`ifndef SPI_BASE_TEST
`define SPI_BASE_TEST

class spi_base_test extends uvm_test;

  `uvm_component_utils(spi_base_test)

  spi_env env; 
  spi_m_agent_config a_m_config;
  spi_ms_agent_config a_ms_config;
  spi_sequence seq_m;
  spi_sequence seq_ms;

  function new(string name = "spi_base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    seq_m = spi_sequence::type_id::create("seq_m");
    seq_ms = spi_sequence::type_id::create("seq_ms");
    a_m_config = spi_m_agent_config::type_id::create("a_m_config", this);
    a_ms_config = spi_ms_agent_config::type_id::create("a_ms_config", this);
    env = spi_env::type_id::create("env", this);
    
    if(!uvm_config_db #(virtual spi_m_interface)::get(this, "", "a_m_interface", a_m_config.m_interface))begin
      `uvm_fatal(get_full_name(), "couldn't get the a_m_interface from top")
    end
    uvm_config_db #(spi_m_agent_config)::set(this, "env.m_agent*", "m_agent_config",a_m_config);

    if(!uvm_config_db #(virtual spi_ms_interface)::get(this, "", "a_ms_interface", a_ms_config.ms_interface))begin
      `uvm_fatal(get_full_name(), "couldn't get the a_ms_interface from top")
    end
    uvm_config_db #(spi_ms_agent_config)::set(this, "env.ms_agent*", "ms_agent_config",a_ms_config);
      

  endfunction : build_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection(this, "----------------------TEST STAETED----------------------");
   repeat(10)
    fork
      seq_m.start(env.m_agent.sequencer);
      seq_ms.start(env.ms_agent.sequencer);
    join
    #1000
    phase.drop_objection(this, "----------------------TEST FINISHED----------------------");
  endtask : run_phase

endclass
 
`endif
