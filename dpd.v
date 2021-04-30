//ref-n  control-n  ref-n+1  control-n+1   |	lead	lag
// 0        0         0           0	   |	0	0
// 0        0         0 	  1	   |	0	0
// 0        0         1           0	   |	1	0
// 0        0         1           1	   |	0	0
//					   
// 0        1         0           0	   |	0	0
// 0        1         0 	  1 	   |	0	stay
// 0        1         1 	  0	   |	1	0
// 0        1         1 	  1	   |	0	0
//					   
// 1        0         0 	  0	   |	0	0
// 1        0         0 	  1	   |	0	0
// 1        0         1 	  0	   |	1	0
// 1        0         1 	  1	   |	0	0
//					   	
// 1        1         0 	  0	   |	0	0
// 1        1         0 	  1	   |	0	1
// 1        1         1 	  0	   |	1	0
// 1        1         1 	  1	   |	0	0


module dpd(
input clk,
input reset_n,
input control_clk,
input ref_clk,
input start,

output reg lead,
output 	reg lag,
output wire bothedge

);

reg K;
always @(posedge clk or negedge reset_n)begin
if(!reset_n) K <=1'b0;
else K <=ref_clk;
end
assign bothedge = (ref_clk^K)&&ref_clk;

reg ref_clk_now,ref_clk_last,control_clk_now,control_clk_last;
always @(posedge clk or negedge reset_n)begin
if(!reset_n)begin
ref_clk_now <= 1'b0;
ref_clk_last <= 1'b0;
control_clk_now <= 1'b0;
control_clk_last <= 1'b0;
end
else begin
ref_clk_now <= ref_clk;
ref_clk_last <= ref_clk_now;
control_clk_now <= control_clk;
control_clk_last <= control_clk_now;
end
end

wire [3:0]data;
assign data = {ref_clk_last,control_clk_last,ref_clk_now,control_clk_now};
always @(*)
begin
	case(data)
	4'b0000:begin
		lead = 0;
		lag = 0;
		end
	4'b0001:begin
		lead = 0;
		lag = 0;
		end
	4'b0010:begin
		lead = 0;
		lag = 0;
		end
	4'b0011:begin
		lead = 0;//1
		lag = 0;
		end
	4'b0100:begin
		lead = 0;
		lag = 0;
		end
	4'b0101:begin
		lead = 0;
		lag = lag;
		end
	4'b0110:begin
		lead = 1;
		lag = 0;
		end
	4'b0111:begin
		lead = 0;
		lag = 0;
		end
	4'b1000:begin
		lead = 0;
		lag = 0;
		end
	4'b1001:begin
		lead = 0;
		lag = 0;
		end
	4'b1010:begin
		lead = lead;//1
		lag = 0;
		end
	4'b1011:begin
		lead = 0;
		lag = 0;
		end
	4'b1100:begin
		lead = 0;
		lag = 0;
		end
	4'b1101:begin
		lead = 0;
		lag = 1;
		end
	4'b1110:begin
		lead = 1;
		lag = 0;
		end
	4'b1111:begin
		lead = 0;
		lag = 0;
		end
	endcase
end
endmodule
