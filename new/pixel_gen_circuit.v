`timescale 1ns / 1ps
module pixel_gen_circuit (
    input  wire clk,
    input  wire reset,
    input  wire [9:0] px,
    input  wire [9:0] py,
    input  wire video_on,
    output reg  [3:0] vga_r,
    output reg  [3:0] vga_g,
    output reg  [3:0] vga_b
);
 
    // Square boundaries (200x200 pixels, centred on 640x480)
    localparam SQUARE_X0 = 220;
    localparam SQUARE_X1 = 420;
    localparam SQUARE_Y0 = 140;
    localparam SQUARE_Y1 = 340;
 
    wire square;
    assign square = (px >= SQUARE_X0 && px < SQUARE_X1) &&
                    (py >= SQUARE_Y0 && py < SQUARE_Y1);
 
    always @(*) begin
        if (!video_on) begin
            // Blanking interval - must output black
            vga_r = 4'h0;
            vga_g = 4'h0;
            vga_b = 4'h0;
        end else if (square) begin
            // White square
            vga_r = 4'hF;
            vga_g = 4'hF;
            vga_b = 4'hF;
        end else begin
            // Blue background
            vga_r = 4'h1;
            vga_g = 4'h3;
            vga_b = 4'h7;
        end
    end
endmodule
 