module fetch_stage(
    input logic clk,
    input logic rst,

    output logic [31:0] instr,
    output logic [31:0] pc
);

    logic [31:0] imem [255:0];

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            pc <= 0;

        else
            pc <= pc + 4;

        instr <= imem[pc[9:2]];

    end

endmodule