local isRacing = false -- flag to keep track of whether the player is already racing

script.Parent.MouseButton1Click:Connect(function()

	-- find the humanoid
	local player = game.Players.LocalPlayer
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")

	-- find the vehicle the humanoid is seated in
	local vehicle = humanoid.SeatPart and humanoid.SeatPart.Parent

	-- check if the vehicle exists and has a DriverSeat
	if vehicle and vehicle:FindFirstChild("DriveSeat") then
		if not isRacing then -- only start the race if the player is not already racing
			local carName = vehicle.Name
			game.ReplicatedStorage.Events.TeleportCar:FireServer(carName)
			wait(10)
			game.ReplicatedStorage.Events.StartRace:FireServer(carName)
			isRacing = true -- set the flag to true when the race starts
		else
			print("You're already racing!") -- inform the player that they're already racing
		end
	else
		print("You must be seated in a vehicle with a DriverSeat to start the race.")
	end
end)