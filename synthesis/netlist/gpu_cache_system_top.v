//=========================================================
// Gate-Level Netlist
//=========================================================

module gpu_cache_system_top (

    clk,
    rst,

    req_valid,
    req_addr,

    resp_valid
);

input clk;
input rst;

input req_valid;
input [31:0] req_addr;

output resp_valid;

wire n1;
wire n2;
wire n3;
wire n4;
wire n5;

//-----------------------------------------
// Reset inversion
//-----------------------------------------

INVX1 U1 (
    .A(rst),
    .Y(n1)
);

//-----------------------------------------
// Request FF
//-----------------------------------------

DFFRX1 U2 (
    .D(req_valid),
    .CK(clk),
    .RN(n1),
    .Q(n2)
);

//-----------------------------------------
// Address logic
//-----------------------------------------

XOR2X1 U3 (
    .A(req_addr[0]),
    .B(req_addr[1]),
    .Y(n3)
);

AND2X1 U4 (
    .A(n2),
    .B(n3),
    .Y(n4)
);

OR2X1 U5 (
    .A(n4),
    .B(req_addr[2]),
    .Y(n5)
);

BUF1X U6 (
    .A(n5),
    .Y(resp_valid)
);

endmodule