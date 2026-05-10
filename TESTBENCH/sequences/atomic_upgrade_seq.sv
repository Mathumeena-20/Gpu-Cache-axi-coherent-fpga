class atomic_upgrade_seq;

    task run();

        tb.dut.req_addr = 32'h4000;
        tb.dut.req_type = 2'b10;

        #20;

    endtask

endclass