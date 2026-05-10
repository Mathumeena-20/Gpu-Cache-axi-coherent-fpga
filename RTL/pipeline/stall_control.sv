module stall_control(
    input logic hazard,
    input logic cache_miss,

    output logic stall_pipeline
);

    assign stall_pipeline = hazard | cache_miss;

endmodule