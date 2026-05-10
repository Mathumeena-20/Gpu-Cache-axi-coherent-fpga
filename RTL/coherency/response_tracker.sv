module response_tracker #(
    parameter NUM_REQS = 8
)(
    input logic clk,
    input logic rst,

    input logic response_valid,

    output logic outstanding_empty
);

    logic [3:0] outstanding;

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            outstanding <= 0;

        else begin

            if (response_valid)
                outstanding <= outstanding - 1;

        end
    end

    assign outstanding_empty = (outstanding == 0);

endmodule