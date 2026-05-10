class invalidation_stress_seq;

    task run();

        repeat (50) begin

            tb.dut.invalidate = 1;

            #5;

        end

    endtask

endclass