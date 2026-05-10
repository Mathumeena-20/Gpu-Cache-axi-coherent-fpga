class cache_driver extends uvm_driver #(cache_transaction);

    `uvm_component_utils(cache_driver)

    function new(string name, uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual task run_phase(uvm_phase phase);

        cache_transaction tx;

        forever begin

            seq_item_port.get_next_item(tx);

            `uvm_info("CACHE_DRV",
                      $sformatf("Driving addr=%h", tx.addr),
                      UVM_LOW)

            seq_item_port.item_done();

        end
    endtask

endclass