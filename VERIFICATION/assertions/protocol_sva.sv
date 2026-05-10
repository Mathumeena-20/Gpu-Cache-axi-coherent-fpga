module protocol_sva(

    input logic clk,
    input logic rst,

    input logic req,
    input logic ack
);

    // ==========================================
    // ACK only after REQ
    // ==========================================

    property ack_after_req;

        @(posedge clk)
        disable iff(rst)

        ack |-> $past(req);

    endproperty

    assert property(ack_after_req)
    else
        $error("PROTOCOL_SVA: ACK without REQ");

endmodule