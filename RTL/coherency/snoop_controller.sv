module snoop_controller(
    input logic clk,
    input logic rst,

    input logic snoop_req,

    output logic invalidate
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            invalidate <= 0;

        else
            invalidate <= snoop_req;

    end

endmodule