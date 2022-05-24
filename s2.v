`timescale 10ns / 100ps



module s2(
    input clk,
    input [15:0]data,
    output reg ready,
    //�ٶ�valid������ʱ �Ѿ����һ��
    input valid,
    output [15:0]data_out
    );
    
reg [15:0]datareg;
//����һ������
reg [31:0]data_cache;
//���valid�½���
reg [1:0]valid_ff;
wire valid_neg;
wire valid_pos;

initial 
begin 
     datareg  = 16'd0;
     ready = 1'd0;
     valid_ff = 2'd0;
end

always@(posedge clk)
begin
    valid_ff[0] <= valid;
    valid_ff[1] <= valid_ff[0];
end

always@(posedge clk)
begin
    data_cache[15:0] <= data;
    data_cache[32:16] <= data_cache[15:0];
end

assign valid_neg = valid_ff[0] & ~valid;
assign valid_pos = ~valid_ff[0] & valid;
assign data_out = datareg;

always@(posedge clk)
begin
    //���ֳɹ���ȡ������ ���ݳ���ȡ����validʱ�� �ӳ�һ�Ĳ�Ӱ�쳤��
    if(valid & ready)
          begin
            datareg <= data_cache[15:0];
          end
    else
        begin
            datareg <= datareg;
        end
end

always@(negedge clk)
begin
//׼������
    if(valid_pos & (~ready))
        begin
            ready <= 1'd1;
        end
    if(valid_neg & ready)
        begin
            ready <= 1'd0;
        end
end


endmodule
