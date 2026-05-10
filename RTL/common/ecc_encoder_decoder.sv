module ecc_encoder_decoder(
    input  logic [63:0] data_in,

    output logic [71:0] ecc_data,

    input  logic [71:0] ecc_in,

    output logic [63:0] data_out
);

    assign ecc_data = {8'h00, data_in};

    assign data_out = ecc_in[63:0];

endmodule