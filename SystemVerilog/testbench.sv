`timescale 1ms / 1ps

module system_testbench;
	
	logic Init, Exp_increase, Exp_decrease, Clk, Reset; // input
	logic NRE_1, NRE_2, ADC, Expose, Erase;				// output
	logic Ovf, Start;
	real Clk_half_period = 0.5;
	reg [4:0] Initial;
	
	
	always
		begin
			Clk <= 1; #Clk_half_period;
			Clk <= 0; #Clk_half_period;
		end
	
	FSM_ex_control dut_FSM(
		.Clk(Clk),
		.Clk_half_period(Clk_half_period),
		.Reset(Reset), 
		.Init(Init),
		.Ovf4(Ovf4),
		.Ovf5(Ovf5),
		.ADC_control(ADC_control),
		.Exp_time(Initial),
		.NRE_1(NRE_1),
		.NRE_2(NRE_2),
		.ADC(ADC),
		.Expose(Expose),
		.Erase(Erase),
		.Start(Start));	   
		
	CTRL_ex_time dut_CTRL_ex_time(
		.Clk(Clk), 
		.Reset(Reset), 
		.Exp_increase(Exp_increase), 
		.Exp_decrease(Exp_decrease),
		.Exp_time(Initial));
			
		
	Timer_counter dut_Timer(
		.Start(Start),
		.Clk(Clk),
		.Reset(Reset),
		.Initial(Initial),
		.Ovf4(Ovf4),
		.Ovf5(Ovf5),
		.ADC_control(ADC_control));

	
	initial
		begin
			
			Reset <= 1; Init <= 0; Exp_increase <= 0; Exp_decrease <= 0; #(2*Clk_half_period);
			
			Reset <= 0; Init <= 1;  #(2*Clk_half_period);
			
			Init <= 0; #(14*Clk_half_period);

		end
	
endmodule