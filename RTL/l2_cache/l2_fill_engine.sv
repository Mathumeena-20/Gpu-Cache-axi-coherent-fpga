module l2_fill_engine(
    input logic clk,
    input logic rst,

    input logic fill_valid,
    input logic [63:0] fill_data,

    output logic done
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            done <= 0;

        else
            done <= fill_valid;

    end

endmodule