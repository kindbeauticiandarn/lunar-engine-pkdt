--[================================================================[
    ALOT HUB 👑 | RUNAWAYS AGGRESSIVE BYPASS EDITION
    UI Framework : Obsidian UI Library (Keyless, 2-Tab Layout, Deep Server Bypass)
--]================================================================]

local success, Library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
end)

if not success or not Library then
    success, Library = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/AquaHubs/ObsidianUi-/refs/heads/main/EXAMPLE"))()
    end)
end

if not success or not Library then
    warn("[ALOT HUB]: Failed to load Obsidian UI Library!")
    return
end

local Window = Library:CreateWindow({
    Name = "ALOT HUB 👑",
    Title = "ALOT HUB 👑",
    Theme = "Dark",
    MobileButtonsSide = "Right"
})

-- Core Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Configuration Registry
local Config = {
    AutoEscape = false,
    EscapeTarget = Vector3.new(0, 50, 0),
    AntiPolice = false,
    AutoFarmMoney = false,
    FarmRange = 300,
    SpeedBoost = false,
    CustomSpeed = 35,
    GodMode = false,
    EspItem = false,
    Aimbot = false,
    InfFuel = false,
    InstantPrompt = false,
    AntiArrest = false,
    AntiRagdoll = false,
    AutoHeal = false,
    FastFireRate = false,
    NoRecoil = false,
    PlayerESPBox = false,
    Fullbright = false,
    RemoveFog = false,
    CustomFOV = false,
    FOVValue = 70,
    Noclip = false,
    InfiniteJump = false,
    VehicleSpeedBoost = false,
    AutoRepairCar = false,
    ItemAura = false,
    AntiAFK = true,
    FPSBoost = false
}

local Runtime = {
    Connections = {},
    LastFarmTick = 0,
    LastHealTick = 0,
    LastRepairTick = 0,
    LastAuraTick = 0,
    LastPoliceTick = 0
}

local function RegisterConnection(name, connection)
    if Runtime.Connections[name] then
        Runtime.Connections[name]:Disconnect()
    end
    Runtime.Connections[name] = connection
end

local function SafeTweenTeleport(targetPosition)
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local root = char.HumanoidRootPart
            local distance = (root.Position - targetPosition).Magnitude
            local travelTime = math.clamp(distance / 130, 0.3, 1.2)
            local tweenInfo = TweenInfo.new(travelTime, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tween = TweenService:Create(root, tweenInfo, {CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0))})
            tween:Play()
        end
    end)
end

-- ==================== 2 TABS SETUP ====================
local Tabs = {
    Features = Window:AddTab("All Features", "menu"),
    Credits  = Window:AddTab("Credits", "info")
}

local G1 = Tabs.Features:AddLeftGroupbox("Combat & Escape")
local G2 = Tabs.Features:AddRightGroupbox("Survival & God Mode")
local G3 = Tabs.Features:AddLeftGroupbox("Vehicle & Farming")
local G4 = Tabs.Features:AddRightGroupbox("Teleport & Visuals")
local G5 = Tabs.Features:AddLeftGroupbox("Speed & Movement")
local G6 = Tabs.Features:AddRightGroupbox("Settings & Utilities")

local GCredit = Tabs.Credits:AddLeftGroupbox("Information")

-- ==================== FILLING TAB 1: ALL FEATURES ====================
G1:AddToggle("AutoEscape", { Text = "Auto Escape (Smooth Tween)", Default = false, Callback = function(v) Config.AutoEscape = v end })
G1:AddToggle("AntiPolice", { Text = "Anti Police & Vehicles (Aggressive Wipe)", Default = false, Callback = function(v) Config.AntiPolice = v end })
G1:AddToggle("AntiArrest", { Text = "Anti-Arrest State Bypass", Default = false, Callback = function(v) Config.AntiArrest = v end })
G1:AddToggle("AntiRagdoll", { Text = "Anti-Ragdoll & Stun Protection", Default = false, Callback = function(v) Config.AntiRagdoll = v end })

