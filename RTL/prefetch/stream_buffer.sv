module stream_buffer #(
    parameter DEPTH = 8
)(
    input logic clk,
    input logic rst,

    input logic push,
    input logic [31:0] addr_in,

    input logic pop,

    output logic [31:0] addr_out,
    output logic empty,
    output logic full
);

    logic [31:0] buffer [DEPTH-1:0];

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

                buffer[tail] <= addr_in;
                tail <= (tail + 1) % DEPTH;
                count <= count + 1;

            end

            if (pop && !empty) begin

                addr_out <= buffer[head];
                head <= (head + 1) % DEPTH;
                count <= count - 1;

            end
        end
    end

    assign empty = (count == 0);
    assign full  = (count == DEPTH);

endmodule