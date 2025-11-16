local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Test", "DarkTheme")

-- MAIN TAB
local MainTab = Window:NewTab("Main")
local UsefulSection = MainTab:NewSection("test")

UsefulSection:NewToggle("Super-Human", "Go faster/Jump better", function(state)
    if state then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 120
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 300
    else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)


-- BSS TAB
local BSSTab = Window:NewTab("BSS")

local FirstSection = BSSTab:NewSection("Dupe Honey")
local SecondSection = BSSTab:NewSection("Dupe Ticket")
local ThirdSection = BSSTab:NewSection("Dupe Resources")

FirstSection:NewButton("Dupe Honey", "A button that can Dupe Honey", function()
    print("Clicked")
end)

SecondSection:NewButton("Dupe Ticket", "A button that can Dupe Ticket", function()
    print("Clicked")
end)

ThirdSection:NewButton("Dupe Resources", "A button that can Dupe Resources", function()
    print("Clicked")
end)
