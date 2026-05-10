`timescale 1ns/1ps

module soc_top_axi #(
    parameter NUM_CORES = 4,
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 64
)(
    input  logic clk,
    input  logic rst,

    // ==========================================
    // Requests from L1s
    // ==========================================

    input  logic [NUM_CORES-1:0]                  req_valid,
    input  logic [NUM_CORES-1:0][ADDR_WIDTH-1:0] req_addr,

    // ==========================================
    // Responses to L1s
    // ==========================================

    output logic [NUM_CORES-1:0]                  resp_valid,
    output logic [NUM_CORES-1:0][DATA_WIDTH-1:0] resp_data
);

    // ==========================================
    // Arbitration Signals
    // ==========================================

    logic [NUM_CORES-1:0] grant;

    // ==========================================
    // Arbiter
    // ==========================================

    arbiter #(
        .N(NUM_CORES)
    ) arb (

        .req(req_valid),
        .grant(grant)

    );

    // ==========================================
    // Shared L2 Cache
    // ==========================================

    l2_cache_top l2 (

        .clk(clk),
        .rst(rst),

        .req_valid(|grant),
        .req_addr(req_addr[0]),

        .resp_valid(resp_valid[0]),
        .resp_data(resp_data[0])

    );

endmodule