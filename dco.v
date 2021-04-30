module dco(
input clk,
input reset_n,
input add,
input plus,
input bothedge,

output reg  pwm_clk
);

parameter C =23;
reg [15:0]div_num;
always @(posedge clk or negedge reset_n)begin
	if(!reset_n)begin
		div_num <= C;
		end
	else if(add == 1)
		div_num <= div_num +1;
	else if(plus == 1)
		div_num <= div_num -1;
	else 
		div_num <= div_num;
end

reg [15:0]num;
always @(posedge clk or negedge reset_n)begin
	if(!reset_n)
		num <= 0;
	else if(bothedge == 1)
		num <= 0;
	else if(num >= div_num)
		num <= 0;
	else
		num <= num +1;
end

always @(posedge clk or negedge reset_n)begin
	if(!reset_n)
		pwm_clk <= 1;
	else if(num <=(div_num>>1))
		pwm_clk <= 0;
	else 
		pwm_clk <= 1;
end

endmodule
