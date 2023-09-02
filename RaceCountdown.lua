local start = {}

for i = 0, 9, 1 do
	start[i] = game.Workspace.RaceSpawnLocations.FindFirstChild(tostring(i+1))
end


local time_val = 5
timer_started = false
local completed = false

local time_label = script.Parent
time_label.Visible = false

local LPlayer = game.Players.LocalPlayer




local function start_timer(otherPart)
	local player = game.Players:FindFirstChild(otherPart.Parent.Name)
	if player.Name == LPlayer.Name and not timer_started then
		d
		timer_started = true
		time_label.Text = time_val
		player.PlayerGui.Timer.Label.Visible = true
	end
end

for i = 0, 9, 1 
do
	start[i].Touched:Connect(start_timer)
end
