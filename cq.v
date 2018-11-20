module isEqual(input wire[2:0] din_a,din_b , output wire o);
    wire [2:0] t;
    xnor2 x[2:0] (din_a, din_b, t);
    and3 an1(t[2], t[1], t[0], o);
endmodule

module inc(input wire[2:0] din, output wire[2:0] dout);
    wire t1, t2, t3;
    fa f1(din[0], 1'b1, 1'b0, dout[0], t1);
    fa f2(din[1], 1'b0, t1, dout[1], t2);
    fa f3(din[2], 1'b0, t2, dout[2], t3);
endmodule

module ThreeBitReg(input wire clk, reset, load, input wire[2:0] inp, output wire [2:0] outp);
	dfrl dfrl_0(clk, reset, load, inp[0], outp[0]);
	dfrl dfrl_1(clk, reset, load, inp[1], outp[1]);
	dfrl dfrl_2(clk, reset, load, inp[2], outp[2]);
endmodule

module cq(input wire clk, reset, wr, rd, input wire[15:0] din, output wire empty, full, output wire[15:0] dout);
    // Local variables
    wire [2:0] rd_addr, wr_addr;
    wire [2:0] rd_inc, wr_inc;
    wire [15:0] fakeDout; 
    wire wr_load, rd_load;

    inc i2(wr_addr, wr_inc);
    inc i1(rd_addr, rd_inc);
    isEqual empty0(rd_addr, wr_addr, empty);
    isEqual full0(rd_addr, wr_inc, full);

    and2 rl(rd, !empty, rd_load);
    and2 wl(wr, !full, wr_load);

    ThreeBitReg read_addr (clk, reset, rd_load, rd_inc, rd_addr); 
    ThreeBitReg write_addr (clk, reset, wr_load, wr_inc, wr_addr);

    reg_file rf1 (clk, reset, wr_load, rd_addr[2:0], 3'b000, wr_addr[2:0], din[15:0], dout[15:0], fakeDout[15:0]); 
endmodule

`default_nettype wire