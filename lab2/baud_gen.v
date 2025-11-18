module baud_gen #(
    parameter DIVIDER = 16
)(
    input  wire clk,
    input  wire rst,
    output reg baud_clk
);
    reg [15:0] counter;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter  <= 0;
            baud_clk <= 0;
        end else if (counter == (DIVIDER-1)) begin
            counter  <= 0;
            baud_clk <= ~baud_clk;
        end else begin
            counter <= counter + 1;
        end
    end
endmodule
