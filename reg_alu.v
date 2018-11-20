// Write code for modules you need here


module reg_file (input wire clk, reset, wr, input wire [2:0] rd_addr_a, rd_addr_b, wr_addr, input wire [15:0] d_in, output wire [15:0] d_out_a, d_out_b);

// Declare wires here
	wire [15:0] t0, t1, t2, t3, t4, t5, t6, t7, reg_op0, reg_op1,  reg_op2,  reg_op3,  reg_op4,  reg_op5,  reg_op6,  reg_op7;
	wire [0:7] wrload;

// Instantiate modules here

	STBitDemux8 writer(wr_addr, d_in, t0, t1, t2, t3, t4, t5, t6, t7);

	demux8 load_demux(wr, wr_addr[2], wr_addr[1], wr_addr[0], wrload);

	STBitReg reg_0(clk, reset, wrload[0], d_in, reg_op0);
	STBitReg reg_1(clk, reset, wrload[1], d_in, reg_op1);
	STBitReg reg_2(clk, reset, wrload[2], d_in, reg_op2);
	STBitReg reg_3(clk, reset, wrload[3], d_in, reg_op3);
	STBitReg reg_4(clk, reset, wrload[4], d_in, reg_op4);
	STBitReg reg_5(clk, reset, wrload[5], d_in, reg_op5);
	STBitReg reg_6(clk, reset, wrload[6], d_in, reg_op6);
	STBitReg reg_7(clk, reset, wrload[7], d_in, reg_op7);

	STBitMux8 read_a(rd_addr_a, reg_op0, reg_op1,  reg_op2,  reg_op3,  reg_op4,  reg_op5,  reg_op6,  reg_op7, d_out_a);
	STBitMux8 read_b(rd_addr_b, reg_op0, reg_op1,  reg_op2,  reg_op3,  reg_op4,  reg_op5,  reg_op6,  reg_op7, d_out_b);

endmodule


module reg_alu (input wire clk, reset, sel, wr, input wire [1:0] op, input wire [2:0] rd_addr_a,
		rd_addr_b, wr_addr, input wire [15:0] d_in, output wire [15:0] d_out_a, d_out_b, output wire cout);

// Declare wires here
	wire [15:0] alu_outp, reg_din;
	wire alu_cout;

// Instantiate modules here
	reg_file reg_m(clk, reset, wr, rd_addr_a, rd_addr_b, wr_addr, reg_din, d_out_a, d_out_b);
	STBitMux2 din_mux(d_in, alu_outp, sel, reg_din);
	alu alu_m(op, d_out_a, d_out_b, alu_outp, alu_cout);
	dfr cout_dfr(clk, reset, alu_cout, cout);
	
endmodule

module STBitReg(input wire clk, rst, load, input wire[15:0] inp, output wire [15:0] outp);

	dfrl dfrl_0( clk, rst, load, inp[0], outp[0] );
	dfrl dfrl_1( clk, rst, load, inp[1], outp[1] );
	dfrl dfrl_2( clk, rst, load, inp[2], outp[2] );
	dfrl dfrl_3( clk, rst, load, inp[3], outp[3] );
	dfrl dfrl_4( clk, rst, load, inp[4], outp[4] );
	dfrl dfrl_5( clk, rst, load, inp[5], outp[5] );
	dfrl dfrl_6( clk, rst, load, inp[6], outp[6] );
	dfrl dfrl_7( clk, rst, load, inp[7], outp[7] );
	dfrl dfrl_8( clk, rst, load, inp[8], outp[8] );
	dfrl dfrl_9( clk, rst, load, inp[9], outp[9] );
	dfrl dfrl_10( clk, rst, load, inp[10], outp[10] );
	dfrl dfrl_11( clk, rst, load, inp[11], outp[11] );
	dfrl dfrl_12( clk, rst, load, inp[12], outp[12] );
	dfrl dfrl_13( clk, rst, load, inp[13], outp[13] );
	dfrl dfrl_14( clk, rst, load, inp[14], outp[14] );
	dfrl dfrl_15( clk, rst, load, inp[15], outp[15] );

endmodule

module STBitDemux8(input wire [2:0] s, input wire [15:0] inp, output [15:0] o0, o1, o2, o3, o4, o5, o6, o7);

	demux8 b_0( inp[0], s[2], s[1], s[0], { o0[0], o1[0], o2[0], o3[0], o4[0], o5[0], o6[0], o7[0] } );
	demux8 b_1( inp[1], s[2], s[1], s[0], { o0[1], o1[1], o2[1], o3[1], o4[1], o5[1], o6[1], o7[1] } );
	demux8 b_2( inp[2], s[2], s[1], s[0], { o0[2], o1[2], o2[2], o3[2], o4[2], o5[2], o6[2], o7[2] } );
	demux8 b_3( inp[3], s[2], s[1], s[0], { o0[3], o1[3], o2[3], o3[3], o4[3], o5[3], o6[3], o7[3] } );
	demux8 b_4( inp[4], s[2], s[1], s[0], { o0[4], o1[4], o2[4], o3[4], o4[4], o5[4], o6[4], o7[4] } );
	demux8 b_5( inp[5], s[2], s[1], s[0], { o0[5], o1[5], o2[5], o3[5], o4[5], o5[5], o6[5], o7[5] } );
	demux8 b_6( inp[6], s[2], s[1], s[0], { o0[6], o1[6], o2[6], o3[6], o4[6], o5[6], o6[6], o7[6] } );
	demux8 b_7( inp[7], s[2], s[1], s[0], { o0[7], o1[7], o2[7], o3[7], o4[7], o5[7], o6[7], o7[7] } );
	demux8 b_8( inp[8], s[2], s[1], s[0], { o0[8], o1[8], o2[8], o3[8], o4[8], o5[8], o6[8], o7[8] } );
	demux8 b_9( inp[9], s[2], s[1], s[0], { o0[9], o1[9], o2[9], o3[9], o4[9], o5[9], o6[9], o7[9] } );
	demux8 b_10( inp[10], s[2], s[1], s[0], { o0[10], o1[10], o2[10], o3[10], o4[10], o5[10], o6[10], o7[10] } );
	demux8 b_11( inp[11], s[2], s[1], s[0], { o0[11], o1[11], o2[11], o3[11], o4[11], o5[11], o6[11], o7[11] } );
	demux8 b_12( inp[12], s[2], s[1], s[0], { o0[12], o1[12], o2[12], o3[12], o4[12], o5[12], o6[12], o7[12] } );
	demux8 b_13( inp[13], s[2], s[1], s[0], { o0[13], o1[13], o2[13], o3[13], o4[13], o5[13], o6[13], o7[13] } );
	demux8 b_14( inp[14], s[2], s[1], s[0], { o0[14], o1[14], o2[14], o3[14], o4[14], o5[14], o6[14], o7[14] } );
	demux8 b_15( inp[15], s[2], s[1], s[0], { o0[15], o1[15], o2[15], o3[15], o4[15], o5[15], o6[15], o7[15] } );

