local Arqel = loadstring(game:HttpGet("https://cdn.jnkie.com/arquelui.lua"))()



Arqel.Appearance.Title = "Galaxy HUB"

Arqel.Appearance.Icon = "rbxassetid://84366838202681"

Arqel.Links.Discord = "https://discord.gg/CjM6gnpj2"

Arqel.Storage.FileName = "Galaxy_key"

-- Arqel.Options.KeylessUI = true





Arqel.Theme.Accent = Color3.fromRGB(110, 60, 255)

Arqel.Theme.AccentHover = Color3.fromRGB(130, 90, 255)

Arqel.Theme.Background = Color3.fromRGB(10, 10, 20)

Arqel.Theme.Header = Color3.fromRGB(15, 15, 30)

Arqel.Theme.Input = Color3.fromRGB(20, 20, 40)

Arqel.Theme.Text = Color3.fromRGB(255, 255, 255)

Arqel.Theme.TextDim = Color3.fromRGB(160, 160, 200)

Arqel.Theme.Success = Color3.fromRGB(0, 220, 180)

Arqel.Theme.Error = Color3.fromRGB(255, 70, 90)

Arqel.Theme.StatusIdle = Color3.fromRGB(120, 100, 200)





Arqel.Shop = {

    Enabled = true,

    Icon = "",

    Title = "Get Premium",

    Subtitle = "Instant delivery • 24/7 support",

    ButtonText = "Buy",

    Link = "https://discord.gg/CjM6gnpj2"

}





Arqel:LaunchJunkie({

    Service = "GalaxyHUB",

    Identifier = "1150081",

    Provider = "Galaxy HUB key"

})

task.spawn(function()
    print("[Debug] Checking for Junkie status...")
    
    -- Wait up to 10 seconds for the status
    local timeout = 10
    local startTime = tick()
    
    while getgenv().JD_IS_PREMIUM == nil and (tick() - startTime) < timeout do
        task.wait(1)
        print("[Debug] Still waiting for auth result...")
    end
    
    if getgenv().JD_IS_PREMIUM ~= nil then
        print("[Debug] Auth Success! Status: " .. tostring(getgenv().JD_IS_PREMIUM))
    else
        warn("[Debug] Timed out. The SDK did not set JD_IS_PREMIUM. Ensure a key is actually entered and validated.")
    end
end)

while not getgenv().SCRIPT_KEY do task.wait(0.5) end


local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()



local Window = WindUI:CreateWindow({

    Title = "PS99 HUB",

    Icon = "rbxassetid://84366838202681", -- tvoje logo

    Author = "v1.0",

    Folder = "PS99Hub",



    Size = UDim2.fromOffset(720, 500),



    Transparent = true,

    Theme = "Dark",

    Resizable = true,



    SideBarWidth = 180,

    HideSearchBar = false,

    ScrollBarEnabled = true,

})



----------------------------------------------------

-- TABS

----------------------------------------------------



local Eggs = Window:Tab({

    Title = "Soon",

    Icon = "egg",

})



local Upgrades = Window:Tab({

    Title = "Soon",

    Icon = "arrow-up",

})



local Misc = Window:Tab({

    Title = "Soon",

    Icon = "gift",

})



local AutoMail = Window:Tab({

    Title = "Soon",

    Icon = "mail",

})



local Webhooks = Window:Tab({

    Title = "Soon",

    Icon = "bell",

})



local Server = Window:Tab({

    Title = "Soon",

    Icon = "server",

})



local Optimizer = Window:Tab({

    Title = "Optimizer",

    Icon = "rocket",

})



local Settings = Window:Tab({

    Title = "Settings",

    Icon = "settings",

})



----------------------------------------------------

-- EGGS

----------------------------------------------------



Eggs:Section({

    Title = "Egg Settings"

})



Eggs:Toggle({

    Title = "Auto Hatch",

    Default = false,

    Callback = function(v)

        print("Auto Hatch:", v)

    end

})



----------------------------------------------------

-- UPGRADES

----------------------------------------------------



Upgrades:Section({

    Title = "Upgrade Settings"

})



Upgrades:Toggle({

    Title = "Auto Buy Upgrades",

    Default = false,

})



----------------------------------------------------

-- MISC

----------------------------------------------------



Misc:Section({

    Title = "Consumables"

})



Misc:Toggle({

    Title = "Auto Use Potions",

    Default = false,

})



Misc:Dropdown({

    Title = "Potions to use",

    Values = {

        "All",

        "Coins",

        "Diamonds",

        "Lucky"

    },

    Default = "All"

})



Misc:Dropdown({

    Title = "Max Potion Tier",

    Values = {

        "Any",

        "Tier I",

        "Tier II",

        "Tier III",

        "Tier IV"

    },

    Default = "Any"

})



Misc:Toggle({

    Title = "Auto Use Fruits",

    Default = false,

})



Misc:Dropdown({

    Title = "Fruits to use",

    Values = {

        "All",

        "Apple",

        "Banana",

        "Orange"

    },

    Default = "All"

})



Misc:Slider({

    Title = "Max Fruit Stack",

    Step = 1,

    Value = {

        Min = 1,

        Max = 10,

        Default = 3

    }

})



----------------------------------------------------

-- AUTOMAIL

----------------------------------------------------



AutoMail:Section({

    Title = "Mail"

})



AutoMail:Toggle({

    Title = "Enable Auto Mail",

    Default = false,

})



----------------------------------------------------

-- WEBHOOKS

----------------------------------------------------



Webhooks:Section({

    Title = "Webhook"

})



Webhooks:Input({

    Title = "Webhook URL",

    Placeholder = "https://discord.com/api/webhooks/...",

    Callback = function(text)

        print(text)

    end

})



----------------------------------------------------

-- SERVER

----------------------------------------------------



Server:Button({

    Title = "Rejoin",

    Callback = function()

        game:GetService("TeleportService"):Teleport(game.PlaceId)

    end

})



----------------------------------------------------

-- OPTIMIZER

----------------------------------------------------



Optimizer:Toggle({

    Title = "Low Graphics",

    Default = false,

})



----------------------------------------------------

-- SETTINGS

----------------------------------------------------



Settings:Button({

    Title = "Unload UI",

    Callback = function()

        Window:Destroy()

    end

})
