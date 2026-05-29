`timescale 1ns / 1ps

module tb_VGA_sync();
    reg clk;
    reg reset;
    wire hsync, vsync, video_on;
    wire [9:0] px, py;

    VGA_sync VGA_sync(
        .clk(clk),
        .reset(reset),
        .hsync(hsync),
        .vsync(vsync),
        .video_on(video_on),
        .px(px),
        .py(py)
    );
    
    initial clk = 0;
    always #20 clk = ~clk; //25MHz
    
    initial begin
        reset = 1;
        #20;
        reset = 0;
    end
  
endmodule
