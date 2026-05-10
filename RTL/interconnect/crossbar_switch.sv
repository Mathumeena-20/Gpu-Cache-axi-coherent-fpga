module crossbar_switch(
    input  logic sel,

    input  logic [63:0] in0,
    input  logic [63:0] in1,

    output logic [63:0] out
);

    assign out = sel ? in1 : in0;

endmodule