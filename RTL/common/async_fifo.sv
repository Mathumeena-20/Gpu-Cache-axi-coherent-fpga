module async_fifo #(
    parameter WIDTH = 64,
    parameter DEPTH = 16
)(
    input logic wr_clk,
    input logic rd_clk,
    input logic rst,

    input logic wr_en,
    input logic rd_en,

    input logic [WIDTH-1:0] din,

    output logic [WIDTH-1:0] dout
);

    logic [WIDTH-1:0] mem [DEPTH-1:0];

    integer wr_ptr;
    integer rd_ptr;

    always_ff @(posedge wr_clk) begin

        if (wr_en) begin

            mem[wr_ptr] <= din;
            wr_ptr <= wr_ptr + 1;

        end
    end

    always_ff @(posedge rd_clk) begin

        if (rd_en) begin

            dout <= mem[rd_ptr];
            rd_ptr <= rd_ptr + 1;

        end
    end

endmodule