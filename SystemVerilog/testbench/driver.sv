// drivering transactions to the DUT
// get a transaction from the mailbox if it is available
// and drive it out into the DUT interface

class driver;
    virtual switch_if vif;
    event drv_done;
    mailbox drv_mbx;

    task run();
        $display("T=%0t [Driver] Starting ...", $time);
        @ (posedge vif.clk);

        forever begin
            switch_item item;

            $display("T=%0t [Driver] waiting for item ...", $item);
            drv_mbx.get(item);
            item.print("Driver");
            vif.vld  <= 1;
            vif.addr <= item.addr;
            vif.data <= item.data;

            @ (posedge vif.clk);
              vif.vld <= 0;
              ->drv_done;
        end
    endtask
endclass
