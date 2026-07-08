-- =============================================================================
-- JUNKIE DEVELOPMENT KEY SYSTEM (GALAXY HUB)
-- =============================================================================
local JunkieDev = loadstring(game:HttpGet("https://githubusercontent.com"))()

local Config = {
    ServiceId = "27720", -- Vaše ID, které vidíte v Junkie panelu
    ApiKey    = "aaebe0f5-f5e9-4119-b465-3097ba8e7ce6", -- Váš tajný API klíč z Junkie panelu
    Provider  = "Junkie"
}

local KeySystem = JunkieDev:Initialize(Config)

-- Kontrola klíče a HWID (Hráči se ukáže výběr LootLabs / Linkvertise)
if not KeySystem:Verify() then
    KeySystem:CopyLink() -- Hráči to automaticky zkopíruje vybraný odkaz do schránky
    
    -- Upozornění přímo na herní obrazovce Robloxu
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "GalaxyHUB",
        Text = "Klíč nenalezen! Odkaz pro získání klíče byl zkopírován.",
        Duration = 10
    })
    return -- Zastaví spuštění skriptu
end

print("GalaxyHUB: Ověření úspěšné! Spouštím AutoWalk...")

-- =============================================================================
-- ZDE NÁSLEDUJE VÁŠ PŮVODNÍ AUTOWALK SKRIPT
-- =============================================================================
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local waypoints = {
    Vector3.new(1832, 16, -32046),
    Vector3.new(1976, 16, -32046),
    Vector3.new(2120, 16, -32046),
    Vector3.new(2264, 16, -32046),
    Vector3.new(2408, 16, -32046),
    Vector3.new(2552, 16, -32046),
    Vector3.new(2696, 16, -32046),
    Vector3.new(2840, 16, -32046),
    Vector3.new(2984, 16, -32046),
    Vector3.new(3128, 16, -32046),
    Vector3.new(3272, 16, -32046),
    Vector3.new(3416, 16, -32046),
    Vector3.new(3560, 16, -32046),
    Vector3.new(3704, 16, -32046),
    Vector3.new(3848, 16, -32046),
    Vector3.new(3992, 16, -32046),
    Vector3.new(4136, 16, -32046),
    Vector3.new(4280, 16, -32046)
}

local currentWaypointIndex = 1
local isEnabled = false
local tweenService = game:GetService("TweenService")
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GalaxyHubGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 12)
uiCorner.Parent = frame

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 160, 0, 40)
toggleButton.Position = UDim2.new(0.5, -80, 0.5, -20)
toggleButton.Text = "AutoWalk: OFF"
toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 18
toggleButton.Parent = frame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = toggleButton

local function moveToNextWaypoint()
    if not isEnabled then return end
    
    character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        rootPart = character.HumanoidRootPart
        local targetPosition = waypoints[currentWaypointIndex]
        local distance = (rootPart.Position - targetPosition).Magnitude
        local speed = 50 
        local duration = distance / speed
        
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear)
        local tween = tweenService:Create(rootPart, tweenInfo, {CFrame = CFrame.new(targetPosition)})
        
        tween:Play()
        tween.Completed:Connect(function(playbackState)
            if playbackState == Enum.PlaybackState.Completed then
                currentWaypointIndex = currentWaypointIndex + 1
                if currentWaypointIndex > #waypoints then
                    currentWaypointIndex = 1 
                end
                if isEnabled then
                    moveToNextWaypoint()
                end
            end
        end)
    end
end

toggleButton.MouseButton1Click:Connect(function()
    isEnabled = not isEnabled
    if isEnabled then
        toggleButton.Text = "AutoWalk: ON"
        toggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        moveToNextWaypoint()
    else
        toggleButton.Text = "AutoWalk: OFF"
        toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    rootPart = character:WaitForChild("HumanoidRootPart")
    if isEnabled then
        moveToNextWaypoint()
    end
end)
