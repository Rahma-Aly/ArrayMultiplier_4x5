
`include "driver.sv"
`include "scoreboard.sv"
`include "monitor.sv"
`include "coverage.sv"

module top_hvl #(parameter INPUT1_WIDTH = 4, INPUT2_WIDTH = 5)
    (mult_interface interf);
    
    driver     #(INPUT1_WIDTH,INPUT2_WIDTH) a_driver;
    scoreboard #(INPUT1_WIDTH,INPUT2_WIDTH) a_scrbrd;
    monitor    #(INPUT1_WIDTH,INPUT2_WIDTH) a_monitor;
    coverage   #(INPUT1_WIDTH,INPUT2_WIDTH) a_cov;
    
    initial begin
        a_driver  = new(interf);
        a_scrbrd  = new();
        a_cov     = new(); 
        a_monitor = new(interf,a_cov, a_scrbrd);
        
        fork
            a_monitor.monitor();
            a_driver.driver();
        join_none
        
    end
    
    
    
endmodule
