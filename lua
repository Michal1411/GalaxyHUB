local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

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

local function getChar()
	local char = player.Character or player.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")
	local hum = char:WaitForChild("Humanoid")
	return char, hrp, hum
end

-- reálná chůze (bez tweenu a bez MoveToFinished bugů)
local function walkTo(hrp, hum, target)
	hum:MoveTo(target)

	while enabled do
		local dist = (hrp.Position - target).Magnitude
		if dist < 3 then
			break
		end
		task.wait(0.1)
	end
end

local function loop()
	task.spawn(function()
		while enabled do
			local _, hrp, hum = getChar()

			for _, point in ipairs(points) do
				if not enabled then return end
				walkTo(hrp, hum, point)
			end
		end
	end)
end

button.MouseButton1Click:Connect(function()
	enabled = not enabled

	if enabled then
		button.Text = "ON"
		button.BackgroundColor3 = Color3.fromRGB(50,200,50)
		loop()
	else
		button.Text = "OFF"
		button.BackgroundColor3 = Color3.fromRGB(200,50,50)
	end
end)
