class cache_agent extends uvm_agent;

    `uvm_component_utils(cache_agent)

    cache_driver drv;
    cache_monitor mon;
    cache_sequencer seqr;

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);

        drv  = cache_driver::type_id::create("drv", this);
        mon  = cache_monitor::type_id::create("mon", this);
        seqr = cache_sequencer::type_id::create("seqr", this);

    endfunction

endclass