module uart_top(
    input  wire clk,
    input  wire rst,
    input  wire start_tx,
    input  wire [7:0] data_in,
    output wire tx_line,
    output wire [7:0] data_out,
    output wire rx_ready
);

    wire tx_busy;
    wire baud_clk;

    // Baud rate generator
    baud_gen #(.DIVIDER(16)) baud_gen_inst (
        .clk(clk),
        .rst(rst),
        .baud_clk(baud_clk)
    );

    // UART TX
    uart_tx tx_inst (
        .clk(baud_clk),
        .rst(rst),
        .start_tx(start_tx),
        .data_in(data_in),
        .tx_line(tx_line),
        .busy(tx_busy)
    );

    // UART RX
    uart_rx rx_inst (
        .clk(baud_clk),
        .rst(rst),
        .rx_line(tx_line),
        .data_out(data_out),
        .data_ready(rx_ready)
    );

endmodule
