`timescale 1ns / 1ps
module SelectionOfAvatar(
	input [1:0] mode,
	input [5:0] userID,
	input [1:0] candidate, // 00:Air 01:Fire, 10:Earth, 11: Water
	input CLK,
	output reg [1:0] ballotBoxId,
	output reg [5:0] numberOfRegisteredVoters,
	output reg [5:0] numberOfVotesWinner, // number of votes of winner
	output reg [1:0] WinnerId,
	output reg AlreadyRegistered,
	output reg AlreadyVoted,
	output reg NotRegistered,
	output reg VotingHasNotStarted,
	output reg RegistrationHasEnded
	);
	reg [1:0] registercount [63:0];
	reg [7:0] counter;
	reg [5:0] votecount [3:0];
	integer i;
	
	initial begin
		// ...
		counter = 0;
		for (i = 0; i < 64; i = i + 1) begin
      		registercount[i] = 0;
    	end
		for (i = 0; i < 4; i = i + 1) begin
      		votecount[i] = 0;
    	end
		numberOfRegisteredVoters = 0;
		numberOfVotesWinner = 0;
		WinnerId =0 ;
		
	end

	always @(posedge CLK)
	begin
		// ...
		AlreadyRegistered = 0;
		AlreadyVoted = 0;
		NotRegistered = 0;
		VotingHasNotStarted = 0;
		RegistrationHasEnded = 0;
		counter = counter+1;
		if(counter<=100)begin
			ballotBoxId = userID[5:4];
			if(mode == 0)begin				
				if(registercount[userID] == 0)begin
					registercount[userID] = 1;
					numberOfRegisteredVoters = numberOfRegisteredVoters + 1;
				end
				else if(registercount[userID] == 1)begin
					AlreadyRegistered = 1;
				end
			end
			else if(mode == 1)begin
				VotingHasNotStarted = 1;
			end
		end
		else if(counter<=200)begin
			ballotBoxId = userID[5:4];
			if(mode == 1)begin
				if(registercount[userID] == 1)begin
					registercount[userID] = 2;
					votecount[candidate] = votecount[candidate]+1;
				end
				else if(registercount[userID] == 0)begin
					NotRegistered = 1;
				end
				else if(registercount[userID] == 2)begin
					AlreadyVoted = 1;
				end

				
			end
			else if(mode == 0)begin
				RegistrationHasEnded = 1;
			end

		end
		else begin
			if(votecount[1]> votecount[WinnerId]) begin
				WinnerId = 1;
				numberOfVotesWinner = votecount[1];
			end
			if(votecount[2]> votecount[WinnerId]) begin
				WinnerId = 2;
				numberOfVotesWinner = votecount[2];
			end
			if(votecount[3]> votecount[WinnerId]) begin
				WinnerId = 3;
				numberOfVotesWinner = votecount[3];
			end
			
			
		end


	end

endmodule
