module reset (

    input reset_switch,   // 重置开关

    output reg [3:0] out1, out2, out3, out4, out5, out6,  // 重置输出
	
input clk            // 时钟信号

);

    

	always @(posedge clk or posedge reset_switch) begin
		if (reset_switch) begin
            // 当重置开关被触发时，将所有输出重置为 0000
			out1 <= 4'b0000;
          
			out2 <= 4'b0000;
			out3 <= 4'b0000;
			out4 <= 4'b0000;
			out5 <= 4'b0000;
			out6 <= 4'b0000;
		end
	end

	
endmodule