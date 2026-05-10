module memory_stage(
    input  logic clk,

    input  logic mem_read,
    input  logic mem_write,

    input  logic [31:0] addr,
    input  logic [31:0] wdata,

    output logic [31:0] rdata
);

    logic [31:0] dmem [255:0];

    always_ff @(posedge clk) begin

        if (mem_write)
            dmem[addr[9:2]] <= wdata;

        if (mem_read)
            rdata <= dmem[addr[9:2]];

    end

endmodule