`timescale 1ns/1ps

module golden_memory_model #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 64,
    parameter DEPTH      = 4096
)(
    input  logic clk,

    input  logic read_en,
    input  logic write_en,

    input  logic [ADDR_WIDTH-1:0] addr,
    input  logic [DATA_WIDTH-1:0] wdata,

    output logic [DATA_WIDTH-1:0] rdata
);

    // ==========================================
    // Reference Memory Array
    // ==========================================

    logic [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // ==========================================
    // Write Logic
    // ==========================================

    always_ff @(posedge clk) begin

        if (write_en)
            mem[addr[13:2]] <= wdata;

    end

    // ==========================================
    // Read Logic
    // ==========================================

    always_ff @(posedge clk) begin

        if (read_en)
            rdata <= mem[addr[13:2]];

    end

endmodule