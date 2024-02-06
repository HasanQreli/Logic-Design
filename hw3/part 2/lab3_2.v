`timescale 1ns / 1ps
module lab3_2(
			input[5:0] money,
			input CLK,
			input vm, //0:VM0, 1:VM1
			input [2:0] productID, //000:sandwich, 001:chocolate, 11x: dont care
			input sugar, //0: No sugar, 1: With Sugar
			output reg [5:0] moneyLeft,
			output reg [4:0] itemLeft,
			output reg productUnavailable,//1:show warning, 0:do not show warning
			output reg insufficientFund , //1:full, 0:not full
			output reg notExactFund , //1:full, 0:not full
			output reg invalidProduct, //1: empty, 0:not empty
			output reg sugarUnsuitable, //1: empty, 0:not empty
			output reg productReady	//1:door is open, 0:closed
	);




	// Internal State of the Module
	// (you can change this but you probably need this)
	reg [4:0] numOfSandwiches;
	reg [4:0] numOfChocolate;
	reg [4:0] numOfWaterVM1;
	reg [4:0] numOfWaterVM2;
	reg [4:0] numOfCoffee;
	reg [4:0] numOfTea;

	initial
	begin
		// You can initialize here
    	// ...
		
		
		numOfSandwiches = 10;
		numOfChocolate = 10;
		numOfWaterVM1 = 5;
		numOfWaterVM2 = 10;
		numOfCoffee = 10;
		numOfTea = 10;
	end

	//Modify the lines below to implement your design
	always @(posedge CLK)
	begin
		// You can implement your code here
    	// ...
		productUnavailable = 0;
		insufficientFund = 0;
		notExactFund = 0;
		invalidProduct = 0;
		sugarUnsuitable = 0;
		productReady = 0;
		moneyLeft = money;
		
		if(vm == 0) begin
			if(productID == 3'b011 || productID == 3'b100 || productID == 3'b101 || productID == 3'b110 ||productID == 3'b111) begin
				invalidProduct = 1;
			end
			else if((productID == 3'b000 && numOfSandwiches == 0) || (productID == 3'b001 && numOfChocolate == 0) || (productID == 3'b010 && numOfWaterVM1 == 0)) begin
				productUnavailable = 1;		
			end
			else if((productID == 3'b000 && moneyLeft != 20) || (productID == 3'b001 && moneyLeft != 10) || (productID == 3'b010 && moneyLeft != 5))begin
				notExactFund = 1;
			end
			else begin
				moneyLeft = 0;
				productReady = 1;
				if(productID == 3'b000) itemLeft = --numOfSandwiches;
				else if(productID == 3'b001) itemLeft = --numOfChocolate;
				else if(productID == 3'b010) itemLeft = --numOfWaterVM1;
			end			
		end
		else if(vm == 1) begin
			if(productID == 3'b000 || productID == 3'b001 || productID == 3'b101 || productID == 3'b110 ||productID == 3'b111) 
				invalidProduct = 1;
			else if((productID == 3'b010 && numOfWaterVM2 == 0) || (productID == 3'b011 && numOfCoffee == 0) || (productID == 3'b100 && numOfTea == 0))
				productUnavailable = 1;
			else if(sugar && productID == 3'b010) 
				sugarUnsuitable = 1;			
			else if((productID == 3'b010 && moneyLeft < 5) || (productID == 3'b011 && moneyLeft < 12) || (productID == 3'b100 && moneyLeft < 8)) begin
				insufficientFund = 1;
			end
			else begin				
				productReady = 1;
				if(productID == 3'b010) begin
					itemLeft =--numOfWaterVM2;
					moneyLeft = money-5;
				end
				else if(productID == 3'b011) begin
					itemLeft = --numOfCoffee;
					moneyLeft = money-12;
				end
				else if(productID == 3'b100) begin
					itemLeft =--numOfTea;
					moneyLeft = money-8;
				end
			end			
		end
	end


endmodule



