module write_buffer #(
    parameter DEPTH = 8
)(
    input logic clk,
    input logic rst,

    input logic push,
    input logic [31:0] addr,
    input logic [63:0] data
);

    logic [31:0] addr_q [DEPTH-1:0];
    logic [63:0] data_q [DEPTH-1:0];

    integer tail;

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            tail <= 0;

        else if (push) begin

            addr_q[tail] <= addr;
            data_q[tail] <= data;

            tail <= tail + 1;

        end
    end

endmodule