class virtual_sequencer extends uvm_sequencer;

    `uvm_component_utils(virtual_sequencer)

    cache_sequencer cache_seqr;
    axi_sequencer axi_seqr;

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction

endclass