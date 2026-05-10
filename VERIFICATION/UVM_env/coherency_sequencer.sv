class coherency_sequencer extends uvm_sequencer #(coherency_transaction);

    `uvm_component_utils(coherency_sequencer)

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction

endclass