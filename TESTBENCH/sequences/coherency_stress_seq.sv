class coherency_stress_seq;

    task run();

        repeat (100) begin

            tb.dut.req_core = $random;
            tb.dut.req_addr = $random;
            tb.dut.req_type = $random;

            #10;

        end

    endtask

endclass