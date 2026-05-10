module snoop_filter(
    input logic [31:0] addr,

    output logic snoop_needed
);

    assign snoop_needed = addr[5];

endmodule