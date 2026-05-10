module virtual_channels #(
    parameter VC_NUM = 2
)(
    input logic clk,
    input logic rst,

    input logic push,
    input logic [63:0] data_in,

    output logic [63:0] data_out
);

    logic [63:0] vc_fifo [VC_NUM-1:0];

    always_ff @(posedge clk) begin

        if (push)
            vc_fifo[0] <= data_in;

        data_out <= vc_fifo[0];

    end

endmodule