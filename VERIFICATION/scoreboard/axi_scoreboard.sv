class axi_scoreboard extends scoreboard;

    `uvm_component_utils(axi_scoreboard)

    int outstanding_count;

    function new(string name,
                 uvm_component parent);

        super.new(name, parent);

        outstanding_count = 0;

    endfunction

    virtual function void push_request(
        bit [3:0] id
    );

        outstanding_count++;

        `uvm_info("AXI_SB",

                  $sformatf(
                  "Push Req ID=%0d Outstanding=%0d",
                   id,
                   outstanding_count),

                   UVM_LOW)

    endfunction

    virtual function void complete_response(
        bit [3:0] id
    );

        outstanding_count--;

        check_result(
            outstanding_count >= 0,
            "Outstanding count underflow"
        );

    endfunction

endclass