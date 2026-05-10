module cpu_pipeline_core(
    input logic clk,
    input logic rst
);

    logic [31:0] pc;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            pc <= 0;
        else
            pc <= pc + 4;
    end

endmodule