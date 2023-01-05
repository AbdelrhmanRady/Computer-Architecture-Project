`include "APB_Protocol.v"

`timescale 1ns/1ns

module APB_Protocol_tb;
 
    reg pclk;
    reg penable;
    reg pwrite;
    reg transfer;
    reg Reset;
    reg [4:0] write_paddr;
    reg [4:0] apb_read_paddr;
    reg [31:0] write_data;
    reg [1:0] Psel;
    reg rx = 1;

    wire [31:0] apb_read_data_out;
    integer i;

   
    APB_Protcol A1 (pclk, penable, pwrite, transfer, Reset, write_paddr, apb_read_paddr, write_data, Psel, apb_read_data_out,rx);


    initial begin
    $dumpfile("dump2.vcd");
    $dumpvars(0,APB_Protocol_tb);
  
        pclk = 1'b0;
        penable = 1'b0;
        pwrite = 1'b0;
        transfer = 1'b0;
        Reset = 1'b0;
        write_paddr = 32'h00000000;
        apb_read_paddr = 32'h00000000;
        write_data = 32'h00000000;
        Psel = 2'b00;

        #30;
        
    

        Psel = 2'b01;
        transfer = 1'b1;

        penable = 1'b1;
        pwrite = 1'b1;
        write_paddr = 1'b1;
        write_data = 32'hEF131025;
        #30 


        pwrite = 1'b0;
        apb_read_paddr = 1'b1;
        #30; 
        pwrite = 1'b1;
        write_paddr = 2'b10;
        write_data = 32'hAAA;
        #30;
        pwrite=1'b0;
        apb_read_paddr = 2'b10;
        #30;
        Psel = 1'b0;
        #30
        penable = 1'b0;

    

        Psel = 2'b10;
        transfer = 1'b1;
        #10;
    

        pwrite = 1'b1;
        for( i = 0 ; i < 10 ; i=i+1) begin
            #10
            write_data = $urandom % 256;
            penable = 1'b1;
            #10
            penable = 1'b0;
        end

        #100


        penable = 1;
        pwrite = 0;
        #13
        penable = 0;

        #30

        rx = 0; 
        #10
        rx = 1;
        #10
        rx = 1;
        #10
        rx = 1;
        #10
        rx = 0;
        #10
        rx = 0;
        #10
        rx = 0;
        #10
        rx = 1;
        #10
        rx = 0;
        #10
        rx = 1; 
        #10
        pwrite = 1'b0;

     
        rx = 0; 
        #10
        rx = 1;
        #10
        rx = 1;
        #10
        rx = 0;
        #10
        rx = 1;
        #10
        rx = 0;
        #10
        rx = 1;
        #10
        rx = 1;
        #10
        rx = 1;
        #10
        rx = 1; 
        #10

        pwrite = 1'b0;
        penable = 1'b1;
        #13
        penable = 1'b0;
        #100
        penable = 1'b1;
        #13
        penable = 1'b0;
        #100
        penable = 1'b1;
        #13
        penable = 1'b0;
    end


    always #5 pclk <= ~pclk;
endmodule
