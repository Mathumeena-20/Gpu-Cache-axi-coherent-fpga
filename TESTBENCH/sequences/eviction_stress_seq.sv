class eviction_stress_seq;

    task run();

        repeat (256) begin

            tb.dut.req_addr = $random;

            #5;

        end

    endtask

endclass