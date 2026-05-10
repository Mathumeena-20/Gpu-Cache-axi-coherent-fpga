class coherency_monitor extends uvm_monitor;

    `uvm_component_utils(coherency_monitor)

    uvm_analysis_port #(coherency_transaction) ap;

    function new(string name, uvm_component parent);

        super.new(name,parent);

        ap = new("ap", this);

    endfunction

endclass