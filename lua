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
 
-- Jedna hlavní záložka
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
            spawn(function()
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
                spawn(function()
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

-- Jedna hlavní záložka
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
            spawn(function()
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
                spawn(function()
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
-- Sekce: Auto House
-- ===========================
MainTab:CreateSection("Auto House")

-- House 1
local AutoHouse1 = false
MainTab:CreateToggle({
    Name = "Auto House 1",
    CurrentValue = false,
    Callback = function(Value)
        AutoHouse1 = Value
        task.spawn(function()
            while AutoHouse1 do
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Plots_Invoke"):InvokeServer(unpack(args))
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Index: Request Hatch Count"):InvokeServer()
                local args = {
                    [1] = 1365,
                    [2] = "PurchaseEgg",
                    [3] = 1,
                    [4] = 3
                }
                task.wait(1)
            end
        end)
    end
})
 
-- House 2
local AutoHouse2 = false
MainTab:CreateToggle({
    Name = "Auto House 2",
    CurrentValue = false,
    Callback = function(Value)
        AutoHouse2 = Value
        task.spawn(function()
            while AutoHouse2 do
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Plots_Invoke"):InvokeServer(unpack(args))
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Index: Request Hatch Count"):InvokeServer()
                local args = {
                    [1] = 1365,
                    [2] = "PurchaseEgg",
                    [3] = 2,
                    [4] = 3
                }
                task.wait(1)
            end
        end)
    end
})

-- House 3
local AutoHouse3 = false
MainTab:CreateToggle({
    Name = "Auto House 3",
    CurrentValue = false,
    Callback = function(Value)
        AutoHouse3 = Value
        task.spawn(function()
            while AutoHouse3 do
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Plots_Invoke"):InvokeServer(unpack(args))
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Index: Request Hatch Count"):InvokeServer()
                local args = {
                    [1] = 1365,
                    [2] = "PurchaseEgg",
                    [3] = 3,
                    [4] = 3
                }
                task.wait(1)
            end
        end)
    end
})

-- House 4
local AutoHouse4 = false
MainTab:CreateToggle({
    Name = "Auto House 4",
    CurrentValue = false,
    Callback = function(Value)
        AutoHouse4 = Value
        task.spawn(function()
            while AutoHouse4 do
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Plots_Invoke"):InvokeServer(unpack(args))
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Index: Request Hatch Count"):InvokeServer()
                local args = {
                    [1] = 1365,
                    [2] = "PurchaseEgg",
                    [3] = 4,
                    [4] = 3
                }
                task.wait(1)
            end
        end)
    end
})

-- House 5
local AutoHouse5 = false
MainTab:CreateToggle({
    Name = "Auto House 5",
    CurrentValue = false,
    Callback = function(Value)
        AutoHouse5 = Value
        task.spawn(function()
            while AutoHouse5 do
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Plots_Invoke"):InvokeServer(unpack(args))
                game:GetService("ReplicatedStorage"):WaitForChild("Network"):WaitForChild("Index: Request Hatch Count"):InvokeServer()
                local args = {
                    [1] = 1365,
                    [2] = "PurchaseEgg",
                    [3] = 5,
                    [4] = 3
                }
                task.wait(1)
            end
        end)
    end
})
end
