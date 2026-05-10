module control_unit(
    input  logic [6:0] opcode,

    output logic reg_write,
    output logic mem_read,
    output logic mem_write,
    output logic branch
);

    always_comb begin

        reg_write = 0;
        mem_read  = 0;
        mem_write = 0;
        branch    = 0;

        case(opcode)

            7'b0000011: begin
                reg_write = 1;
                mem_read  = 1;
            end

            7'b0100011: begin
                mem_write = 1;
            end

            7'b1100011: begin
                branch = 1;
            end

        endcase
    end

endmodule