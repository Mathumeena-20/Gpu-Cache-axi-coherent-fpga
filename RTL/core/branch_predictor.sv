module branch_predictor #(
    parameter ENTRY_NUM = 16
)(
    input  logic clk,
    input  logic rst,

    input  logic [31:0] pc,

    output logic predict_taken
);

    logic [1:0] bht [ENTRY_NUM-1:0];

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            predict_taken <= 0;
        else
            predict_taken <= bht[pc[5:2]][1];

    end

endmodule