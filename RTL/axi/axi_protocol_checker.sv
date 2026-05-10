module axi_protocol_checker(
    input logic clk,

    input logic valid,
    input logic ready
);

    property valid_stable;

        @(posedge clk)
        valid && !ready |=> valid;

    endproperty

    assert property(valid_stable);

endmodule