// ���ƵƵ���˸
module led_flasher (
    input wire clk,       		// ʱ���źţ�1Hz
    input wire switch,    		// �����ź�
    output reg led        		// LED���
);
    reg [3:0] second_count;  // ��ʱ�Ĵ���������10��
    reg blinking;            // ��־�Ĵ�����ָʾ�Ƿ�������˸
	reg switch_prev;         // ��¼��һ��ʱ�����ڵĿ���״̬

    always @(posedge clk) begin
		switch_prev <= switch;
	
        if (!switch_prev && switch) begin
        // ���شӹرյ��򿪵�˲�䣬��ʼ���������ͱ�־
			blinking <= 1;
			second_count <= 0;
			led <= 0;
		end
		
		if (blinking) begin
		    if (second_count < 10) begin
		    // ��ʱ�����У�LED����ʱ����˸
				second_count <= second_count + 1;
				led <= ~led;
			end else begin
			// ��ʱ������ֹͣ��˸
			    blinking <= 0;
			    led <= 0;
			end
			
		end else begin
		// ���û������˸���򱣳�LED�ر�
		    led <= 0;
		end
    end
endmodule