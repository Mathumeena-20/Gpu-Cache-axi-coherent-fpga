module rr_arbiter #(
    parameter N = 4
)(
    input logic clk,
    input logic rst,

    input logic [N-1:0] req,

    output logic [N-1:0] grant
);

    logic [$clog2(N)-1:0] pointer;

    integer i;

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            pointer <= 0;

        else
            pointer <= pointer + 1;

    end

    always_comb begin

        grant = 0;

        for (i=0; i<N; i++) begin

            if (req[(pointer+i)%N]) begin

                grant[(pointer+i)%N] = 1;
                break;

            end
        end
    end

endmodule