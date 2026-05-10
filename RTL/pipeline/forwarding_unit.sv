module forwarding_unit(
    input logic [4:0] ex_rs1,
    input logic [4:0] ex_rs2,

    input logic [4:0] mem_rd,
    input logic [4:0] wb_rd,

    input logic mem_regwrite,
    input logic wb_regwrite,

    output logic forward_a,
    output logic forward_b
);

    always_comb begin

        forward_a = 0;
        forward_b = 0;

        if (mem_regwrite && (mem_rd == ex_rs1))
            forward_a = 1;

        if (wb_regwrite && (wb_rd == ex_rs2))
            forward_b = 1;

    end

endmodule