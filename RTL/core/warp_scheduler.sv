module warp_scheduler #(
    parameter NUM_WARPS = 8
)(
    input  logic clk,
    input  logic rst,

    input  logic [NUM_WARPS-1:0] warp_ready,

    output logic [$clog2(NUM_WARPS)-1:0] selected_warp
);

    integer i;

    always_comb begin

        selected_warp = 0;

        for (i=0; i<NUM_WARPS; i++) begin
            if (warp_ready[i]) begin
                selected_warp = i;
                break;
            end
        end

    end

endmodule