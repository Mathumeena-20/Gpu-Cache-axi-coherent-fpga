module register_file #(
    parameter WIDTH = 32,
    parameter DEPTH = 32
)(
    input  logic clk,

    input  logic we,
    input  logic [4:0] waddr,
    input  logic [WIDTH-1:0] wdata,

    input  logic [4:0] raddr1,
    input  logic [4:0] raddr2,

    output logic [WIDTH-1:0] rdata1,
    output logic [WIDTH-1:0] rdata2
);

    logic [WIDTH-1:0] regs [DEPTH-1:0];

    always_ff @(posedge clk) begin
        if (we)
            regs[waddr] <= wdata;
    end

    assign rdata1 = regs[raddr1];
    assign rdata2 = regs[raddr2];

endmodule