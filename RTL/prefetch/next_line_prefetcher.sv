module next_line_prefetcher(
    input logic clk,
    input logic rst,

    input logic access_valid,
    input logic [31:0] access_addr,

    output logic prefetch_valid,
    output logic [31:0] prefetch_addr
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            prefetch_valid <= 0;
            prefetch_addr  <= 0;

        end else begin

            if (access_valid) begin

                prefetch_addr  <= access_addr + 64;
                prefetch_valid <= 1;

            end else begin

                prefetch_valid <= 0;

            end
        end
    end

endmodule