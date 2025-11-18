module uart_rx(
    input clk,
    input rst,
    input rx_line,
    output reg [7:0] data_out,
    output reg data_ready
);
    reg [3:0] bit_cnt;
    reg [7:0] shift_reg;
    reg receiving;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            receiving <= 0;
            data_ready <= 0;
            bit_cnt <= 0;
            data_out <= 0;
        end else begin
            if (!receiving && rx_line == 0) begin // стартовий біт
                receiving <= 1;
                bit_cnt <= 0;
                data_ready <= 0;
            end else if (receiving) begin
                shift_reg <= {rx_line, shift_reg[7:1]};
                bit_cnt <= bit_cnt + 1;
                if (bit_cnt == 7) begin
                    data_out <= shift_reg;
                    data_ready <= 1;
                    receiving <= 0;
                end
            end else begin
                data_ready <= 0;
            end
        end
    end
endmodule
