-- Define variables
local player = game.Players.LocalPlayer
local carInventory = {} -- Empty table to hold car inventory
local carButton = script.Parent -- The button the user can click to access the inventory
-- Define variables
local player = game.Players.LocalPlayer
local carInventory = {} -- Empty table to hold car inventory
local carButton = script.Parent -- The button the user can click to access the inventory

-- Function to update the car inventory GUI
local function updateCarInventoryGUI()
	-- Remove any previous car inventory GUI
	for _, child in ipairs(carButton.Parent:GetChildren()) do
		if child:IsA("Frame") and child.Name == "CarInventoryGUI" then
			child:Destroy()
		end
	end

	-- Create new car inventory GUI
	local gui = Instance.new("Frame")
	gui.Name = "CarInventoryGUI"
	gui.Size = UDim2.new(0, 200, 0, 200)
	gui.Position = UDim2.new(0.5, -100, 0.5, -100)
	gui.BackgroundTransparency = 0.5
	gui.BackgroundColor3 = Color3.new(0, 0, 0)
	gui.BorderSizePixel = 3
	gui.Parent = carButton.Parent

	-- Populate car inventory GUI
	for i, car in ipairs(carInventory) do
		local carFrame = Instance.new("Frame")
		carFrame.Name = "Car"..i
		carFrame.Size = UDim2.new(1, 0, 0, 25)
		carFrame.Position = UDim2.new(0, 0, 0, 25*(i-1))
		carFrame.BackgroundColor3 = Color3.new(1, 1, 1)
		carFrame.BorderSizePixel = 2
		carFrame.Parent = gui

		local carNameLabel = Instance.new("TextLabel")
		carNameLabel.Name = "CarName"
		carNameLabel.Size = UDim2.new(0.8, 0, 1, 0)
		carNameLabel.Position = UDim2.new(0.1, 0, 0, 0)
		carNameLabel.BackgroundTransparency = 1
		carNameLabel.Text = car.Name
		carNameLabel.Font = Enum.Font.SourceSansBold
		carNameLabel.TextColor3 = Color3.new(0, 0, 0)
		carNameLabel.TextSize = 18
		carNameLabel.TextXAlignment = Enum.TextXAlignment.Left
		carNameLabel.Parent = carFrame

		local spawnButton = Instance.new("TextButton")
		spawnButton.Name = "SpawnButton"
		spawnButton.Size = UDim2.new(0.2, 0, 1, 0)
		spawnButton.Position = UDim2.new(0.8, 0, 0, 0)
		spawnButton.BackgroundColor3 = Color3.new(1, 0, 0)
		spawnButton.BorderSizePixel = 2
		spawnButton.Font = Enum.Font.SourceSansBold
		spawnButton.Text = "Spawn"
		spawnButton.TextColor3 = Color3.new(1, 1, 1)
		spawnButton.TextSize = 18
		spawnButton.Parent = carFrame

		-- Function to spawn car when button is clicked
		spawnButton.MouseButton1Click:Connect(function()
			local carClone = car:Clone()
			carClone.Parent = workspace
			carClone:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame)
			table.remove(carInventory, i)
			updateCarInventoryGUI()
		end)
	end
end

-- Function to add a car to the inventory
local function addCarToInventory(car)
	table.insert(carInventory)
	end