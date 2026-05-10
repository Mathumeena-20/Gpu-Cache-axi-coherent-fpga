module noc_sva(

    input logic clk,
    input logic rst,

    input logic valid_in,
    input logic valid_out
);

    // ==========================================
    // Input valid should eventually exit
    // ==========================================

    property packet_progress;

        @(posedge clk)
        disable iff(rst)

        valid_in |-> ##[1:10] valid_out;

    endproperty

    assert property(packet_progress)
    else
        $error("NOC_SVA: packet stuck");

endmodule