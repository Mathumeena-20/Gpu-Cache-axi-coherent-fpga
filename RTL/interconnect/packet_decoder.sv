module packet_decoder(
    input  logic [63:0] packet,

    output logic [31:0] addr,
    output logic [31:0] data
);

    assign addr = packet[63:32];
    assign data = packet[31:0];

endmodule