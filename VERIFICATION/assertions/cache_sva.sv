`timescale 1ns/1ps

module cache_sva(

    input logic clk,
    input logic rst,

    input logic req_valid,
    input logic hit,
    input logic miss
);

    // ==========================================
    // Hit and miss cannot happen together
    // ==========================================

    property no_hit_miss_overlap;

        @(posedge clk)
        disable iff(rst)

        !(hit && miss);

    endproperty

    assert property(no_hit_miss_overlap)
    else
        $error("CACHE_SVA: hit & miss overlap");

    // ==========================================
    // Valid request must produce hit or miss
    // ==========================================

    property req_generates_response;

        @(posedge clk)
        disable iff(rst)

        req_valid |-> ##1 (hit || miss);

    endproperty

    assert property(req_generates_response)
    else
        $error("CACHE_SVA: request unresolved");

endmodule