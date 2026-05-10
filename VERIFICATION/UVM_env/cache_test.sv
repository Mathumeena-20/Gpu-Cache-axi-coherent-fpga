class cache_test extends uvm_test;

    `uvm_component_utils(cache_test)

    cache_env env;

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);

        env = cache_env::type_id::create("env", this);

    endfunction

endclass