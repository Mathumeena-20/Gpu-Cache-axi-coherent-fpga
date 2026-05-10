`timescale 1ns/1ps

module stride_prefetcher(
    input  logic clk,
    input  logic rst,

    input  logic access_valid,
    input  logic [31:0] access_addr,

    output logic prefetch_valid,
    output logic [31:0] prefetch_addr
);

    logic [31:0] last_addr;
    logic [31:0] stride;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            last_addr      <= 0;
            stride         <= 0;
            prefetch_valid <= 0;

        end else begin

            if (access_valid) begin

                stride <= access_addr - last_addr;

                prefetch_addr  <= access_addr + stride;
                prefetch_valid <= 1;

                last_addr <= access_addr;

            end else begin

                prefetch_valid <= 0;

            end
        end
    end

endmodule