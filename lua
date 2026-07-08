-- Definuje se hlavní spouštěcí funkce, která se zavolá POUZE při správném klíči
function load()
    print("Klíč úspěšný! Načítám GalaxyHub...")
    
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local tweenService = game:GetService("TweenService")

    local waypoints = {
        Vector3.new(1832, 16, -32046), Vector3.new(1976, 16, -32046),
        Vector3.new(2120, 16, -32046), Vector3.new(2264, 16, -32046),
        Vector3.new(2408, 16, -32046), Vector3.new(2552, 16, -32046),
        Vector3.new(2696, 16, -32046), Vector3.new(2840, 16, -32046),
        Vector3.new(2984, 16, -32046), Vector3.new(3128, 16, -32046),
        Vector3.new(3272, 16, -32046), Vector3.new(3416, 16, -32046),
        Vector3.new(3560, 16, -32046), Vector3.new(3704, 16, -32046),
        Vector3.new(3848, 16, -32046), Vector3.new(3992, 16, -32046),
        Vector3.new(4136, 16, -32046), Vector3.new(4280, 16, -32046)
    }

    local currentWaypointIndex = 1
    local isEnabled = false
    local currentTween = nil

    local character = player.Character or player.CharacterAdded:Wait()
    local rootPart = character:WaitForChild("HumanoidRootPart")

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
            currentTween = tweenService:Create(rootPart, tweenInfo, {CFrame = CFrame.new(targetPosition)})
            
            currentTween:Play()
            currentTween.Completed:Connect(function(playbackState)
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

    -- Načtení moderního WindUI Okna
    local Window = WindUI:CreateWindow({
        Title = "Galaxy Hub",
        Icon = "door-open",
        Author = "by uerd & .ftgs",
        Folder = "MySuperHub",
        Size = UDim2.fromOffset(580, 460),
        MinSize = Vector2.new(560, 350),
        MaxSize = Vector2.new(850, 560),
        Transparent = true,
        Theme = "Dark",
        Resizable = true,
        SideBarWidth = 200,
        BackgroundImageTransparency = 0.42,
        HideSearchBar = true,
        ScrollBarEnabled = false
    })

    local Tab = Window:Tab({
        Title = "Hlavní Funkce",
        Icon = "bird", 
        Locked = false,
    })

    -- Přidání Toggle tlačítka přímo do WindUI menu
    Tab:Toggle({
        Title = "Auto Walk",
        Desc = "Automaticky chodí po určených souřadnicích",
        Value = false,
        Callback = function(state)
            isEnabled = state
            if isEnabled then
                moveToNextWaypoint()
            else
                if currentTween then
                    currentTween:Cancel() -- Zastaví pohyb ihned po vypnutí
                end
            end
        end
    })

    -- Ošetření pro případ, že postava umře
    player.CharacterAdded:Connect(function(newCharacter)
        character = newCharacter
        rootPart = character:WaitForChild("HumanoidRootPart")
        if isEnabled then
            task.wait(1) -- Malá pauza na respawn
            moveToNextWaypoint()
        end
    end)
end

-- Načtení samotné knihovny WindUI a Key Systému
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

WindUI.Services.junkiedev = {
    Name = "Junkie Development",
    Icon = "bug-off",
    Args = { "ServiceId", "ApiKey", "Provider" },
    New = function(ServiceId, ApiKey, Provider)
        JunkieProtected.API_KEY = ApiKey
        JunkieProtected.PROVIDER = Provider
        JunkieProtected.SERVICE_ID = ServiceId

        local function ValidateKey(key)
            if not key or key == "" then
                print("❌ No key provided!")
                game.Players.LocalPlayer:Kick("No key provided. Please get a key.")
                return false
            end

            local keylessCheck = JunkieProtected.IsKeylessMode()
            if keylessCheck and keylessCheck.keyless_mode then
                print("Keyless mode enabled - Starting script...")
                load() -- Spustí se v keyless módu
                return true
            end

            local result = JunkieProtected.ValidateKey({ Key = key })
            if result == "valid" then
                print("Key is valid! Starting script...")
                load() -- Spustí se při správném klíči
                return true
            end

            local keyLink = JunkieProtected.GetKeyLink()
            print("❌ Invalid key!")
            game.Players.LocalPlayer:Kick("Invalid key. Get one from: " .. keyLink)
            return false
        end

        local function copyLink()
            local link = JunkieProtected.GetKeyLink()
            if setclipboard then
                setclipboard(link)
            end
        end

        return {
            Verify = ValidateKey,
            Copy = copyLink
        }
    end
}

-- Inicializace Key Systému před zobrazením menu
WindUI:KeySystem({
    Note = "hi, im uerd.",                                     
    API = {                                                       
        { 
            Type = "junkiedev",
            ServiceId = "realuerd",
            ApiKey = "e2abcc15-fba3-467e-936a-73aac882af2d",
            Provider = "tutorial",
        }    
    }
})
