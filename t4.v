`timescale 10ns / 100ps



module t4(

    );
    
    wire  [15:0]data;
    wire  valid;
    wire  ready;
    wire  [15:0]data_out;
    reg ready_late_reg;
    reg valid_late_reg;
    reg clk;

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
   //#1 ~ #5没问题
   //引入总线延时
   assign #2 valid_late = valid;
   assign #2 ready_late = ready;
   always@(posedge clk)
   begin
        ready_late_reg <= ready_late;
        valid_late_reg <= valid_late;
   end

    m2 m2_2(
        .clk(clk),
        .data(data),
        .valid(valid),
        .ready(ready_late_reg)
    );
  
    s2 s2_2(
        .clk(clk),
        .data(data),
        .valid(valid_late_reg),
        .ready(ready),
        .data_out(data_out)
    );
    
    
endmodule