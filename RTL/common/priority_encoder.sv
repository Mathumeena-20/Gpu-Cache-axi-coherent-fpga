module priority_encoder #(
    parameter WIDTH = 8
)(
    input  logic [WIDTH-1:0] in,

    output logic [$clog2(WIDTH)-1:0] out
);

    integer i;

    always_comb begin

        out = 0;

        for (i=0; i<WIDTH; i++) begin

            if (in[i]) begin
                out = i;
                break;
            end

        end
    end

endmodule