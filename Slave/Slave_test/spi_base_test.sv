`ifndef SPI_BASE_TEST
`define SPI_BASE_TEST

class spi_base_test extends uvm_test;

  `uvm_component_utils(spi_base_test)

  spi_env env; 
  spi_s_agent_config a_s_config;
  spi_sm_agent_config a_sm_config;
  spi_sequence seq_s;
  spi_sequence seq_sm;

  function new(string name = "spi_base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    seq_s = spi_sequence::type_id::create("seq_s");
    seq_sm = spi_sequence::type_id::create("seq_sm");
    a_s_config = spi_s_agent_config::type_id::create("a_s_config", this);
    a_sm_config = spi_sm_agent_config::type_id::create("a_sm_config", this);
    env = spi_env::type_id::create("env", this);
    
    if(!uvm_config_db #(virtual spi_s_interface)::get(this, "", "a_s_interface", a_s_config.s_interface))begin
      `uvm_fatal(get_full_name(), "couldn't get the a_s_interface from top")
    end
    uvm_config_db #(spi_s_agent_config)::set(this, "env.s_agent*", "s_agent_config",a_s_config);

    if(!uvm_config_db #(virtual spi_sm_interface)::get(this, "", "a_sm_interface", a_sm_config.sm_interface))begin
      `uvm_fatal(get_full_name(), "couldn't get the a_sm_interface from top")
    end

    if(!uvm_config_db #(int)::get(this, "", "mode", a_sm_config.mode))begin
      `uvm_fatal(get_full_name(), "couldn't get the a_sm_interface from top")
    end


    uvm_config_db #(spi_sm_agent_config)::set(this, "env.sm_agent*", "sm_agent_config",a_sm_config);
      

  endfunction : build_phase

  task run_phase(uvm_phase phase);
    phase.raise_objection(this, "----------------------TEST STAETED----------------------");
   repeat(10)
    fork
      seq_s.start(env.s_agent.sequencer);
      seq_sm.start(env.sm_agent.sequencer);
    join
    #1000
    phase.drop_objection(this, "----------------------TEST FINISHED----------------------");
  endtask : run_phase

endclass
 
`endif
