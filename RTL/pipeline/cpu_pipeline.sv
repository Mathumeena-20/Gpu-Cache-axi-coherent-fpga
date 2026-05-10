`timescale 1ns/1ps

module cpu_pipeline(
    input logic clk,
    input logic rst
);

    logic [31:0] instr;
    logic [31:0] pc;

    fetch_stage fetch (

        .clk(clk),
        .rst(rst),

        .instr(instr),
        .pc(pc)

    );

endmodule