class axi_driver extends uvm_driver #(axi_transaction);

    `uvm_component_utils(axi_driver)

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual task run_phase(uvm_phase phase);

        axi_transaction tx;

        forever begin

            seq_item_port.get_next_item(tx);

            `uvm_info("AXI_DRV",
                      $sformatf("AXI addr=%h id=%0d",
                      tx.addr, tx.id),
                      UVM_LOW)

            seq_item_port.item_done();

        end
    endtask

endclass