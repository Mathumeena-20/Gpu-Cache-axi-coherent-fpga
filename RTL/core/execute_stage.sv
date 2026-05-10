module execute_stage(
    input  logic [31:0] a,
    input  logic [31:0] b,
    input  logic [3:0] alu_op,

    output logic [31:0] result
);

    alu alu_inst (
        .a(a),
        .b(b),
        .alu_op(alu_op),
        .result(result)
    );

endmodule