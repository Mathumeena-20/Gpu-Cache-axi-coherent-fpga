module fill_buffer(
    input logic clk,
    input logic rst,

    input logic fill_valid,
    input logic [63:0] fill_data
);

    logic [63:0] buffer;

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            buffer <= 0;
        else if (fill_valid)
            buffer <= fill_data;

    end

endmodule