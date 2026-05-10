module axi_response_channel(
    input logic clk,
    input logic rst,

    input logic resp_valid,

    output logic bvalid
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            bvalid <= 0;

        else
            bvalid <= resp_valid;

    end

endmodule