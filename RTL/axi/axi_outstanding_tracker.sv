module axi_outstanding_tracker(
    input logic clk,
    input logic rst,

    input logic issue_req,
    input logic complete_req,

    output logic full
);

    logic [4:0] outstanding;

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            outstanding <= 0;

        else begin

            if (issue_req)
                outstanding <= outstanding + 1;

            if (complete_req)
                outstanding <= outstanding - 1;

        end
    end

    assign full = (outstanding == 16);

endmodule