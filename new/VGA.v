`timescale 1ns / 1ps

module VGA(
    input wire clk,
    input wire reset,
    output wire hsync,
    output wire vsync,
    output wire [3:0] vga_r,
    output wire [3:0] vga_g,
    output wire [3:0] vga_b
    );
    wire clk_out1;
    wire locked;
    wire video_on;
    wire [9:0] px, py;
    
    //Brings Basys 3 100.000MHz clk down to 25.000MHz clk
    VGA_25MHz VGA_25MHz( 
        .clk_in1(clk),
        .reset(reset),
        .clk_out1(clk_out1),
        .locked(locked)
    );
    
    //might need some logic here to indicate locked has been set so we can now sample
    wire rst;
    assign rst = reset | ~locked;
    
    VGA_sync VGA_sync(
        .clk(clk_out1),
        .reset(rst),
        .hsync(hsync),
        .vsync(vsync),
        .video_on(video_on),
        .px(px),
        .py(py)
    );
    
    pixel_gen_circuit pixel_gen_circuit (
        .clk(clk_out1),
        .reset(rst),
        .px(px),
        .py(py),
        .video_on(video_on),
        .vga_r(vga_r),
        .vga_g(vga_g),
        .vga_b(vga_b)
    );
endmodule
