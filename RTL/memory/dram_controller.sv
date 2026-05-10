`timescale 1ns/1ps

module dram_controller(
    input  logic clk,
    input  logic rst,

    input  logic req_valid,
    input  logic [31:0] req_addr,
    input  logic [63:0] req_wdata,
    input  logic req_write,

    output logic resp_valid,
    output logic [63:0] resp_rdata
);

    logic [63:0] dram_mem [0:4095];

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            resp_valid <= 0;

        end else begin

            if (req_valid) begin

                if (req_write)
                    dram_mem[req_addr[13:2]] <= req_wdata;

                else
                    resp_rdata <= dram_mem[req_addr[13:2]];

                resp_valid <= 1;

            end else begin

                resp_valid <= 0;

            end
        end
    end

endmodule