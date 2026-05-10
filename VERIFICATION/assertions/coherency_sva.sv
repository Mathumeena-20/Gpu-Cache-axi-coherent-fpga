/*module coherency_sva(

    input logic clk,
    input logic rst,

    input logic [3:0] sharers,
    input logic [1:0] owner
);

    // ==========================================
    // Owner must be one of sharers
    // ==========================================

    property owner_is_sharer;

        @(posedge clk)
        disable iff(rst)

        sharers[owner];

    endproperty

    assert property(owner_is_sharer)
    else
        $error("COHERENCY_SVA: owner invalid");

endmodule*/

`timescale 1ns/1ps

module coherency_sva #(
    parameter NUM_CORES = 4
)(
    input logic clk,
    input logic rst,

    input logic req_valid,
    input logic [1:0] req_type,

    input logic send_invalidate,
    input logic [NUM_CORES-1:0] invalidate_vector,

    input logic [1:0] state,

    input logic [NUM_CORES-1:0] sharers
);

    // ==========================================
    // MESI STATES
    // ==========================================

    localparam INVALID  = 2'b00;
    localparam SHARED   = 2'b01;
    localparam MODIFIED = 2'b10;

    // ==========================================
    // PROPERTY 1
    // WRITE SHOULD CAUSE INVALIDATION
    // ==========================================

    property p_write_causes_invalidate;

        @(posedge clk)
        disable iff (rst)

        (req_valid && req_type == 2'b10)
        |-> send_invalidate;

    endproperty

    assert property (p_write_causes_invalidate)
    else
        $error("WRITE did not trigger invalidation");

    // ==========================================
    // PROPERTY 2
    // MODIFIED STATE MUST HAVE ONLY ONE SHARER
    // ==========================================

    property p_modified_single_owner;

        @(posedge clk)
        disable iff (rst)

        (state == MODIFIED)
        |->
        (
            sharers == 4'b0001 ||
            sharers == 4'b0010 ||
            sharers == 4'b0100 ||
            sharers == 4'b1000
        );

    endproperty

    assert property (p_modified_single_owner)
    else
        $error("MODIFIED state has multiple sharers");

    // ==========================================
    // PROPERTY 3
    // INVALID STATE SHOULD HAVE NO SHARERS
    // ==========================================

    property p_invalid_no_sharers;

        @(posedge clk)
        disable iff (rst)

        (state == INVALID)
        |->
        (sharers == 0);

    endproperty

    assert property (p_invalid_no_sharers)
    else
        $error("INVALID state contains sharers");

    // ==========================================
    // PROPERTY 4
    // INVALIDATION VECTOR SHOULD NOT BE ZERO
    // ==========================================

    property p_invalidate_nonzero;

        @(posedge clk)
        disable iff (rst)

        send_invalidate
        |->
        (invalidate_vector != 0);

    endproperty

    assert property (p_invalidate_nonzero)
    else
        $error("Invalidate vector is zero");

endmodule