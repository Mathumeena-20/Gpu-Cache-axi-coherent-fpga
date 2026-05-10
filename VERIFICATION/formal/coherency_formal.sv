`timescale 1ns/1ps

module coherency_formal #(
    parameter NUM_CORES = 4
)(
    input logic clk,
    input logic rst,

    input logic [NUM_CORES-1:0] sharers,
    input logic [$clog2(NUM_CORES)-1:0] owner,

    input logic write_req,
    input logic invalidate
);

    // ==========================================
    // PROPERTY:
    // Owner must always be a sharer
    // ==========================================

    property owner_is_valid;

        @(posedge clk)
        disable iff(rst)

        sharers[owner];

    endproperty

    assert property(owner_is_valid);

    // ==========================================
    // PROPERTY:
    // Write requires invalidation
    // ==========================================

    property write_requires_invalidate;

        @(posedge clk)
        disable iff(rst)

        write_req |-> invalidate;

    endproperty

    assert property(write_requires_invalidate);

    // ==========================================
    // PROPERTY:
    // Single owner guarantee
    // ==========================================

    property single_owner;

        @(posedge clk)
        disable iff(rst)

        $onehot0(sharers);

    endproperty

    assert property(single_owner);

endmodule