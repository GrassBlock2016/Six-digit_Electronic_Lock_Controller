// 错误计数器，记录错误次数
module error_counter(
	input j,	// 传入判断
	input rd,
    input correct,
    output reg [1:0] error_count
);
    always @(negedge rd) begin	// 当j上升沿开始计数
		if(j) begin
        	if (correct) begin
            	error_count <= 2'b00;
        	end else if (error_count < 2'b11) begin
            	if (error_count == 2'b00) begin
					error_count <= 2'b01;
				end else if (error_count == 2'b01) begin
					error_count <= 2'b10;
				end else if (error_count == 2'b10) begin
					error_count <= 2'b11;
				end
        	end
    	end 
	end
endmodule
