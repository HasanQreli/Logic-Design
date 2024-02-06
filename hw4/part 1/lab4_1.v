`timescale 1ns / 1ps

module ROM (
input [2:0] addr,
output reg [7:0] dataOut);

	// write your ROM code here
	always @(*)
	begin
    if (addr == 3'b000)
      dataOut = 8'b00000000;
    else if (addr == 1)
      dataOut = 8'b01010101;
    else if (addr == 3'b010)
      dataOut = 8'b10101010;
    else if (addr == 3'b011)
      dataOut = 8'b00110011;
    else if (addr == 3'b100)
      dataOut = 8'b11001100;
    else if (addr == 3'b101)
      dataOut = 8'b00001111;
    else if (addr == 3'b110)
      dataOut = 8'b11110000;
    else if (addr == 3'b111)
      dataOut = 8'b11111111;
    else
      dataOut = 8'b00000000; // Default value if address is out of range
  end


endmodule

module Difference_RAM (
input mode,
input [2:0] addr,
input [7:0] dataIn,
input [7:0] mask,
input CLK,
output reg [7:0] dataOut);

	// write your XOR_RAM code here
	reg [7:0] memory [0:7]; // 8x8-bit memory array
	integer i;
	initial
	begin
		dataOut = 0;
		for (i = 0; i <= 7; i = i + 1) begin
      		memory[i] = 0;
    	end
	end

	

	always @(posedge CLK)
  	begin
    	if (mode == 0) begin
      		if (dataIn >= mask)
        		memory[addr] = dataIn - mask;
      		else
        		memory[addr] = mask - dataIn;
    	end
  	end

  	always @(*)
  	begin
    	if (mode == 1) begin
      		dataOut = memory[addr];
    	end
  	end


endmodule


module EncodedMemory (
input mode,
input [2:0] index,
input [7:0] number,
input CLK,
output [7:0] result);

	wire [7:0] mask;

	ROM R(index, mask);
	Difference_RAM DR(mode, index, number, mask, CLK, result);

endmodule


