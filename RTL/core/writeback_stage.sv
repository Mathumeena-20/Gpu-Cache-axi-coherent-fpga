module writeback_stage(
    input  logic clk,

    input  logic reg_write,
    input  logic [4:0] rd,
    input  logic [31:0] wb_data,

    output logic wb_done
);

    always_ff @(posedge clk) begin

        wb_done <= reg_write;

    end

endmodule