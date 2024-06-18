// 控制灯的闪烁
module led_flasher (
    input wire clk,       		// 时钟信号，1Hz
    input wire switch,    		// 开关信号
    output reg led        		// LED输出
);
    reg [3:0] second_count;  // 计时寄存器，计数10秒
    reg blinking;            // 标志寄存器，指示是否正在闪烁
	reg switch_prev;         // 记录上一个时钟周期的开关状态

    always @(posedge clk) begin
		switch_prev <= switch;
	
        if (!switch_prev && switch) begin
        // 开关从关闭到打开的瞬间，初始化计数器和标志
			blinking <= 1;
			second_count <= 0;
			led <= 0;
		end
		
		if (blinking) begin
		    if (second_count < 10) begin
		    // 计时进行中，LED跟随时钟闪烁
				second_count <= second_count + 1;
				led <= ~led;
			end else begin
			// 计时结束，停止闪烁
			    blinking <= 0;
			    led <= 0;
			end
			
		end else begin
		// 如果没有在闪烁，则保持LED关闭
		    led <= 0;
		end
    end
endmodule