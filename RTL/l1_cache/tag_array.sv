module tag_array #(
    parameter DEPTH = 256
)(
    input  logic clk,
    input  logic [31:0] addr,

    output logic hit
);

    logic [31:0] tags [DEPTH-1:0];

    always_ff @(posedge clk) begin
        hit <= (tags[addr[9:2]] == addr);
    end

endmodule