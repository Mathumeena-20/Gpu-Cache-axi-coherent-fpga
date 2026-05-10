module data_array #(
    parameter DEPTH = 256
)(
    input logic clk,
    input logic [31:0] addr,

    output logic [63:0] rdata
);

    logic [63:0] mem [DEPTH-1:0];

    always_ff @(posedge clk) begin

        rdata <= mem[addr[9:2]];

    end

endmodule