module adaptive_prefetcher(
    input logic clk,
    input logic rst,

    input logic cache_hit,
    input logic cache_miss,

    output logic enable_prefetch
);

    logic [7:0] miss_counter;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            miss_counter    <= 0;
            enable_prefetch <= 0;

        end else begin

            if (cache_miss)
                miss_counter <= miss_counter + 1;

            if (cache_hit && miss_counter > 10)
                enable_prefetch <= 1;

            else if (miss_counter < 2)
                enable_prefetch <= 0;

        end
    end

endmodule