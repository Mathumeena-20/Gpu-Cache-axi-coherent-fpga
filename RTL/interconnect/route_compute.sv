module route_compute(
    input  logic [31:0] addr,

    output logic route
);

    assign route = addr[8];

endmodule