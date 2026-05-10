module noc_switch(
    input  logic clk,
    input  logic rst,

    input  logic in0_valid,
    input  logic in1_valid,

    input  logic [63:0] in0_data,
    input  logic [63:0] in1_data,

    output logic out_valid,
    output logic [63:0] out_data
);

    always_comb begin

        out_valid = 0;
        out_data  = 0;

        if (in0_valid) begin
            out_valid = 1;
            out_data  = in0_data;
        end
        else if (in1_valid) begin
            out_valid = 1;
            out_data  = in1_data;
        end

    end

endmodule