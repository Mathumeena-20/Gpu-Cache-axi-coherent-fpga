module transient_state_handler(
    input logic clk,
    input logic rst,

    input logic request_pending,

    output logic transient_busy
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            transient_busy <= 0;

        else
            transient_busy <= request_pending;

    end

endmodule