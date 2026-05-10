class axi_transaction extends uvm_sequence_item;

    rand bit [31:0] addr;
    rand bit [63:0] data;
    rand bit [3:0]  id;

    `uvm_object_utils(axi_transaction)

    function new(string name="axi_transaction");
        super.new(name);
    endfunction

endclass