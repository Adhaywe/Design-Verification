// test class instantiates the environment and starts it

class test;
    env e0;

    // object constructions should be instant
    // constructors are expected to be functions

    function new();
        e0 = new;
    endfunction

    task run();
        e0.run();
    endtask
endclass
