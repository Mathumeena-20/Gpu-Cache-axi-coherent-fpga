module probe_handler(
    input logic clk,
    input logic rst,

    input logic probe_req,

    output logic probe_ack
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            probe_ack <= 0;

        else
            probe_ack <= probe_req;

    end

endmodule