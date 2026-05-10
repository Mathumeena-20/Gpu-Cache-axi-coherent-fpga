module timing_controller(
    input logic clk,
    input logic rst,

    input logic cmd_valid,

    output logic timing_ok
);

    logic [3:0] timer;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            timer <= 0;
            timing_ok <= 1;

        end else begin

            if (cmd_valid) begin

                timer <= 4;

            end else if (timer != 0) begin

                timer <= timer - 1;

            end

            timing_ok <= (timer == 0);

        end
    end

endmodule