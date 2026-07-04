-- Spustí se na straně hráče (LocalScript)
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Seznam tvých souřadnic (Waypoints) tak, jak jdou po sobě
local waypoints = {
    Vector3.new(1832, 16, -32046),
    Vector3.new(1976, 16, -32046),
    Vector3.new(1976, 16, -32014),
    Vector3.new(1832, 16, -32014),
    Vector3.new(1832, 16, -31990),
    Vector3.new(1976, 16, -31990),
    Vector3.new(1976, 16, -31965),
    Vector3.new(1832, 16, -31965),
    Vector3.new(1832, 16, -32046) -- Návrat na první bod pro opakování
}

local isEnabled = false

-- Funkce, která bezpečně dovede postavu k jednomu bodu
local function moveToPosition(targetPosition)
    while isEnabled do
        local character = player.Character
        if not character then task.wait(0.5); continue end
        
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        
        if humanoid and rootPart then
            -- Kontrola, jestli už jsme blízko cíle (na méně než 4 study)
            if (rootPart.Position - targetPosition).Magnitude < 4 then
                break
            end
            -- Zadání příkazu k chůzi
            humanoid:MoveTo(targetPosition)
        end
        task.wait(0.1) -- Krátká pauza, aby se Roblox nezasekl
    end
end

-- Hlavní smyčka, která prochází trasu od začátku
local function startMoving()
    while isEnabled do
        for _, point in ipairs(waypoints) do
            if not isEnabled then break end
            moveToPosition(point)
        end
        task.wait(0.1)
    end
end

-- --- TVORBA TABULKY / TLAČÍTKA VLEVO DOLE ---
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AutoWalkGui"
screenGui.ResetOnSpawn = false -- UI nezmizí, když postava umře
screenGui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 140, 0, 50)
frame.Position = UDim2.new(0, 20, 1, -70) -- Pozice vlevo dole
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, -12, 1, -12)
button.Position = UDim2.new(0, 6, 0, 6)
button.BackgroundColor3 = Color3.fromRGB(220, 50, 50) -- Výchozí červená (OFF)
button.Text = "AUTO: OFF"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 16
button.Parent = frame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = button

-- --- LOGIKA ZAPNUTÍ A VYPNUTÍ ---
button.MouseButton1Click:Connect(function()
    isEnabled = not isEnabled
    
    if isEnabled then
        button.Text = "AUTO: ON"
        button.BackgroundColor3 = Color3.fromRGB(50, 220, 50) -- Zelená (ON)
        task.spawn(startMoving) -- Spustí chůzi ve vlastním procesu od prvního bodu
    else
        button.Text = "AUTO: OFF"
        button.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        
        -- Okamžitě zastaví postavu na místě, kde zrovna stojí
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoid and rootPart then
                humanoid:MoveTo(rootPart.Position)
            end
        end
    end
end)
