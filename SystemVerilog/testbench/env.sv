// the environment is a container object simply to hold all verification
// components together

class env;
    driver     d0;
    monitor    m0;
    generator  g0;
    scoreboard s0;

    mailbox drv_mbx; // connect Generator -> Driver
    mailbox scb_mbx; // connect Monitor -> Scoreboard
    event drv_done;

    virtual switch_if vif; // virtual interface handle

    function new();
        d0 = new;
        m0 = new;
        g0 = new;
        s0 = new;
        drv_mbx = new();
        scb_mbx = new();

        // connect mailboxes
        d0.drv_mbx = drv_mbx;
        g0.drv_mbx = drc_mbx;
        m0.scb_mbx = scb_mbx;
        s0.scb_mbx = scb_mbx;

        d0.drv_done = drv_done;
        g0.drv_done = drv_done;
    endfunction

    virtual task run();
        d0.vif = vif;
        m0.vif = vif;

        // start everything in parallel
        // all components run at the same time
        fork
            d0.run();
            m0.run();
            g0.run();
            s0.run();
        join_any
    endtask
endclass
