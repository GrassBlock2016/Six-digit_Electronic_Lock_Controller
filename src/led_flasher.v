// ״̬��������ʮ�ε���˸
module led_flasher(
    input clk,
    input start,
    output reg led
);
    reg [3:0] flash_count;
    reg [1:0] state;	// ״̬����
    parameter IDLE = 2'b00, FLASH = 2'b01, DONE = 2'b10; // �ֱ��Ӧ��˸ǰ����˸�к���˸������״̬

    always @(posedge clk) begin
        case (state)	// ���ݲ�ͬ��״̬������Ӧ
            IDLE: begin
                if (start) begin
                    state <= FLASH;
                    flash_count <= 0;
                    led <= 0;
                end else begin
                    led <= 0;
                end
            end
            FLASH: begin
                led <= ~led;
                flash_count <= flash_count + 1;
                if (flash_count == 10) begin
                    state <= DONE;
                end
            end
            DONE: begin
                led <= 0;
                state <= IDLE;
            end
        endcase
    end
endmodule
