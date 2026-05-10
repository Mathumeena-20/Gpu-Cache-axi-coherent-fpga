module sync_fifo #(
    parameter WIDTH = 64,
    parameter DEPTH = 16
)(
    input logic clk,
    input logic rst,

    input logic wr_en,
    input logic rd_en,

    input logic [WIDTH-1:0] din,

    output logic [WIDTH-1:0] dout
);

    fifo #(
        .WIDTH(WIDTH),
        .DEPTH(DEPTH)
    ) fifo_i (

        .clk(clk),
        .rst(rst),

        .push(wr_en),
        .pop(rd_en),

        .data_in(din),
        .data_out(dout),

        .empty(),
        .full()

    );

endmodule