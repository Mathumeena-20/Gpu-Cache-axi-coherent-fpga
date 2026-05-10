`timescale 1ns/1ps

module gpu_core_stub #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 64
)(
    input  logic clk,
    input  logic rst,

    output logic                    req_valid,
    output logic [ADDR_WIDTH-1:0]  req_addr,
    output logic [DATA_WIDTH-1:0]  req_wdata,
    output logic                    req_write,

    input  logic                    resp_valid,
    input  logic [DATA_WIDTH-1:0]  resp_rdata
);

    logic [31:0] counter;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            counter    <= 0;
            req_valid  <= 0;
        end else begin

            counter <= counter + 1;

            req_valid <= 1;
            req_addr  <= 32'h1000 + counter;
            req_wdata <= counter;
            req_write <= counter[0];

        end
    end

endmodule