module victim_buffer #(
    parameter DEPTH = 8
)(
    input logic clk,
    input logic rst,

    input logic push,
    input logic [63:0] data
);

    logic [63:0] buffer [DEPTH-1:0];

    integer tail;

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            tail <= 0;

        else if (push) begin

            buffer[tail] <= data;
            tail <= tail + 1;

        end
    end

endmodule