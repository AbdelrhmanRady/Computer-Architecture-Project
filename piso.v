module Piso(clk,control,DataIn,DataOut);
  input clk;
  input control;
  input [7:0] DataIn;
  output reg DataOut;
  reg [7:0]temp;
 
  always @(posedge clk)
  begin 
    if(control==0)
      begin
      temp<=DataIn;
      end
    else
    begin
        DataOut<=temp[0];
        temp<=temp>>1;
      end
  end
endmodule



  