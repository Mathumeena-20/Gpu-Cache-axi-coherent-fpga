module victim_cache(
    input  logic clk,
    input  logic rst,

    input  logic write_valid,
    input  logic [31:0] write_addr,

    input  logic read_valid,
    input  logic [31:0] read_addr,

    output logic hit
);

    logic [31:0] victim_tags [7:0];

    integer i;

    always_ff @(posedge clk) begin

        if (write_valid)
            victim_tags[0] <= write_addr;

        hit <= 0;

        for (i=0; i<8; i++) begin
            if (victim_tags[i] == read_addr)
                hit <= 1;
        end

    end

endmodule