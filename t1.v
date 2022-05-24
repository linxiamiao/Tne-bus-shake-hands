`timescale 10ns / 100ps



module t1(

    );
    
    wire  [15:0]data;
    wire  valid;
    wire  ready;
    wire  [15:0]data_out;
    reg clk;
    wire data_late;
    wire valid_late;
    wire ready_late;
    initial
    begin
        clk <= 1'd1;
    end
    always@(*)
    begin
        //cycle = 20ns, 50Mhz
        #5 clk <= ~clk;    
    end
   assign  valid_late = valid;
//   assign  data_late = data;
   assign  ready_late = ready;

    m1 m1_1(
        .clk(clk),
        .data(data),
        .valid(valid),
        .ready(ready_late)
    );
    
    s1 s1_1(
        .clk(clk),
        .data(data),
        .valid(valid_late),
        .ready(ready),
        .data_out(data_out)
    );
    
    
endmodule
