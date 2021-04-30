module tb();
reg clk;
reg reset_n;
reg ref_clk;
reg control_clk;


initial begin
	$dumpfile("wave.vcd");
	$dumpvars(0,tb);
end

initial begin
clk = 0;
forever #5 clk=~clk;
end

initial begin
reset_n = 0;

#100 reset_n = 1;
end

initial begin
#1000 ref_clk = 0;
forever # 50000 ref_clk = ~ref_clk;
end

initial begin
#20000 control_clk =0;
#50000 control_clk =1;
#50000 control_clk =0;
#30000 control_clk =1;
#50000 control_clk =0;
forever #50000 control_clk = ~control_clk;

end
wire pwm_clk;
wire lead,lag,bothedge;
dpd u_dpd(
.clk(clk),
.reset_n(reset_n),
.control_clk(control_clk),
.ref_clk(ref_clk),
.start(),
.lead(lead),
.lag(lag),
.bothedge(bothedge)
);
dco u_dco(
.clk(clk),
.reset_n(reset_n),
.add(lead),
.plus(lag),
.bothedge(bothedge),
.pwm_clk(pwm_clk)
);
endmodule
