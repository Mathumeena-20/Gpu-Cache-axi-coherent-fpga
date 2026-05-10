module axi_backpressure_unit(
    input logic clk,
    input logic rst,

    input logic fifo_full,

    output logic stall
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            stall <= 0;

        else
            stall <= fifo_full;

    end

endmodule