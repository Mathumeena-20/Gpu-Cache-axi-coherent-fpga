class qos_stress_seq;

    task run();

        repeat (50) begin

            tb.dut.high_priority_req = $random;
            tb.dut.low_priority_req  = $random;

            #5;

        end

    endtask

endclass