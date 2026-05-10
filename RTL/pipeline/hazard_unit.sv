module hazard_unit(
    input logic mem_read_ex,

    input logic [4:0] rd_ex,
    input logic [4:0] rs1_id,
    input logic [4:0] rs2_id,

    output logic stall
);

    always_comb begin

        stall = 0;

        if (mem_read_ex &&
           ((rd_ex == rs1_id) || (rd_ex == rs2_id)))
            stall = 1;

    end

endmodule