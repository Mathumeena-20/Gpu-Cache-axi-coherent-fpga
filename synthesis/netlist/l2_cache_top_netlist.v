module l2_cache_top_netlist (

    clk,
    rst,

    req_valid,
    req_addr,

    l2_hit
);

input clk;
input rst;

input req_valid;
input [31:0] req_addr;

output l2_hit;

wire n20;
wire n21;
wire n22;

DFFRX1 U20 (
    .D(req_valid),
    .CK(clk),
    .RN(rst),
    .Q(n20)
);

OR2X1 U21 (
    .A(req_addr[5]),
    .B(req_addr[6]),
    .Y(n21)
);

AND2X1 U22 (
    .A(n20),
    .B(n21),
    .Y(l2_hit)
);

endmodule