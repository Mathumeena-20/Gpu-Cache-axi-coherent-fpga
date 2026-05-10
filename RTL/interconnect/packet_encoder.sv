module packet_encoder(
    input  logic [31:0] addr,
    input  logic [31:0] data,

    output logic [63:0] packet
);

    assign packet = {addr, data};

endmodule