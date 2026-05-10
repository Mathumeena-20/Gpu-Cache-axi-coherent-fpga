class snoop_collision_seq;

    task run();

        fork

            tb.dut.snoop_req = 1;

            tb.dut.req_valid = 1;

        join

    endtask

endclass