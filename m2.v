`timescale 10ns / 100ps


module m2(
    input clk,
    output [15:0]data,
    output reg valid,
    input  ready
    );
    
reg [15:0]datareg;
reg [15:0]datastro;
reg initialization_master;
reg [2:0]datacount;
assign data = datareg;

initial 
begin 
     datareg = 15'd0;
     datastro = 15'd0;
     initialization_master = 1'd0;
     datacount = 3'd0;
     valid <=1'd0;
end

always@(posedge clk)
begin
     datastro <= datastro + 16'd1;
end

//��ǰ����һ������
reg [15:0]data_ff;
always@(posedge clk or posedge ready)
begin
    if(initialization_master)
        begin
            //���ݳ��ȵ���
            if( datacount == 3'd7)
                begin   
                    valid<=1'd0;
                end
            else 
                begin   
                    valid<=1'd1;
                end
            
            if(ready)
            begin
                datacount <= datacount + 3'd1;
                //��ֹԽ��
                if( datacount == 3'd7)
                    begin   
                       datareg <= {13'd0,datacount}+16'd1;
                    end
                else 
                //����ʱ��
                    begin   
                       datareg <= {13'd0,datacount+1}+16'd1;
                    end
                end
            else
              begin
                 datareg <= {13'd0,datacount}+16'd1;
              end
        end
    else
        begin
            valid<=1'd0;
            datareg <= 16'd0;
        end
end

always@(posedge clk)
begin
    // �ٶ�data��valid ͬʱ׼������
   if(datacount == 3'd7)
       begin
           initialization_master <= 1'd0;
       end
   else 
       if (datacount == 3'd0)
           begin
               begin
               if(datastro & 16'd8)
                 begin
                    initialization_master <= 1'd1;
                 end
               else
                begin
                    initialization_master <= 1'd0;
                end
               end
           end
       else
           begin
                initialization_master <= initialization_master;
           end
end

endmodule
