module cache_metadata_array #(
    parameter DEPTH = 256
)(
    input logic clk,

    input logic we,
    input logic [7:0] index,

    input logic valid_in,
    input logic dirty_in,

    output logic valid_out,
    output logic dirty_out
);

    logic valid_mem [DEPTH-1:0];
    logic dirty_mem [DEPTH-1:0];

    always_ff @(posedge clk) begin

        if (we) begin
            valid_mem[index] <= valid_in;
            dirty_mem[index] <= dirty_in;
        end

        valid_out <= valid_mem[index];
        dirty_out <= dirty_mem[index];

    end

endmodule