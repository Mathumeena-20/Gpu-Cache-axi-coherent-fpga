module prefetch_controller(
    input logic clk,
    input logic rst,

    input logic stride_pf_valid,
    input logic nextline_pf_valid,

    output logic issue_prefetch
);

    always_comb begin

        issue_prefetch = 0;

        if (stride_pf_valid || nextline_pf_valid)
            issue_prefetch = 1;

    end

endmodule