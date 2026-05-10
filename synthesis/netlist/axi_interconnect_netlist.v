module axi_interconnect_netlist (

    clk,
    rst,

    arvalid,
    arready
);

input clk;
input rst;

input arvalid;

output arready;

wire n40;
wire n41;

INVX1 U40 (
    .A(rst),
    .Y(n40)
);

DFFRX1 U41 (
    .D(arvalid),
    .CK(clk),
    .RN(n40),
    .Q(n41)
);

BUF1X U42 (
    .A(n41),
    .Y(arready)
);

endmodule