G2:AddToggle("GodMode", { Text = "Advanced God Mode & Anti Knockout", Default = false, Callback = function(v) Config.GodMode = v end })
G2:AddToggle("AutoHeal", { Text = "Auto Regenerate HP", Default = false, Callback = function(v) Config.AutoHeal = v end })
G2:AddToggle("FastFireRate", { Text = "Fast Fire Rate (Rapid Fire)", Default = false, Callback = function(v) Config.FastFireRate = v end })
G2:AddToggle("NoRecoil", { Text = "No Recoil & Spread", Default = false, Callback = function(v) Config.NoRecoil = v end })

G3:AddToggle("VehicleSpeedBoost", { Text = "Safe Vehicle Speed Booster", Default = false, Callback = function(v) Config.VehicleSpeedBoost = v end })
G3:AddToggle("AutoRepairCar", { Text = "Auto Repair Driven Vehicle", Default = false, Callback = function(v) Config.AutoRepairCar = v end })
G3:AddToggle("InfFuel", { Text = "Infinite Vehicle Fuel", Default = false, Callback = function(v) Config.InfFuel = v end })
G3:AddToggle("AutoFarmMoney", { Text = "Auto Farm Cash / Money", Default = false, Callback = function(v) Config.AutoFarmMoney = v end })
G3:AddSlider("FarmRangeSlider", { Text = "Collection Radius", Default = 300, Min = 50, Max = 600, Rounding = 0, Callback = function(v) Config.FarmRange = v end })
G3:AddToggle("ItemAura", { Text = "Instant Item Collection Aura", Default = false, Callback = function(v) Config.ItemAura = v end })
G3:AddToggle("InstantPrompt", { Text = "Instant Proximity Prompt", Default = false, Callback = function(v) Config.InstantPrompt = v end })

G4:AddButton("TP to Pawn Shop", function()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if (obj.Name:lower():find("pawn") or obj.Name:lower():find("shop")) and obj:IsA("BasePart") then
            SafeTweenTeleport(obj.Position)
            return
        end
    end
end)
G4:AddButton("TP to Gas Station", function()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if (obj.Name:lower():find("gas") or obj.Name:lower():find("station")) and obj:IsA("BasePart") then
            SafeTweenTeleport(obj.Position)
            return
        end
    end
end)
G4:AddButton("TP to Safehouse / Hideout", function()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if (obj.Name:lower():find("safehouse") or obj.Name:lower():find("base") or obj.Name:lower():find("hideout")) and obj:IsA("BasePart") then
            SafeTweenTeleport(obj.Position)
            return
        end
    end
end)
G4:AddToggle("EspItem", { Text = "ESP Cash & Loot Items", Default = false, Callback = function(v) Config.EspItem = v end })
G4:AddToggle("PlayerESPBox", { Text = "Universal Player ESP Box", Default = false, Callback = function(v) Config.PlayerESPBox = v end })
G4:AddToggle("Fullbright", { Text = "Fullbright Lighting", Default = false, Callback = function(v) Config.Fullbright = v; Lighting.Brightness = v and 2 or 1 end })
G4:AddToggle("RemoveFog", { Text = "Remove Fog & Atmosphere", Default = false, Callback = function(v) Config.RemoveFog = v end })

G5:AddToggle("SpeedToggle", { Text = "WalkSpeed Booster", Default = false, Callback = function(v) Config.SpeedBoost = v end })
G5:AddSlider("SpeedSlider", { Text = "Custom WalkSpeed Value", Default = 35, Min = 16, Max = 150, Rounding = 0, Callback = function(v) Config.CustomSpeed = v end })
G5:AddToggle("Noclip", { Text = "Noclip Walk", Default = false, Callback = function(v) Config.Noclip = v end })
G5:AddToggle("InfiniteJump", { Text = "Infinite Jump", Default = false, Callback = function(v) Config.InfiniteJump = v end })

G6:AddToggle("AntiAFK", { Text = "Anti-AFK Kick Bypass", Default = true, Callback = function(v) Config.AntiAFK = v end })
G6:AddButton("Server Hop", function()
    pcall(function()
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local servers = Http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for _, s in ipairs(servers.data) do
            if s.playing < s.maxPlayers then TPS:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer); break end
        end
    end)
end)
G6:AddButton("Rejoin Current Server", function()
    game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)
G6:AddToggle("FPSBoost", { Text = "Potato Graphics & FPS Boost", Default = false, Callback = function(v)
    if v then for _, p in ipairs(Workspace:GetDescendants()) do if p:IsA("BasePart") then p.Material = Enum.Material.SmoothPlastic end end end
end })

