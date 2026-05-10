module race_condition_resolver(
    input logic req0,
    input logic req1,

    output logic grant0,
    output logic grant1
);

    always_comb begin

        grant0 = 0;
        grant1 = 0;

        if (req0)
            grant0 = 1;

        else if (req1)
            grant1 = 1;

    end

endmodule