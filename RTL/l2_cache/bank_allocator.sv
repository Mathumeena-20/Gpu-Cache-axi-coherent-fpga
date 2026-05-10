module bank_allocator #(
    parameter NUM_BANKS = 4
)(
    input  logic [31:0] addr,

    output logic [$clog2(NUM_BANKS)-1:0] bank_id
);

    assign bank_id = addr[3:2];

endmodule