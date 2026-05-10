class axi_ooo_seq;

    task run();

        repeat (8) begin

            tb.dut.req_valid = 1;
            tb.dut.req_addr  = $random;

            #3;

        end

    endtask

endclass