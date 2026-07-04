local Players = game:GetService("Players")

local player = Players.LocalPlayer

-- Body trasy
local points = {
	Vector3.new(1832, 16, -32046),
	Vector3.new(1976, 16, -32046),
	Vector3.new(1976, 16, -32014),
	Vector3.new(1832, 16, -32014),
	Vector3.new(1832, 16, -31990),
	Vector3.new(1976, 16, -31990),
	Vector3.new(1976, 16, -31965),
	Vector3.new(1832, 16, -31965),
}

local enabled = false

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "AutoWalkGUI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 120, 0, 40)
button.Position = UDim2.new(0, 10, 1, -50)
button.Text = "OFF"
button.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
button.TextColor3 = Color3.new(1,1,1)
button.Parent = gui

-- normální chůze
local function moveTo(character, pos)
	local humanoid = character:WaitForChild("Humanoid")

	humanoid:MoveTo(pos)

	local reached = humanoid.MoveToFinished:Wait()
	return reached
end

-- hlavní smyčka
local function startLoop()
	task.spawn(function()
		while enabled do
			local character = player.Character or player.CharacterAdded:Wait()

			for _, point in ipairs(points) do
				if not enabled then return end

				local reached = moveTo(character, point)

				if not reached then
					break
				end
			end
		end
	end)
end

button.MouseButton1Click:Connect(function()
	enabled = not enabled

	if enabled then
		button.Text = "ON"
		button.BackgroundColor3 = Color3.fromRGB(50,200,50)
		startLoop()
	else
		button.Text = "OFF"
		button.BackgroundColor3 = Color3.fromRGB(200,50,50)
	end
end)
