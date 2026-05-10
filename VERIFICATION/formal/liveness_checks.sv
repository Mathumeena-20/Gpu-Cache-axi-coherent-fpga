module liveness_checks(

    input logic clk,
    input logic rst,

    input logic req,
    input logic grant,

    input logic valid_in,
    input logic valid_out
);

    // ==========================================
    // PROPERTY:
    // Every request eventually granted
    // ==========================================

    property eventual_grant;

        @(posedge clk)
        disable iff(rst)

        req |-> ##[1:20] grant;

    endproperty

    assert property(eventual_grant);

    // ==========================================
    // PROPERTY:
    // Packets eventually leave NoC
    // ==========================================

    property eventual_packet_exit;

        @(posedge clk)
        disable iff(rst)

        valid_in |-> ##[1:30] valid_out;

    endproperty

    assert property(eventual_packet_exit);

endmodule