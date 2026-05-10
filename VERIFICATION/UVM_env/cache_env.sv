class cache_env extends uvm_env;

    `uvm_component_utils(cache_env)

    cache_agent cache_ag;
    axi_agent axi_ag;
    coherency_agent coh_ag;

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);

        cache_ag = cache_agent::type_id::create("cache_ag", this);

        axi_ag   = axi_agent::type_id::create("axi_ag", this);

        coh_ag   = coherency_agent::type_id::create("coh_ag", this);

    endfunction

endclass