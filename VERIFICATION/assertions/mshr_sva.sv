module mshr_sva(

    input logic clk,
    input logic rst,

    input logic miss_valid,
    input logic mshr_full
);

    // ==========================================
    // No allocation when MSHR full
    // ==========================================

    property no_overflow;

        @(posedge clk)
        disable iff(rst)

        mshr_full |-> !miss_valid;

    endproperty

    assert property(no_overflow)
    else
        $error("MSHR_SVA: overflow detected");

endmodule