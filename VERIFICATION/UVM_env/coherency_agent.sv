class coherency_agent extends uvm_agent;

    `uvm_component_utils(coherency_agent)

    coherency_driver drv;
    coherency_monitor mon;
    coherency_sequencer seqr;

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction

endclass