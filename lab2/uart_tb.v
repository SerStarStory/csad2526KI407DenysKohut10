`timescale 1ns/1ns

module uart_tb;
    reg clk;
    reg rst;
    reg start_tx;
    reg [7:0] data_in;
    wire tx_line;
    wire [7:0] data_out;
    wire rx_ready;

    initial clk = 0;
    always #10 clk = ~clk; // 20 ns period, 50MHz clock

    initial begin
        rst = 1;
        start_tx = 0;
        data_in = 8'h41; // 'A'
        #100 rst = 0;

        // 'A'
        #200 start_tx = 1;
        #40 start_tx = 0;

        // wait
        #2000;

        // 'B'
        data_in = 8'h42;
        start_tx = 1;
        #40 start_tx = 0;

        #4000;
        $stop;
    end

    uart_top uut (
        .clk(clk),
        .rst(rst),
        .start_tx(start_tx),
        .data_in(data_in),
        .tx_line(tx_line),
        .data_out(data_out),
        .rx_ready(rx_ready)
    );

endmodule
