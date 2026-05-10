class cache_transaction extends uvm_sequence_item;

    rand bit [31:0] addr;
    rand bit [63:0] data;
    rand bit write;

    `uvm_object_utils(cache_transaction)

    function new(string name="cache_transaction");
        super.new(name);
    endfunction

endclass