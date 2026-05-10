module synchronizer(
    input logic clk,
    input logic async_in,

    output logic sync_out
);

    logic ff1;

    always_ff @(posedge clk) begin

        ff1      <= async_in;
        sync_out <= ff1;

    end

endmodule