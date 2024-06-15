module mode_switch_checker(

    input m,          // mode �л��ź�

    input res,        // �ȽϽ��

    output reg error_flag // �����־

);

    
	always @(negedge m) begin
		if (!res) begin
			error_flag <= 1;
		end else begin

			error_flag <= 0;
		end
    
	end
endmodule