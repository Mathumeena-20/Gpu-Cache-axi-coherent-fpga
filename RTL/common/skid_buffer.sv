module skid_buffer(
    input logic clk,
    input logic rst,

    input logic valid_in,
    input logic [63:0] data_in,

    output logic valid_out,
    output logic [63:0] data_out
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin

            valid_out <= 0;
            data_out  <= 0;

        end else begin

            valid_out <= valid_in;
            data_out  <= data_in;

        end
    end

endmodule