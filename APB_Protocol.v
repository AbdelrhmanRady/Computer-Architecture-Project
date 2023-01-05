`include "APB_bus.v"
`include "gpio.v"
`include "UART.v"



module APB_Protcol (
    input  PCLK,  PENABLE,  PWRITE,  transfer,PRESETn,
    input [4:0] apb_writeAddr,apb_readAddr,
	input [31:0] apb_writeData,
    
    input [1:0] Psel,
    output [31:0] apb_readData_out,
    input rx
);
        
        reg PREADY ;
        reg [31:0] PRDATA;
        wire [31:0] PWDATA;
        wire[4:0]PADDR;
        wire PSEL1,PSEL2;
        wire [31:0]PRDATA1,PRDATA2;
        wire PREADY1,PREADY2;
        wire READ_WRITE;

always @(Psel or PREADY1 or PRDATA1 or PREADY2 or PRDATA2 ) begin
    case (Psel)
        1 : begin
            PREADY <= PREADY1;
            PRDATA <= PRDATA1;
        end 
        2 : begin
            PREADY <= PREADY2;
            PRDATA <= PRDATA2;

        end
        default: begin
            PREADY <= 0;
            PRDATA <= 0;
        end 
    endcase
end

        master_bridge bridge(
        PCLK,  PENABLE,  PWRITE,  transfer,PRESETn,Psel,apb_writeAddr,apb_readAddr,apb_writeData,// From Tb
        PREADY,PRDATA,READ_WRITE,PENABLE, 
        PWDATA,PADDR,PSEL1,PSEL2 
        ,apb_readData_out 
        ); 

        GPIO g1(  PCLK , PENABLE ,READ_WRITE,PSEL1,PRESETn,PWDATA,PADDR,PREADY1,PRDATA1 );

  
    UART uart (
       
        
    );

    
    
endmodule