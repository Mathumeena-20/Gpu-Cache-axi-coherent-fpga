module memory_scheduler #(
    parameter NUM_REQS = 4
)(
    input  logic clk,
    input  logic rst,

    input  logic [NUM_REQS-1:0] req_valid,

    output logic [NUM_REQS-1:0] grant
);

    integer i;

    always_comb begin

        grant = 0;

        for (i=0; i<NUM_REQS; i++) begin

            if (req_valid[i]) begin
                grant[i] = 1;
                break;
            end

        end

    end

endmodule