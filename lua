-- PS99-Halloween GUI - Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Galaxy HUB",
    LoadingTitle = "Galaxy HUB",
    LoadingSubtitle = "by Galaxy HUB",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "PS99HalloweenConfig"
    },
    Discord = {Enabled = false},
    KeySystem = false
})

local MainTab = Window:CreateTab("PS99-Halloween")

-- ===========================
-- Sekce 1: Auto Pick Pets
-- ===========================
local autoPick = false
MainTab:CreateSection("Auto Pick Pets")

MainTab:CreateToggle({
    Name = "Auto Pick Pets",
    CurrentValue = false,
    Flag = "AutoPickPets",
    Callback = function(value)
        autoPick = value
        if autoPick then
            task.spawn(function()
                while autoPick do
                    for i = 1,10 do
                        local args = {[1]=i}
                        game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("HalloweenWorld_PickUp"):InvokeServer(unpack(args))
                    end
                    task.wait(0.5)
                end
            end)
        end
    end
})

-- ===========================
-- Sekce 2: Auto Egg
-- ===========================
MainTab:CreateSection("Auto Egg")
local eggToggles = {}

local eggList = {
    "Pumpkin Egg",
    "Coffin Egg",
    "Reaper Egg",
    "Spider Egg",
    "Cauldron Egg",
    "Ghost Egg",
    "Bat Egg",
    "Grave Egg"
}

for _, eggName in ipairs(eggList) do
    eggToggles[eggName] = false
    MainTab:CreateToggle({
        Name = eggName,
        CurrentValue = false,
        Flag = eggName.."Toggle",
        Callback = function(value)
            eggToggles[eggName] = value
            if value then
                task.spawn(function()
                    while eggToggles[eggName] do
                        for i=1,10 do
                            local args = {[1]=i,[2]=eggName}
                            game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("HalloweenWorld_PlaceEgg"):InvokeServer(unpack(args))
                        end
                        task.wait(0.5)
                    end
                end)
            end
        end
    })
end

-- ===========================
-- Sekce 3: Auto House
-- ===========================
MainTab:CreateSection("Auto House")

local function createAutoHouseToggle(name, houseNumber)
    local toggleValue = false
    MainTab:CreateToggle({
        Name = name,
        CurrentValue = false,
        Callback = function(value)
            toggleValue = value
            if toggleValue then
                task.spawn(function()
                    while toggleValue do
                        local args = {
                            [1] = 1365,
                            [2] = "PurchaseEgg",
                            [3] = houseNumber,
                            [4] = 3
                        }
                        local network = game:GetService("ReplicatedStorage"):WaitForChild("Network")
                        network:WaitForChild("Plots_Invoke"):InvokeServer(unpack(args))
                        network:WaitForChild("Index: Request Hatch Count"):InvokeServer()
                        task.wait(1)
                    end
                end)
            end
        end
    })
end

createAutoHouseToggle("Auto House 1", 1)
createAutoHouseToggle("Auto House 2", 2)
createAutoHouseToggle("Auto House 3", 3)
createAutoHouseToggle("Auto House 4", 4)
createAutoHouseToggle("Auto House 5", 5)
