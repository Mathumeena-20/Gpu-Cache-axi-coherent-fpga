module deadlock_checks(

    input logic clk,
    input logic rst,

    input logic stalled,
    input logic progress
);

    // ==========================================
    // PROPERTY:
    // System must eventually make progress
    // ==========================================

    property no_permanent_stall;

        @(posedge clk)
        disable iff(rst)

        stalled |-> ##[1:50] progress;

    endproperty

    assert property(no_permanent_stall);

    // ==========================================
    // PROPERTY:
    // Progress clears stall
    // ==========================================

    property progress_clears_stall;

        @(posedge clk)
        disable iff(rst)

        progress |=> !stalled;

    endproperty

    assert property(progress_clears_stall);

endmodule