`timescale 1ns/1ps

module l2_mshr #(
    parameter DEPTH = 16
)(
    input  logic        clk,
    input  logic        rst,

    input  logic        miss_valid,
    input  logic [31:0] miss_addr,

    input  logic        mem_resp_valid,
    input  logic [31:0] mem_resp_addr
);

    typedef struct packed {

        logic        valid;
        logic [31:0] addr;

    } mshr_entry_t;

    mshr_entry_t entries [0:DEPTH-1];

    integer i;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            for (i = 0; i < DEPTH; i = i + 1) begin

                entries[i].valid <= 0;
                entries[i].addr  <= 0;

            end
        end
        else begin

            // Allocate entry
            if (miss_valid) begin

                allocate_loop:
                for (i = 0; i < DEPTH; i = i + 1) begin

                    if (!entries[i].valid) begin

                        entries[i].valid <= 1;
                        entries[i].addr  <= miss_addr;

                        disable allocate_loop;

                    end
                end
            end

            // Free entry
            if (mem_resp_valid) begin

                for (i = 0; i < DEPTH; i = i + 1) begin

                    if (entries[i].valid &&
                        entries[i].addr == mem_resp_addr) begin

                        entries[i].valid <= 0;

                    end
                end
            end
        end
    end

endmodule