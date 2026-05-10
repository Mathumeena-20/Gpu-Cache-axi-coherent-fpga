module deadlock_prevention(
    input logic clk,
    input logic rst,

    input logic stalled,

    output logic recovery_trigger
);

    logic [7:0] stall_counter;

    always_ff @(posedge clk or posedge rst) begin

        if (rst) begin
            stall_counter <= 0;
            recovery_trigger <= 0;
        end else begin

            if (stalled)
                stall_counter <= stall_counter + 1;
            else
                stall_counter <= 0;

            if (stall_counter > 100)
                recovery_trigger <= 1;

        end
    end

endmodule