// generator class to generate a random number of transactions
// with random addresses and data that can be driven to the design

class generator;
    mailbox drv_mbx;
    event drv_done; // event to synchronize different processes
    int num = 20; // number of transactions the generator will create

    task run();
        for (int i=0; i<num; i++)begin
            switch_item item = new; // create a new object from class switch_item
            item.randomize();
            $display ("T=%0t [Generator] Loop:%0d/%0d create next item", $time, i+1, num);
            drv_mbx.put(item);
            @(drv_done);
        end
        $display ("T=%0t [Generator] Done generation of %0d items", $time, num);
    endtask
endclass
