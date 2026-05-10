module issue_unit(
    input  logic clk,
    input  logic rst,

    input  logic instr_valid,

    output logic issue_grant
);

    always_ff @(posedge clk or posedge rst) begin

        if (rst)
            issue_grant <= 0;
        else
            issue_grant <= instr_valid;

    end

endmodule