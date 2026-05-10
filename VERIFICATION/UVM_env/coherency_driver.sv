class coherency_driver extends uvm_driver #(coherency_transaction);

    `uvm_component_utils(coherency_driver)

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual task run_phase(uvm_phase phase);

        coherency_transaction tx;

        forever begin

            seq_item_port.get_next_item(tx);

            `uvm_info("COH_DRV",
                      $sformatf("Core=%0d Addr=%h",
                      tx.core_id, tx.addr),
                      UVM_LOW)

            seq_item_port.item_done();

        end
    endtask

endclass