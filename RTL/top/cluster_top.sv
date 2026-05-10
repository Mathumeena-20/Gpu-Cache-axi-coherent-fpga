`timescale 1ns/1ps

module cluster_top #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 64
)(
    input  logic clk,
    input  logic rst,

    // ==========================
    // Core Side
    // ==========================

    output logic                    core_req_valid,
    output logic [ADDR_WIDTH-1:0]  core_req_addr,
    output logic [DATA_WIDTH-1:0]  core_req_wdata,
    output logic                    core_req_write,

    input  logic                    core_resp_valid,
    input  logic [DATA_WIDTH-1:0]  core_resp_rdata,

    // ==========================
    // L1 Side
    // ==========================

    output logic                    l1_req_valid,
    output logic [ADDR_WIDTH-1:0]  l1_req_addr,

    input  logic                    l1_resp_valid,
    input  logic [DATA_WIDTH-1:0]  l1_resp_data
);

    // ==========================================
    // GPU Core Stub
    // ==========================================

    gpu_core_stub core (

        .clk(clk),
        .rst(rst),

        .req_valid(core_req_valid),
        .req_addr(core_req_addr),
        .req_wdata(core_req_wdata),
        .req_write(core_req_write),

        .resp_valid(core_resp_valid),
        .resp_rdata(core_resp_rdata)

    );

    // ==========================================
    // Private L1 Cache
    // ==========================================

    l1_cache_top l1 (

        .clk(clk),
        .rst(rst),

        .req_valid(core_req_valid),
        .req_addr(core_req_addr),
        .req_wdata(core_req_wdata),
        .req_write(core_req_write),

        .resp_valid(core_resp_valid),
        .resp_rdata(core_resp_rdata),

        .mem_req_valid(l1_req_valid),
        .mem_req_addr(l1_req_addr),

        .mem_resp_valid(l1_resp_valid),
        .mem_resp_data(l1_resp_data)

    );

endmodule