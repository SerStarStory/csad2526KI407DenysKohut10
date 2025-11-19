module uart_tx(
    input clk,
    input rst,
    input start_tx,
    input [7:0] data_in,
    output reg tx_line,
    output reg busy
);
    reg [3:0] bit_cnt;
    reg [7:0] shift_reg;
    reg sending;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx_line <= 1;
            busy <= 0;
            sending <= 0;
            bit_cnt <= 0;
        end else begin
            if (start_tx && !sending) begin
                shift_reg <= data_in;
                sending <= 1;
                busy <= 1;
                bit_cnt <= 0;
                tx_line <= 0; // стартовий біт
            end else if (sending) begin
                if (bit_cnt < 8) begin
                    tx_line <= shift_reg[0];
                    shift_reg <= shift_reg >> 1;
                    bit_cnt <= bit_cnt + 1;
                end else begin
                    tx_line <= 1; // стоп біт
                    sending <= 0;
                    busy <= 0;
                end
            end
        end
    end
endmodule
