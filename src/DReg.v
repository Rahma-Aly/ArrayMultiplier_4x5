module DReg #(parameter WIDTH = 9)(
	input                  clk,
	input                  rst_n,
	input  [WIDTH-1:0]     D,
	output reg [WIDTH-1:0] Q
);

	always @(posedge clk or negedge  rst_n) begin
	    if (~rst_n) begin
	        Q <= 'b0;
	    end
	    else begin
	        Q <= D;
	    end    
	end
	
endmodule
