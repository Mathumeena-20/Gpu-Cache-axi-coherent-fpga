module decoder #(
    parameter WIDTH = 4
)(
    input logic [$clog2(WIDTH)-1:0] in,

    output logic [WIDTH-1:0] out
);

    assign out = (1 << in);

endmodule