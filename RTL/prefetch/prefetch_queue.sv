module prefetch_queue #(
    parameter DEPTH = 16
)(
    input logic clk,
    input logic rst,

    input logic push,
    input logic [31:0] prefetch_addr_in,

    input logic pop,

    output logic [31:0] prefetch_addr_out,
    output logic empty,
    output logic full
);

    logic [31:0] queue [DEPTH-1:0];

    integer head;
    integer tail;
    integer count;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            head  <= 0;
            tail  <= 0;
            count <= 0;

        end else begin

            if (push && !full) begin

                queue[tail] <= prefetch_addr_in;
                tail <= (tail + 1) % DEPTH;
                count <= count + 1;

            end

            if (pop && !empty) begin

                prefetch_addr_out <= queue[head];
                head <= (head + 1) % DEPTH;
                count <= count - 1;

            end
        end
    end

    assign empty = (count == 0);
    assign full  = (count == DEPTH);

endmodule