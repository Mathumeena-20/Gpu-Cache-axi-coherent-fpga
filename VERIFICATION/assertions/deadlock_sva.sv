module deadlock_sva(

    input logic clk,
    input logic rst,

    input logic stalled
);

    // ==========================================
    // Stall cannot persist forever
    // ==========================================

    property no_deadlock;

        @(posedge clk)
        disable iff(rst)

        stalled |-> ##[1:50] !stalled;

    endproperty

    assert property(no_deadlock)
    else
        $error("DEADLOCK_SVA: deadlock detected");

endmodule