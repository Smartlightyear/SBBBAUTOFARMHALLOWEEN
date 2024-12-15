local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "YoNoodle Hub", HidePremium = false, SaveConfig = true, ConfigFolder = "YoNoodleConfig"})

local FarmTab = Window:MakeTab({
    Name = "Auto Farm",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local SafeTab = Window:MakeTab({
    Name = "Safety",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local PlayerTab = Window:MakeTab({
    Name = "Player",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Store original position for SafeSpot
local originalPosition = nil

-- Create SafeSpot
local function createSafeSpot()
    local baseplate = Instance.new("Part")
    baseplate.Name = "SafeSpot"
    baseplate.Size = Vector3.new(100, 1, 100)
    baseplate.Position = Vector3.new(0, 10000, 0)
    baseplate.Anchored = true
    baseplate.Transparency = 0.7
    baseplate.Parent = workspace
    return baseplate
end

-- SafeSpot Feature
SafeTab:AddToggle({
    Name = "SafeSpot",
    Default = false,
    Callback = function(Value)
        if Value then
            originalPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            local safespot = createSafeSpot()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = safespot.CFrame * CFrame.new(0, 3, 0)
        else
            if originalPosition then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = originalPosition
            end
            if workspace:FindFirstChild("SafeSpot") then
                workspace.SafeSpot:Destroy()
            end
        end
    end
})

-- CandyCorn Farm
FarmTab:AddToggle({
    Name = "CandyCorn Farm",
    Default = false,
    Callback = function(Value)
        getgenv().candyFarm = Value
        while getgenv().candyFarm do
            for _, candy in pairs(workspace:GetChildren()) do
                if candy.Name == "CandyCorn" then
                    candy.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
            task.wait()
        end
    end
})

-- Speed Slider
PlayerTab:AddSlider({
    Name = "Walk Speed",
    Min = 16,
    Max = 500,
    Default = 16,
    Color = Color3.fromRGB(0, 255, 0),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end    
})

-- Jump Power Slider
PlayerTab:AddSlider({
    Name = "Jump Power",
    Min = 50,
    Max = 500,
    Default = 50,
    Color = Color3.fromRGB(0, 255, 0),
    Increment = 1,
    ValueName = "Power",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
    end    
})

-- FOV Slider
PlayerTab:AddSlider({
    Name = "FOV",
    Min = 70,
    Max = 120,
    Default = 70,
    Color = Color3.fromRGB(0, 255, 0),
    Increment = 1,
    ValueName = "FOV",
    Callback = function(Value)
        game:GetService("Workspace").CurrentCamera.FieldOfView = Value
    end    
})

-- Spin Slider
PlayerTab:AddSlider({
    Name = "Spin Speed",
    Min = 0,
    Max = 50,
    Default = 0,
    Color = Color3.fromRGB(0, 255, 0),
    Increment = 1,
    ValueName = "Speed",
    Callback = function(Value)
        getgenv().spinSpeed = Value
        if Value > 0 then
            local spinFunction = nil
            spinFunction = game:GetService('RunService').Heartbeat:Connect(function()
                if getgenv().spinSpeed > 0 then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(getgenv().spinSpeed), 0)
                else
                    spinFunction:Disconnect()
                end
            end)
        end
    end    
})

OrionLib:Init()
