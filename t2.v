`timescale 10ns / 100ps



module t2(

    );
    
    wire  [15:0]data;
    wire  valid;
    wire  ready;
    wire  [5:0]data_out;
    reg rx_valid;
    reg tx_ready;
    reg rx_data_out;
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
   assign  ready_late = ready;
   always@(posedge clk)
   begin
        valid_late_reg <= valid_late;
   end

    m1 m1_2(
        .clk(clk),
        .data(data),
        .valid(valid),
        .ready(ready_late)
    );
  
    s2 s2_1(
        .clk(clk),
        .data(data),
        .valid(valid_late_reg),
        .ready(ready),
        .data_out(data_out)
    );
    
    
endmodule
