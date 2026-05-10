module sharer_tracker #(
    parameter NUM_CORES = 4
)(
    input logic clk,

    input logic update,
    input logic [$clog2(NUM_CORES)-1:0] core_id,

    output logic [NUM_CORES-1:0] sharers
);

    always_ff @(posedge clk) begin

        if (update)
            sharers[core_id] <= 1;

    end

endmodule