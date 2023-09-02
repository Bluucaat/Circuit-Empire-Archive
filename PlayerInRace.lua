--Variables--
local EventFolder = game.ReplicatedStorage.Events
local player = game.Players.LocalPlayer
local SpawnCheckpoint = EventFolder.SpawnCheckpoint

local PlayerCheckpoints = game.ReplicatedStorage.PlayerCheckpoints
local Checkpoints = game.Workspace.Checkpoints

local raceEnded = true  -- set raceEnded to true initially to allow starting a new race

SpawnCheckpoint.OnClientEvent:Connect(function(CheckNum)

	local NextCheck = ""

	if CheckNum == "32" then

		local Checkpoint = PlayerCheckpoints:FindFirstChild("Finish")
		player.leaderstats.Cash.Value += 15000
		local CloneCheckpoint = Checkpoint:Clone()

		NextCheck = tostring(tonumber(CheckNum + 1))

		CloneCheckpoint.Parent = Checkpoints

		CloneCheckpoint.Touched:Connect(function(hit)
			if hit.Name == "RacePart" then
				CloneCheckpoint:Destroy()
				raceEnded = true  -- set raceEnded to true when the race ends
				EventFolder.EndRace:FireServer()
			end
		end)
	else
		local Checkpoint = PlayerCheckpoints:FindFirstChild(CheckNum)
		local CloneCheckpoint = Checkpoint:Clone()

		NextCheck = tostring(tonumber(CheckNum + 1))

		CloneCheckpoint.Parent = Checkpoints

		CloneCheckpoint.Touched:Connect(function(hit)
			if hit.Name == "RacePart" then
				CloneCheckpoint:Destroy()
				SpawnCheckpoint:FireServer(NextCheck)
			end
		end)
	end
end)

script.Parent.MouseButton1Click:Connect(function()

	-- check if the player is already in a race
	if not raceEnded then
		print("You are already in a race.")
		return
	end

	-- start the race
	game.ReplicatedStorage.Events.StartRace:FireServer()
	raceEnded = false  -- set raceEnded to false to prevent starting a new race until the current race has ended
end)