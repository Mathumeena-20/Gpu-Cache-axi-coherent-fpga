module eviction_buffer(
    input logic clk,
    input logic rst,

    input logic evict_valid,
    input logic [63:0] evict_data
);

    logic [63:0] evict_q [7:0];

    integer tail;

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            tail <= 0;

        else if (evict_valid) begin

            evict_q[tail] <= evict_data;
            tail <= tail + 1;

        end
    end

endmodule