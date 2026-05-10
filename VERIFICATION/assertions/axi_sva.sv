module axi_sva(

    input logic clk,
    input logic rst,

    input logic valid,
    input logic ready
);

    // ==========================================
    // VALID must remain asserted until READY
    // ==========================================

    property valid_stable;

        @(posedge clk)
        disable iff(rst)

        valid && !ready |=> valid;

    endproperty

    assert property(valid_stable)
    else
        $error("AXI_SVA: VALID dropped early");

endmodule