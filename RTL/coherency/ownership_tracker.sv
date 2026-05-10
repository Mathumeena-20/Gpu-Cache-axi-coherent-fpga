module ownership_tracker #(
    parameter NUM_CORES = 4
)(
    input logic clk,

    input logic update_owner,
    input logic [$clog2(NUM_CORES)-1:0] core_id,

    output logic [$clog2(NUM_CORES)-1:0] owner
);

    always_ff @(posedge clk) begin

        if (update_owner)
            owner <= core_id;

    end

endmodule