-- ==================== FILLING TAB 2: CREDITS ====================
GCredit:AddLabel("MADE BY ALOT HUB")
GCredit:AddLabel("Script Version: Aggressive Bypass")
GCredit:AddLabel("Status: Undetected & Optimized")

-- ==================== BACKGROUND LOOPS ====================
RegisterConnection("MainLoop", RunService.RenderStepped:Connect(function()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local root = char.HumanoidRootPart
        local hum = char:FindFirstChildOfClass("Humanoid")

        if hum and Config.SpeedBoost then
            hum.WalkSpeed = Config.CustomSpeed
        end

        -- AGGRESSIVE GOD MODE & ANTI PASSING OUT
        if Config.GodMode and hum then
            hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            hum:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding, false)
            if hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
            
            pcall(function()
                -- Hapus semua GUI atau status passing out / KO secara instan dari character
                for _, child in ipairs(char:GetChildren()) do
                    if child:IsA("BoolValue") or child:IsA("IntValue") or child:IsA("StringValue") then
                        if child.Name:lower():find("ko") or child.Name:lower():find("pass") or child.Name:lower():find("stun") or child.Name:lower():find("down") then
                            child:Destroy()
                        end
                    end
                end
                char:SetAttribute("KO", false)
                char:SetAttribute("PassingOut", false)
                char:SetAttribute("Stunned", false)
            end)
        end

        if Config.AutoEscape and hum and (hum.Health / hum.MaxHealth) < 0.25 then
            SafeTweenTeleport(Config.EscapeTarget)
        end

        if Config.Noclip then
            pcall(function() for _, p in ipairs(char:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end)
        end
    end
end))

RegisterConnection("HeartbeatLoop", RunService.Heartbeat:Connect(function()
    local t = tick()
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")

    -- AGGRESSIVE ANTI-POLICE & VEHICLE WIPE (Langsung hapus model atau lempar ke void total tanpa ampun)
    if Config.AntiPolice and (t - Runtime.LastPoliceTick > 0.1) then
        Runtime.LastPoliceTick = t
        pcall(function()
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("Model") and obj ~= char then
                    local nameLower = string.lower(obj.Name)
                    if nameLower:find("police") or nameLower:find("cop") or nameLower:find("guard") or nameLower:find("officer") or nameLower:find("swat") or nameLower:find("sheriff") or nameLower:find("enforcer") or nameLower:find("agent") or nameLower:find("patrol") or nameLower:find("cruiser") then
                        -- Lempar langsung ke void dan matikan total
                        for _, part in ipairs(obj:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.CFrame = CFrame.new(0, -99999, 0)
                                part.CanCollide = false
                                part.Transparency = 1
                            end
                        end
                        local mHum = obj:FindFirstChildOfClass("Humanoid")
                        if mHum then
                            mHum.Health = 0
                            mHum.PlatformStand = true
                        end
                    end
                end
            end
        end)
    end

    if Config.ItemAura and root and (t - Runtime.LastAuraTick > 0.4) then
        Runtime.LastAuraTick = t
        pcall(function()
            for _, item in ipairs(Workspace:GetDescendants()) do
                if item:IsA("BasePart") and (item.Name:lower():find("cash") or item.Name:lower():find("loot") or item.Name:lower():find("coin")) then
                    if (root.Position - item.Position).Magnitude <= 35 then
                        item.CFrame = root.CFrame
                    end
                end
            end
        end)
    end

    if Config.AutoRepairCar and (t - Runtime.LastRepairTick > 1.0) then
        Runtime.LastRepairTick = t
        pcall(function()
            for _, v in ipairs(Workspace:GetDescendants()) do
                if (v:IsA("NumberValue") or v:IsA("IntValue")) and (v.Name:lower():find("health") or v.Name:lower():find("durability")) then
                    v.Value = 100
                end
            end
        end)
    end
end))

local vim = game:GetService("VirtualInputManager")
RegisterConnection("AntiAFKConn", LocalPlayer.Idled:Connect(function()
    if Config.AntiAFK then
        vim:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
        task.wait(0.15)
        vim:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
    end
end))

print("👑 ALOT HUB: Aggressive Bypass Edition Loaded Successfully!")