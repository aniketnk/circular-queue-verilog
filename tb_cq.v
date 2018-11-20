`timescale 1 ns / 100 ps
`define TESTVECS 20

module tb;
  reg clk, reset, wr, rd;
  wire full, empty;
  reg [15:0] din;
  wire [15:0] dout;
  reg [17:0] test_vecs [0:(`TESTVECS-1)];
  integer i;
  initial begin $dumpfile("tb_cq.vcd"); $dumpvars(0,tb); end
  initial begin reset = 1'b1; #12.5 reset = 1'b0; end
  initial clk = 1'b0; always #5 clk =~ clk;
  initial begin
  test_vecs[0][17] = 1'b1; test_vecs[0][16] = 1'b0; test_vecs[0][15:0] = 16'ha;
  test_vecs[1][17] = 1'b0; test_vecs[1][16] = 1'b1; test_vecs[1][15:0] = 16'hxx;
  test_vecs[2][17] = 1'b1; test_vecs[2][16] = 1'b0; test_vecs[2][15:0] = 16'h1;
  test_vecs[3][17] = 1'b0; test_vecs[3][16] = 1'b1; test_vecs[3][15:0] = 16'hxx;
  test_vecs[4][17] = 1'b1; test_vecs[4][16] = 1'b0; test_vecs[4][15:0] = 16'h2;
  test_vecs[5][17] = 1'b0; test_vecs[5][16] = 1'b1; test_vecs[5][15:0] = 16'hxx;
  test_vecs[6][17] = 1'b0; test_vecs[6][16] = 1'b1; test_vecs[6][15:0] = 16'hxx;
  test_vecs[7][17] = 1'b1; test_vecs[7][16] = 1'b0; test_vecs[7][15:0] = 16'h4;
  test_vecs[8][17] = 1'b0; test_vecs[8][16] = 1'b1; test_vecs[8][15:0] = 16'hxx;
  test_vecs[9][17] = 1'b1; test_vecs[9][16] = 1'b0; test_vecs[9][15:0] = 16'h9;
  test_vecs[10][17] = 1'b1; test_vecs[10][16] = 1'b0; test_vecs[10][15:0] = 16'h6;
  test_vecs[11][17] = 1'b0; test_vecs[11][16] = 1'b1; test_vecs[11][15:0] = 16'hxx;
  test_vecs[12][17] = 1'b1; test_vecs[12][16] = 1'b0; test_vecs[12][15:0] = 16'h5;
  test_vecs[13][17] = 1'b1; test_vecs[13][16] = 1'b0; test_vecs[13][15:0] = 16'h8;
  test_vecs[14][17] = 1'b0; test_vecs[14][16] = 1'b1; test_vecs[14][15:0] = 16'hxx;
  test_vecs[15][17] = 1'b0; test_vecs[15][16] = 1'b1; test_vecs[15][15:0] = 16'hxx;
  test_vecs[16][17] = 1'b1; test_vecs[16][16] = 1'b0; test_vecs[16][15:0] = 16'h7;
  test_vecs[17][17] = 1'b0; test_vecs[17][16] = 1'b1; test_vecs[17][15:0] = 16'hxx;
  test_vecs[18][17] = 1'b1; test_vecs[18][16] = 1'b0; test_vecs[18][15:0] = 16'h3;
  test_vecs[19][17] = 1'b0; test_vecs[19][16] = 1'b1; test_vecs[19][15:0] = 16'hxx;
  end
  initial {wr, rd, din} = 0;
  cq cq_0 (clk, reset, wr, rd, din[15:0], empty, full, dout[15:0]);
  initial begin
      #6 for(i=0;i<`TESTVECS;i=i+1)
        begin #10 {wr, rd, din}=test_vecs[i]; end
      #10 $finish;
  end
endmodule