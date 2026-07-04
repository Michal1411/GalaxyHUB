local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

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
local currentTween

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

local function moveTo(character, pos)
	local hrp = character:WaitForChild("HumanoidRootPart")

	local distance = (hrp.Position - pos).Magnitude
	local speed = 16 -- rychlost
	local time = distance / speed

	currentTween = TweenService:Create(
		hrp,
		TweenInfo.new(time, Enum.EasingStyle.Linear),
		{CFrame = CFrame.new(pos)}
	)

	currentTween:Play()
	currentTween.Completed:Wait()
end

local function startLoop()
	task.spawn(function()
		local character = player.Character or player.CharacterAdded:Wait()

		while enabled do
			character = player.Character or player.CharacterAdded:Wait()

			for _, point in ipairs(points) do
				if not enabled then
					if currentTween then
						currentTween:Cancel()
					end
					return
				end

				moveTo(character, point)
			end
			-- automaticky pokračuje znovu od prvního bodu
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

		if currentTween then
			currentTween:Cancel()
		end
	end
end)
