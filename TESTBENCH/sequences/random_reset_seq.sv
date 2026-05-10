class random_reset_seq;

    task run();

        repeat (10) begin

            tb.rst = 1;

            #10;

            tb.rst = 0;

            #50;

        end

    endtask

endclass