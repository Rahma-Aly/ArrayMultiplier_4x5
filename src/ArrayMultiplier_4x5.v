module ArrayMultiplier_4x5 (
      input        clk,
      input        rst_n, 
      input  [3:0] x,
      input  [4:0] y,
      output [8:0] z
  );
  wire [8:0] z_internal;
  wire Cout_HA0,Cout_HA1,Cout_HA2,Cout_HA3;
  wire Cout_FA0,Cout_FA1,Cout_FA2,Cout_FA3;
  wire Cout_FA4,Cout_FA5,Cout_FA6;
  wire Cout_FA7,Cout_FA8,Cout_FA9;
  wire HA1_out;
  wire FA0_out,FA1_out,FA2_out,FA3_out,FA4_out,FA5_out,FA6_out;
  
  assign z_internal[0] = x[0] & y [0];
  
  half_adder half_adder_instance0(
      .A(x[1]&y[0]),
      .B(x[0]&y[1]),
      .Sum(z_internal[1]),
      .Cout(Cout_HA0)
  );
  
  full_adder full_adder_instance0(
      .A(x[1]&y[1] ),
      .B(x[0]&y[2]),
      .Cin(Cout_HA0),
      .Sum(FA0_out),
      .Cout(Cout_FA0)
  );
  
  full_adder full_adder_instance1(
      .A(x[1]&y[2]),
      .B(x[0]&y[3]),
      .Cin(Cout_FA0),
      .Sum(FA1_out),
      .Cout(Cout_FA1)
  );
  
  full_adder full_adder_instance2(
      .A(x[1]&y[3]),
      .B(x[0]&y[4]),
      .Cin(Cout_FA1),
      .Sum(FA2_out),
      .Cout(Cout_FA2)
  );
  
  half_adder half_adder_instance1(
      .A(x[1]&y[4]),
      .B(Cout_FA2),
      .Sum(HA1_out),
      .Cout(Cout_HA1)
  );
  
  half_adder half_adder_instance2(
      .A(x[2]&y[0]),
      .B(FA0_out),
      .Sum(z_internal[2]),
      .Cout(Cout_HA2)
  );
  
  full_adder full_adder_instance3(
      .A(x[2]&y[1]),
      .B(FA1_out),
      .Cin(Cout_HA2),
      .Sum(FA3_out),
      .Cout(Cout_FA3)
  );
  
  full_adder full_adder_instance4(
      .A(x[2]&y[2]),
      .B(FA2_out),
      .Cin(Cout_FA3),
      .Sum(FA4_out),
      .Cout(Cout_FA4)
  );
  
  full_adder full_adder_instance5(
      .A(x[2]&y[3]),
      .B(HA1_out),
      .Cin(Cout_FA4),
      .Sum(FA5_out),
      .Cout(Cout_FA5)
  );
  
  full_adder full_adder_instance6(
      .A(x[2]&y[4]),
      .B(Cout_HA1),
      .Cin(Cout_FA5),
      .Sum(FA6_out),
      .Cout(Cout_FA6)
  );
  
  half_adder half_adder_instance3(
      .A(x[3]&y[0]),
      .B(FA3_out),
      .Sum(z_internal[3]),
      .Cout(Cout_HA3)
  );
  
  full_adder full_adder_instance7(
      .A(x[3]&y[1]),
      .B(FA4_out),
      .Cin(Cout_HA3),
      .Sum(z_internal[4]),
      .Cout(Cout_FA7)
  );
  
  full_adder full_adder_instance8(
      .A(x[3]&y[2]),
      .B(FA5_out),
      .Cin(Cout_FA7),
      .Sum(z_internal[5]),
      .Cout(Cout_FA8)
  );
  
  full_adder full_adder_instance9(
      .A(x[3]&y[3]),
      .B(FA6_out),
      .Cin(Cout_FA8),
      .Sum(z_internal[6]),
      .Cout(Cout_FA9)
  );
  
  full_adder full_adder_instance10(
      .A(x[3]&y[4]),
      .B(Cout_FA6),
      .Cin(Cout_FA9),
      .Sum(z_internal[7]),
      .Cout(z_internal[8])
  );
  
  DReg #(
      .WIDTH(9)
  ) DReg_instance(
      .clk(clk),
      .rst_n(rst_n),
      .D(z_internal),
      .Q(z)
  );
endmodule 
