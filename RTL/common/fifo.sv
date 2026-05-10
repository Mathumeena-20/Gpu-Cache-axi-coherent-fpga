module fifo #(
    parameter WIDTH = 64,
    parameter DEPTH = 8
)(
    input logic clk,
    input logic rst,

    input logic push,
    input logic pop,

    input logic [WIDTH-1:0] data_in,

    output logic [WIDTH-1:0] data_out,
    output logic empty,
    output logic full
);

    logic [WIDTH-1:0] mem [DEPTH-1:0];

    integer head, tail, count;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            head  <= 0;
            tail  <= 0;
            count <= 0;

        end else begin

            if (push && !full) begin

                mem[tail] <= data_in;
                tail <= (tail + 1) % DEPTH;
                count <= count + 1;

            end

            if (pop && !empty) begin

                data_out <= mem[head];
                head <= (head + 1) % DEPTH;
                count <= count - 1;

            end
        end
    end

    assign empty = (count == 0);
    assign full  = (count == DEPTH);

endmodule