module directory_controller_netlist (

    clk,
    rst,

    req_valid,

    grant
);

input clk;
input rst;

input req_valid;

output grant;

wire n30;
wire n31;

INVX1 U30 (
    .A(rst),
    .Y(n30)
);

DFFRX1 U31 (
    .D(req_valid),
    .CK(clk),
    .RN(n30),
    .Q(n31)
);

BUF1X U32 (
    .A(n31),
    .Y(grant)
);

endmodule