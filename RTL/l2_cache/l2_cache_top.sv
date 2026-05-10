`timescale 1ns/1ps

module l2_cache_top #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 64,
    parameter NUM_BANKS  = 4
)(
    input  logic clk,
    input  logic rst,

    input  logic                    req_valid,
    input  logic [ADDR_WIDTH-1:0]  req_addr,
    input  logic [DATA_WIDTH-1:0]  req_wdata,
    input  logic                    req_write,

    output logic                    resp_valid,
    output logic [DATA_WIDTH-1:0]  resp_rdata
);

    logic hit;

    logic [$clog2(NUM_BANKS)-1:0] bank_sel;

    assign bank_sel = req_addr[3:2];

    banked_cache #(
        .NUM_BANKS(NUM_BANKS)
    ) banks (

        .clk(clk),
        .rst(rst),

        .bank_sel(bank_sel),

        .req_valid(req_valid),
        .req_addr(req_addr),
        .req_wdata(req_wdata),
        .req_write(req_write),

        .resp_valid(resp_valid),
        .resp_rdata(resp_rdata),

        .hit(hit)

    );

endmodule