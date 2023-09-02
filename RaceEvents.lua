--Variables--
local EventFolder = game.ReplicatedStorage.Events
local TeleportCar = EventFolder.TeleportCar
local StartRace = EventFolder.StartRace
local EndRace = EventFolder.EndRace
local ChangePlace = EventFolder.ChangePlace
local SpawnCheckpoint = EventFolder.SpawnCheckpoint
local player = game.Players.LocalPlayer

local PlayerCheckpoints = game.ReplicatedStorage.PlayerCheckpoints
local Checkpoints = game.Workspace.Checkpoints

local SpawnLocations = game.Workspace.RaceSpawnLocations
local numSpawnLocations = #SpawnLocations:GetChildren() -- number of available spawn locations
local takenSpawnLocations = {} -- table to keep track of taken spawn locations

--Events--
TeleportCar.OnServerEvent:Connect(function(player, carName, userId)
	local car = game.Workspace:FindFirstChild(carName)

	-- find the next available spawn location
	local spawnSlot = nil
	for i = 1, numSpawnLocations do
		if not takenSpawnLocations[i] then -- if spawn location is not taken
			spawnSlot = i
			break
		end
	end

	-- assign the next available spawn location to the player
	if spawnSlot then
		takenSpawnLocations[spawnSlot] = true -- mark spawn location as taken
		local userIdTag = Instance.new("IntValue", car)
		userIdTag.Name = "OwnerId"
		userIdTag.Value = userId
		car:SetPrimaryPartCFrame(SpawnLocations:FindFirstChild(tostring(spawnSlot)).CFrame)
		car.PrimaryPart.Anchored = true
	else
		warn("No available spawn locations")
	end

end)

StartRace.OnServerEvent:Connect(function(player, carName)
	local car = game.Workspace:FindFirstChild(carName)
	car.PrimaryPart.Anchored = false

	SpawnCheckpoint:FireClient(player, "1")
end)

SpawnCheckpoint.OnServerEvent:Connect(function(player, CheckNum)
	SpawnCheckpoint:FireClient(player, CheckNum)
end)

