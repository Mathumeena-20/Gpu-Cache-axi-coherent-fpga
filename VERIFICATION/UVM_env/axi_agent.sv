class axi_agent extends uvm_agent;

    `uvm_component_utils(axi_agent)

    axi_driver drv;
    axi_monitor mon;
    axi_sequencer seqr;

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction

endclass