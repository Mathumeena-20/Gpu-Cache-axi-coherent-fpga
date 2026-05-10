module reorder_buffer #(
    parameter DEPTH = 16
)(
    input logic clk,
    input logic rst,

    input logic push,
    input logic [31:0] data_in,

    input logic pop,

    output logic [31:0] data_out
);

    logic [31:0] rob [DEPTH-1:0];

    integer head;
    integer tail;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            head <= 0;
            tail <= 0;

        end else begin

            if (push) begin

                rob[tail] <= data_in;
                tail <= tail + 1;

            end

            if (pop) begin

                data_out <= rob[head];
                head <= head + 1;

            end
        end
    end

endmodule