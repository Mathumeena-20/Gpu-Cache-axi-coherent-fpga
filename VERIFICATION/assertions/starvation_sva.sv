module starvation_sva(

    input logic clk,
    input logic rst,

    input logic req,
    input logic grant
);

    // ==========================================
    // Every request eventually granted
    // ==========================================

    property no_starvation;

        @(posedge clk)
        disable iff(rst)

        req |-> ##[1:20] grant;

    endproperty

    assert property(no_starvation)
    else
        $error("STARVATION_SVA: starvation detected");

endmodule