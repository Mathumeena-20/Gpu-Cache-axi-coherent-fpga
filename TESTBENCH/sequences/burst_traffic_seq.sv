class burst_traffic_seq;

    task run();

        repeat (16) begin

            tb.dut.burst_valid = 1;

            #5;

        end

    endtask

endclass