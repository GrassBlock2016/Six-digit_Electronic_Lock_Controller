module mode_switch_checker(

    input m,          // mode 切换信号

    input res,        // 比较结果

    output reg error_flag // 错误标志

);

    
	always @(negedge m) begin
		if (!res) begin
			error_flag <= 1;
		end else begin

			error_flag <= 0;
		end
    
	end
endmodule