module cache_bank_arbiter #(
    parameter NUM_REQS = 4
)(
    input  logic [NUM_REQS-1:0] req,

    output logic [NUM_REQS-1:0] grant
);

    integer i;

    always_comb begin

        grant = 0;

        for (i=0; i<NUM_REQS; i++) begin

            if (req[i]) begin
                grant[i] = 1;
                break;
            end

        end

    end

endmodule