class coherency_scoreboard extends scoreboard;

    `uvm_component_utils(coherency_scoreboard)

    bit [1:0] cache_state [256];

    function new(string name,
                 uvm_component parent);

        super.new(name, parent);

    endfunction

    virtual function void check_coherency(
        bit [31:0] addr,
        bit [1:0] observed_state,
        bit [1:0] expected_state
    );

        string msg;

        msg = $sformatf(
              "Addr=%h Obs=%0d Exp=%0d",
               addr,
               observed_state,
               expected_state);

        check_result(
            observed_state == expected_state,
            msg
        );

    endfunction

endclass