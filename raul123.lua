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
-- SUPER HUMAN (SPEED + JUMP)
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

    -- reset
    local char = player.Character or player.CharacterAdded:Wait()
    local hum = char:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.WalkSpeed = 16
        hum.JumpPower = 50
    end
end)


-----------------------------------------------------
-- WALK SPEED SLIDER
-----------------------------------------------------
MainSection:NewSlider("WalkSpeed", "Adjust speed", 300, 16, function(v)
    SpeedValue = v
    if getgenv().SuperHuman and player.Character then
        player.Character.Humanoid.WalkSpeed = v
    end
end)


-----------------------------------------------------
-- JUMP POWER SLIDER
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
            char:FindFirstChildOfClass("Humanoid").UseJumpPower = true
            char:FindFirstChildOfClass("Humanoid").JumpPower = JumpValue
            char:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
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

    local hum = char:FindFirstChild("HumanoidRootPart")
    if not hum then return end

    local bodyGyro = Instance.new("BodyGyro", hum)
    local bodyVelocity = Instance.new("BodyVelocity", hum)

    bodyGyro.P = 9e4
    bodyGyro.MaxTorque = Vector3.new(9e9,9e9,9e9)

    bodyVelocity.MaxForce = Vector3.new(9e9,9e9,9e9)

    while getgenv().Flying do
        bodyGyro.CFrame = workspace.CurrentCamera.CFrame
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


----------------------------------------------------------------------
-- AUTO-FIND TEXTLABEL FUNCTION (works for any GUI honey display)
----------------------------------------------------------------------
local function findTextLabelWithNumbers()
    for _, obj in ipairs(player.PlayerGui:GetDescendants()) do
        if obj:IsA("TextLabel") then
            local num = tonumber(obj.Text:gsub("%D", ""))
            if num then
                return obj -- first textlabel containing a number
            end
        end
    end
    return nil
end


-----------------------------------------------------
-- DUPLICATE HONEY BUTTON
-----------------------------------------------------
FirstSection:NewButton("Dupe Honey", "A button that can Dupe Honey", function()
    local honeyLabel = findTextLabelWithNumbers()

    if honeyLabel then
        local current = tonumber(honeyLabel.Text:gsub("%D", "")) or 0
        local addAmount = 100 -- change this value

        honeyLabel.Text = tostring(current + addAmount)

        print("Honey duplicated! New honey:", honeyLabel.Text)
    else
        warn("Could not find honey TextLabel in PlayerGui.")
    end
end)


-----------------------------------------------------
-- DUPLICATE TICKETS BUTTON
-----------------------------------------------------
SecondSection:NewButton("Dupe Ticket", "A button that can Dupe Ticket", function()
    print("Ticket dupe placeholder — tell me your Ticket GUI name so I can connect it.")
end)


-----------------------------------------------------
-- DUPLICATE RESOURCES BUTTON
-----------------------------------------------------
ThirdSection:NewButton("Dupe Resources", "A button that can Dupe Resources", function()
    print("Resource dupe placeholder — tell me the GUI names so I can connect them.")
end)
