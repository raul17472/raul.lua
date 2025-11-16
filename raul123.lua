local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("TwixyCheats", "DarkTheme")

-----------------------------------------------------
-- MAIN TAB
-----------------------------------------------------
local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Player Mods")

local player = game.Players.LocalPlayer

-----------------------------------------------------
-- GLOBAL STATES
-----------------------------------------------------
getgenv().SuperHuman = false
getgenv().Noclip = false
getgenv().Flying = false
getgenv().InfJump = false

local SpeedValue = 120
local JumpValue = 120

-----------------------------------------------------
-- SUPER HUMAN
-----------------------------------------------------
MainSection:NewToggle("Super-Human", "Fast walk + high jump", function(state)
    getgenv().SuperHuman = state

    while getgenv().SuperHuman do
        local char = player.Character or player.CharacterAdded:Wait()
        local hum = char:FindFirstChildOfClass("Humanoid")

        if hum then
            hum.UseJumpPower = true
            hum.WalkSpeed = SpeedValue
            hum.JumpPower = JumpValue
        end
        task.wait()
    end

    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = 16
        hum.JumpPower = 50
    end
end)

-----------------------------------------------------
-- SPEED SLIDER
-----------------------------------------------------
MainSection:NewSlider("WalkSpeed", "Adjust speed", 300, 16, function(v)
    SpeedValue = v
    if getgenv().SuperHuman and player.Character then
        player.Character.Humanoid.WalkSpeed = v
    end
end)

-----------------------------------------------------
-- JUMP SLIDER
-----------------------------------------------------
MainSection:NewSlider("JumpPower", "Adjust jump", 300, 50, function(v)
    JumpValue = v
    if getgenv().SuperHuman and player.Character then
        player.Character.Humanoid.JumpPower = v
    end
end)

-----------------------------------------------------
-- INFINITE JUMP
-----------------------------------------------------
MainSection:NewToggle("Infinite Jump", "Jump in air forever", function(state)
    getgenv().InfJump = state
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if getgenv().InfJump then
        local char = player.Character
        if char then
            local hum = char:FindFirstChildOfClass("Humanoid")
            hum.UseJumpPower = true
            hum.JumpPower = JumpValue
            hum:ChangeState("Jumping")
        end
    end
end)

-----------------------------------------------------
-- NOCLIP
-----------------------------------------------------
MainSection:NewToggle("Noclip", "Walk through walls", function(state)
    getgenv().Noclip = state
end)

game:GetService("RunService").Stepped:Connect(function()
    if getgenv().Noclip and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
end)

-----------------------------------------------------
-- FLY
-----------------------------------------------------
local function Fly()
    local char = player.Character
    if not char then return end

    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    local bodyGyro = Instance.new("BodyGyro", hrp)
    local bodyVelocity = Instance.new("BodyVelocity", hrp)

    bodyGyro.P = 90000
    bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)

    while getgenv().Flying do
        bodyGyro.CFrame = workspace.CurrentCamera.CoordinateFrame
        bodyVelocity.Velocity = workspace.CurrentCamera.CFrame.LookVector * SpeedValue
        task.wait()
    end

    bodyGyro:Destroy()
    bodyVelocity:Destroy()
end

MainSection:NewToggle("Fly", "Toggle flight", function(state)
    getgenv().Flying = state
    if state then
        task.spawn(Fly)
    end
end)

-----------------------------------------------------
-- BSS TAB
-----------------------------------------------------
local BSSTab = Window:NewTab("BSS")

local FirstSection = BSSTab:NewSection("Dupe Honey")
local SecondSection = BSSTab:NewSection("Dupe Ticket")
local ThirdSection = BSSTab:NewSection("Dupe Resources")

-----------------------------------------------------
-- DUPE HONEY (FULLY WORKING)
-----------------------------------------------------
FirstSection:NewButton("Dupe Honey", "Doubles CoreStats.Honey every click", function()
    local player = game.Players.LocalPlayer
    local coreStats = player:WaitForChild("CoreStats", 3)

    if coreStats then
        local honey = coreStats:FindFirstChild("Honey")

        if honey and honey:IsA("IntValue") then
            honey.Value = honey.Value * 2
            print("Honey duplicated! New value:", honey.Value)
        else
            warn("Honey IntValue not found inside CoreStats!")
        end
    else
        warn("CoreStats folder missing!")
    end
end)

-----------------------------------------------------
-- TICKET / RESOURCES PLACEHOLDERS
-----------------------------------------------------
SecondSection:NewButton("Dupe Ticket", "A button that can Dupe Ticket", function()
    print("Ticket Button Clicked")
end)

ThirdSection:NewButton("Dupe Resources", "A button that can Dupe Resources", function()
    print("Resources Button Clicked")
end)
