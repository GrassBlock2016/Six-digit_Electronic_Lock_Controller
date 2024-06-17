// ���ƵƵ���˸
module led_flasher (
    input wire clk,       		// ʱ���źţ�1Hz
    input wire switch,    		// �����ź�
    output reg led,        		// LED���
	output reg flash_end_flag 	// ��˸�������ź�
);
    reg [3:0] second_count;  // ��ʱ�Ĵ���������10��
    reg blinking;            // ��־�Ĵ�����ָʾ�Ƿ�������˸

    always @(posedge clk) begin
        if (switch) begin
            if (!blinking) begin
                // ���ر����£���ʼ���������ͱ�־
                blinking <= 1;
                second_count <= 0;
            end else if (second_count < 10) begin
                // ��ʱ�����У�LED��˸
                second_count <= second_count + 1;
                led <= ~led;
            end else begin
                // ��ʱ������ֹͣ��˸
                blinking <= 0;
                led <= 0;
				flash_end_flag <= 1'b1;
            end
        end else begin
            // ����δ�����£���������״̬
            blinking <= 0;
            second_count <= 0;
            led <= 0;
        end
    end
endmodule
