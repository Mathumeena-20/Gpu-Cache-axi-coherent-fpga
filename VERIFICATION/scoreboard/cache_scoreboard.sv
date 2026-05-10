class cache_scoreboard extends scoreboard;

    `uvm_component_utils(cache_scoreboard)

    bit [63:0] reference_mem [1023:0];

    function new(string name,
                 uvm_component parent);

        super.new(name,parent);

    endfunction

    virtual function void write_ref_mem(
        bit [31:0] addr,
        bit [63:0] data
    );

        reference_mem[addr[11:2]] = data;

    endfunction

    virtual function void check_read_data(
        bit [31:0] addr,
        bit [63:0] observed_data
    );

        bit [63:0] expected_data;

        expected_data =
            reference_mem[addr[11:2]];

        check_result(
            observed_data == expected_data,

            $sformatf(
            "Addr=%h Obs=%h Exp=%h",
             addr,
             observed_data,
             expected_data)

        );

    endfunction

endclass