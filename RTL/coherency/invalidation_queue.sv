module invalidation_queue #(
    parameter DEPTH = 8
)(
    input logic clk,
    input logic rst,

    input logic push,
    input logic [31:0] addr
);

    logic [31:0] queue [DEPTH-1:0];

    integer tail;

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            tail <= 0;

        else if (push) begin

            queue[tail] <= addr;
            tail <= tail + 1;

        end
    end

endmodule