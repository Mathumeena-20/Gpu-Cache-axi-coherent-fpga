module writeback_stage(
    input logic clk,

    input logic reg_write,

    output logic wb_done
);

    always_ff @(posedge clk) begin

        wb_done <= reg_write;

    end

endmodule