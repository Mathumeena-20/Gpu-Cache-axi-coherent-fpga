module writeback_engine(
    input logic clk,
    input logic rst,

    input logic wb_valid,
    input logic [63:0] wb_data,

    output logic wb_done
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            wb_done <= 0;

        else
            wb_done <= wb_valid;

    end

endmodule