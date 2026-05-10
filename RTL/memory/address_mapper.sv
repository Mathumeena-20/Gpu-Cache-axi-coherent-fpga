module address_mapper(
    input  logic [31:0] addr,

    output logic [2:0] bank,
    output logic [13:0] row,
    output logic [9:0] column
);

    assign bank   = addr[4:2];
    assign row    = addr[18:5];
    assign column = addr[28:19];

endmodule