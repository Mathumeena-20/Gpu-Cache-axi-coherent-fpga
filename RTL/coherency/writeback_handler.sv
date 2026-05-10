module writeback_handler(
    input logic clk,
    input logic rst,

    input logic wb_req,

    output logic wb_done
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            wb_done <= 0;

        else
            wb_done <= wb_req;

    end

endmodule