module tb();
    
  localparam INPUT1_WIDTH = 4, INPUT2_WIDTH = 5;
    
  mult_interface #(
      .INPUT1_WIDTH(INPUT1_WIDTH),
      .INPUT2_WIDTH(INPUT2_WIDTH)
  ) mult_inter();  
    
  top_hdl #(
      .INPUT1_WIDTH(INPUT1_WIDTH),
      .INPUT2_WIDTH(INPUT2_WIDTH)
  ) top_hdl_instance(
      .mult_inter(mult_inter)
  ); 
  
  top_hvl #(
      .INPUT1_WIDTH(INPUT1_WIDTH),
      .INPUT2_WIDTH(INPUT2_WIDTH)
  ) top_hvl_instance(
      .interf(mult_inter)
  );
    
endmodule
