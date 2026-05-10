module onehot_encoder #(
    parameter WIDTH = 4
)(
    input logic [$clog2(WIDTH)-1:0] binary,

    output logic [WIDTH-1:0] onehot
);

    assign onehot = (1 << binary);

endmodule