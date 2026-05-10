module l1_cache_top_netlist (

    clk,
    rst,

    req_valid,
    req_addr,

    cache_hit
);

input clk;
input rst;

input req_valid;
input [31:0] req_addr;

output cache_hit;

wire n10;
wire n11;
wire n12;
wire n13;

INVX1 U10 (
    .A(rst),
    .Y(n10)
);

DFFRX1 U11 (
    .D(req_valid),
    .CK(clk),
    .RN(n10),
    .Q(n11)
);

XOR2X1 U12 (
    .A(req_addr[3]),
    .B(req_addr[4]),
    .Y(n12)
);

AND2X1 U13 (
    .A(n11),
    .B(n12),
    .Y(n13)
);

BUF1X U14 (
    .A(n13),
    .Y(cache_hit)
);

endmodule