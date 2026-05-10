class deadlock_stress_seq;

    task run();

        repeat (100) begin

            tb.dut.stalled = 1;

            #2;

        end

    endtask

endclass