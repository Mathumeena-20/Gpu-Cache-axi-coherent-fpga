class cache_monitor extends uvm_monitor;

    `uvm_component_utils(cache_monitor)

    uvm_analysis_port #(cache_transaction) ap;

    function new(string name, uvm_component parent);

        super.new(name,parent);

        ap = new("ap", this);

    endfunction

endclass