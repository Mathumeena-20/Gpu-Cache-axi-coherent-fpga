module coherence_lookup(
    input  logic clk,

    input  logic [31:0] addr,

    output logic shared,
    output logic modified
);

    always_ff @(posedge clk) begin

        shared  <= addr[4];
        modified <= addr[5];

    end

endmodule