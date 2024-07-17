# Main
``` lua
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/Wuynnz/Lib/main/FluentCus.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Wuynnz/Lib/main/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "AUT",
    SubTitle = "by h4uy",
    TabWidth = 30,
    Size = UDim2.fromOffset(480, 400),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.F6
})

local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "home" }),
    Travel = Window:AddTab({ Title = "Travel", Icon = "car" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do


end

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("h4uyHub")
SaveManager:SetFolder("h4uyHub/Game")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
```
