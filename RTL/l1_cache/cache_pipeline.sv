module cache_pipeline(
    input logic clk,
    input logic rst,

    input logic valid_in,

    output logic valid_out
);

    logic stage1, stage2;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin
            stage1 <= 0;
            stage2 <= 0;
        end else begin
            stage1 <= valid_in;
            stage2 <= stage1;
        end
    end

    assign valid_out = stage2;

endmodule