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
