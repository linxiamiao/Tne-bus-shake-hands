`timescale 10ns / 100ps

module m1(
    input clk,
    output [15:0]data,
    output reg valid,
    input  ready
    );
    
reg [15:0]datareg;
reg [15:0]datastro;
assign data = datareg;

initial 
begin 
     datareg = 15'd0;
     datastro = 15'd0;
end

always@(posedge clk)
begin
    datastro <= datastro + 1;
end

always@(posedge clk)
begin
    // 假定data和valid 同时准备好了
    if(datastro & 15'd8)
       begin 
            valid <= 1'd1;
            datareg <= datastro;
       end
    else
       begin
            valid <= 1'd0;
            datareg <= 32'd0;
       end
end


endmodule
