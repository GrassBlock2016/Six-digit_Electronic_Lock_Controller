// �������������¼�������
module error_counter(
	input j,	// �����ж�
    input correct,
    output reg [1:0] error_count
);
    always @(negedge j) begin	// ��j�½��ؿ�ʼ����
        if (correct) begin
            error_count <= 2'b00;
        end else if (error_count < 2'b11) begin
            error_count <= error_count + 1;
        end
    end
endmodule