endmodule

module STBitMux8(input wire [2:0] s, input wire [15:0] i0, i1, i2, i3, i4, i5, i6, i7, output wire [15:0] out);

	mux8 b_0( { i0[0], i1[0], i2[0], i3[0], i4[0], i5[0], i6[0], i7[0] }, s[0], s[1], s[2], out[0] );
	mux8 b_1( { i0[1], i1[1], i2[1], i3[1], i4[1], i5[1], i6[1], i7[1] }, s[0], s[1], s[2], out[1] );
	mux8 b_2( { i0[2], i1[2], i2[2], i3[2], i4[2], i5[2], i6[2], i7[2] }, s[0], s[1], s[2], out[2] );
	mux8 b_3( { i0[3], i1[3], i2[3], i3[3], i4[3], i5[3], i6[3], i7[3] }, s[0], s[1], s[2], out[3] );
	mux8 b_4( { i0[4], i1[4], i2[4], i3[4], i4[4], i5[4], i6[4], i7[4] }, s[0], s[1], s[2], out[4] );
	mux8 b_5( { i0[5], i1[5], i2[5], i3[5], i4[5], i5[5], i6[5], i7[5] }, s[0], s[1], s[2], out[5] );
	mux8 b_6( { i0[6], i1[6], i2[6], i3[6], i4[6], i5[6], i6[6], i7[6] }, s[0], s[1], s[2], out[6] );
	mux8 b_7( { i0[7], i1[7], i2[7], i3[7], i4[7], i5[7], i6[7], i7[7] }, s[0], s[1], s[2], out[7] );
	mux8 b_8( { i0[8], i1[8], i2[8], i3[8], i4[8], i5[8], i6[8], i7[8] }, s[0], s[1], s[2], out[8] );
	mux8 b_9( { i0[9], i1[9], i2[9], i3[9], i4[9], i5[9], i6[9], i7[9] }, s[0], s[1], s[2], out[9] );
	mux8 b_10( { i0[10], i1[10], i2[10], i3[10], i4[10], i5[10], i6[10], i7[10] }, s[0], s[1], s[2], out[10] );
	mux8 b_11( { i0[11], i1[11], i2[11], i3[11], i4[11], i5[11], i6[11], i7[11] }, s[0], s[1], s[2], out[11] );
	mux8 b_12( { i0[12], i1[12], i2[12], i3[12], i4[12], i5[12], i6[12], i7[12] }, s[0], s[1], s[2], out[12] );
	mux8 b_13( { i0[13], i1[13], i2[13], i3[13], i4[13], i5[13], i6[13], i7[13] }, s[0], s[1], s[2], out[13] );
	mux8 b_14( { i0[14], i1[14], i2[14], i3[14], i4[14], i5[14], i6[14], i7[14] }, s[0], s[1], s[2], out[14] );
	mux8 b_15( { i0[15], i1[15], i2[15], i3[15], i4[15], i5[15], i6[15], i7[15] }, s[0], s[1], s[2], out[15] );

endmodule

module STBitMux2(input [15:0] i0, i1, input s, output [15:0] o);
    mux2 op_0( i0[0], i1[0], s, o[0] );
    mux2 op_1( i0[1], i1[1], s, o[1] );
    mux2 op_2( i0[2], i1[2], s, o[2] );
    mux2 op_3( i0[3], i1[3], s, o[3] );
    mux2 op_4( i0[4], i1[4], s, o[4] );
    mux2 op_5( i0[5], i1[5], s, o[5] );
    mux2 op_6( i0[6], i1[6], s, o[6] );
    mux2 op_7( i0[7], i1[7], s, o[7] );
    mux2 op_8( i0[8], i1[8], s, o[8] );
    mux2 op_9( i0[9], i1[9], s, o[9] );
    mux2 op_10( i0[10], i1[10], s, o[10] );
    mux2 op_11( i0[11], i1[11], s, o[11] );
    mux2 op_12( i0[12], i1[12], s, o[12] );
    mux2 op_13( i0[13], i1[13], s, o[13] );
    mux2 op_14( i0[14], i1[14], s, o[14] );
    mux2 op_15( i0[15], i1[15], s, o[15] );
endmodule
