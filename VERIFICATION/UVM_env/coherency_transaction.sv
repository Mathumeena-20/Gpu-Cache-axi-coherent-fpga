class coherency_transaction extends uvm_sequence_item;

    rand bit [31:0] addr;
    rand bit [1:0] state;
    rand bit [1:0] core_id;

    `uvm_object_utils(coherency_transaction)

    function new(string name="coherency_transaction");
        super.new(name);
    endfunction

endclass