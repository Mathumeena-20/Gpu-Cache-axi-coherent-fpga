module scoreboard_unit #(
    parameter REG_NUM = 32
)(
    input logic clk,
    input logic rst,

    input logic issue,
    input logic [4:0] rd,

    input logic wb_done,

    output logic busy
);

    logic scoreboard [REG_NUM-1:0];

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            busy <= 0;

        else begin

            if (issue)
                scoreboard[rd] <= 1;

            if (wb_done)
                scoreboard[rd] <= 0;

            busy <= scoreboard[rd];

        end
    end

endmodule