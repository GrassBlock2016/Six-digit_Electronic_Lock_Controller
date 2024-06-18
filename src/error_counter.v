// �������������¼�������
module error_counter(
	input j,	// �����ж�
	input clk,
    input correct,
    output reg [1:0] error_count
);
    always @(negedge clk) begin
		if (j) begin
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
			//	error_count <= error_count + 1;
        	end else begin
				error_count <= 2'b00;
			end
		end
	end
endmodule
