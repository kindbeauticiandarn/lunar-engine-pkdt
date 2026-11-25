-- ==========================================
-- EASY SETTINGS
-- Change this number to set the maximum Fly Speed slider value.
-- ==========================================
local FLY_SPEED_MAX = 1000

-- Ensure old GUI is removed if re-executing
local oldGui = game:GetService("CoreGui"):FindFirstChild("AnimicaScriptsMenu") or game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui"):FindFirstChild("AnimicaScriptsMenu")
if oldGui then oldGui:Destroy() end

-- Services
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AnimicaScriptsMenu"
ScreenGui.ResetOnSpawn = false

-- Try CoreGui first in roblox studio as this isn't for hacking
local success, _ = pcall(function() ScreenGui.Parent = game:GetService("CoreGui") end)
if not success then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Rayfield-Style Intro Notification
local NotificationFrame = Instance.new("Frame")
NotificationFrame.Size = UDim2.new(0, 250, 0, 60)
NotificationFrame.Position = UDim2.new(1, 20, 0.85, 0)
NotificationFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
NotificationFrame.BorderSizePixel = 0
NotificationFrame.Parent = ScreenGui

local NotifCorner = Instance.new("UICorner")
NotifCorner.CornerRadius = UDim.new(0, 8)
NotifCorner.Parent = NotificationFrame

local NotifTitle = Instance.new("TextLabel")
NotifTitle.Size = UDim2.new(1, 0, 0.5, 0)
NotifTitle.Text = "Animica Scripts"
NotifTitle.TextColor3 = Color3.fromRGB(52, 152, 219)
NotifTitle.TextSize = 16
NotifTitle.Font = Enum.Font.SourceSansBold
NotifTitle.BackgroundTransparency = 1
NotifTitle.Parent = NotificationFrame

local NotifSub = Instance.new("TextLabel")
NotifSub.Size = UDim2.new(1, 0, 0.5, 0)
NotifSub.Position = UDim2.new(0, 0, 0.5, 0)
NotifSub.Text = "Made by Animica"
NotifSub.TextColor3 = Color3.fromRGB(200, 200, 200)
NotifSub.TextSize = 14
NotifSub.Font = Enum.Font.SourceSans
NotifSub.BackgroundTransparency = 1
NotifSub.Parent = NotificationFrame

-- Intro Tween
NotificationFrame:TweenPosition(UDim2.new(1, -270, 0.85, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, 0.5, true)
task.delay(3.5, function()
    NotificationFrame:TweenPosition(UDim2.new(1, 20, 0.85, 0), Enum.EasingDirection.In, Enum.EasingStyle.Quart, 0.5, true, function()
        NotificationFrame:Destroy()
    end)
end)

-- Main Frame (Wider and Shorter)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 360, 0, 290)
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 9)
UICorner.Parent = MainFrame

-- Smooth Modern Dragging System
local dragging, dragInput, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "✨ Animica Scripts | Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 9)
TitleCorner.Parent = Title

-- Minimize Button
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Position = UDim2.new(1, -30, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 18
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.ZIndex = 5
MinimizeBtn.Parent = MainFrame

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 5)
MinCorner.Parent = MinimizeBtn

local MenuMinimized = false

MinimizeBtn.MouseButton1Click:Connect(function()
    MenuMinimized = not MenuMinimized

    if MenuMinimized then
        MainFrame:TweenSize(
            UDim2.new(0, 360, 0, 35),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            0.3,
            true
        )
        MinimizeBtn.Text = "+"
    else
        MainFrame:TweenSize(
            UDim2.new(0, 360, 0, 290),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            0.3,
            true
        )
        MinimizeBtn.Text = "-"
    end
end)

-- Scrolling Container for all Mod Buttons
local ScrollContainer = Instance.new("ScrollingFrame")
ScrollContainer.Size = UDim2.new(1, -10, 1, -45)
ScrollContainer.Position = UDim2.new(0, 5, 0, 40)
ScrollContainer.BackgroundTransparency = 1
ScrollContainer.BorderSizePixel = 0
ScrollContainer.ScrollBarThickness = 4
ScrollContainer.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 70)
ScrollContainer.Parent = MainFrame

local Layout = Instance.new("UIListLayout")
Layout.Parent = ScrollContainer
Layout.Padding = UDim.new(0, 8)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.SortOrder = Enum.SortOrder.LayoutOrder

-- Automatically handles scroll canvas sizing
Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScrollContainer.CanvasSize = UDim2.new(0, 0, 0, Layout.AbsoluteContentSize.Y + 10)
end)

-- Helper function to make stylish wide buttons
local function createButton(text, layoutOrder, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 330, 0, 32)
    btn.BackgroundColor3 = color or Color3.fromRGB(40, 40, 45)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 15
    btn.LayoutOrder = layoutOrder
    btn.Parent = ScrollContainer

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    return btn
end

-- Helper function for sliders
local function createSlider(labelText, min, max, default, layoutOrder, callback)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 330, 0, 40)
    Frame.BackgroundTransparency = 1
    Frame.LayoutOrder = layoutOrder
    Frame.Parent = ScrollContainer

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 0, 15)
    Label.Text = labelText .. ": " .. default
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.BackgroundTransparency = 1
    Label.TextSize = 13
    Label.Font = Enum.Font.SourceSans
    Label.Parent = Frame

    local SliderBG = Instance.new("TextButton")
    SliderBG.Size = UDim2.new(1, 0, 0, 8)
    SliderBG.Position = UDim2.new(0, 0, 0, 20)
    SliderBG.BackgroundColor3 = Color3.fromRGB(55, 55, 60)
    SliderBG.Text = ""
    SliderBG.Parent = Frame

    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new(
        (default - min) / (max - min),
        0,
        1,
        0
    )
    SliderFill.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
    SliderFill.BorderSizePixel = 0
    SliderFill.Parent = SliderBG

    local sliding = false

    local function update(input)
        local pct = math.clamp(
            (input.Position.X - SliderBG.AbsolutePosition.X) /
            SliderBG.AbsoluteSize.X,
            0,
            1
        )

        SliderFill.Size = UDim2.new(pct, 0, 1, 0)

        local val = math.floor(min + (pct * (max - min)))

        Label.Text = labelText .. ": " .. val
        callback(val)
    end

    SliderBG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            sliding = true
            update(input)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if sliding
            and (
                input.UserInputType == Enum.UserInputType.MouseMovement
                or input.UserInputType == Enum.UserInputType.Touch
            ) then

            update(input)
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            sliding = false
        end
    end)
end

-- ==========================================
-- MODS ENGINE & IMPLEMENTATION
-- ==========================================

local InfJumpEnabled = false
local FlyEnabled = false
local NoclipEnabled = false
local PlayerESPEnabled = false
local MonsterESPEnabled = false
local WalkSpeedValue = 16
local FlySpeedValue = 50

-- 1. Infinite Jump
local InfJumpBtn = createButton("Inf Jump: OFF", 1)

InfJumpBtn.MouseButton1Click:Connect(function()
    InfJumpEnabled = not InfJumpEnabled

    InfJumpBtn.Text = "Inf Jump: " ..
        (InfJumpEnabled and "ON" or "OFF")

    InfJumpBtn.BackgroundColor3 =
        InfJumpEnabled
        and Color3.fromRGB(46, 204, 113)
        or Color3.fromRGB(40, 40, 45)
end)

UIS.JumpRequest:Connect(function()
    if InfJumpEnabled and LocalPlayer.Character then
        local hum =
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- 2. WalkSpeed Slider
createSlider(
    "WalkSpeed",
    16,
    500,
    16,
    2,
    function(val)
        WalkSpeedValue = val
    end
)

RunService.RenderStepped:Connect(function()
    if LocalPlayer.Character then
        local hum =
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

        if hum and hum.WalkSpeed ~= WalkSpeedValue then
            hum.WalkSpeed = WalkSpeedValue
        end
    end
end)

-- 3. Fly Button & Custom Mobile Navigation Frame
local FlyBtn = createButton("Fly: OFF", 3)

local DPadFrame = Instance.new("Frame")
DPadFrame.Size = UDim2.new(0, 150, 0, 150)
DPadFrame.Position = UDim2.new(0.7, 0, 0.4, 0)
DPadFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
DPadFrame.BackgroundTransparency = 0.6
DPadFrame.Visible = false
DPadFrame.Active = true
DPadFrame.Parent = ScreenGui

local DPadCorner = Instance.new("UICorner", DPadFrame)
DPadCorner.CornerRadius = UDim.new(0, 75)

local moveDir = Vector3.new(0, 0, 0)

local function createPadBtn(text, pos, size, dir)
    local b = Instance.new("TextButton")

    b.Size = size
    b.Position = pos
    b.Text = text

    b.BackgroundColor3 = Color3.fromRGB(70, 70, 75)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)

    b.Font = Enum.Font.SourceSansBold
    b.TextSize = 13
    b.Parent = DPadFrame

    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 5)

    b.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            moveDir = moveDir + dir
        end
    end)

    b.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then

            moveDir = moveDir - dir
        end
    end)
end

createPadBtn(
    "▲",
    UDim2.new(0.36, 0, 0.05, 0),
    UDim2.new(0, 35, 0, 35),
    Vector3.new(0, 0, -1)
)

createPadBtn(
    "▼",
    UDim2.new(0.36, 0, 0.65, 0),
    UDim2.new(0, 35, 0, 35),
    Vector3.new(0, 0, 1)
)

createPadBtn(
    "◀",
    UDim2.new(0.05, 0, 0.36, 0),
    UDim2.new(0, 35, 0, 35),
    Vector3.new(-1, 0, 0)
)

createPadBtn(
    "▶",
    UDim2.new(0.65, 0, 0.36, 0),
    UDim2.new(0, 35, 0, 35),
    Vector3.new(1, 0, 0)
)

createPadBtn(
    "UP",
    UDim2.new(0.36, 0, 0.36, 0),
    UDim2.new(0, 35, 0, 35),
    Vector3.new(0, 1, 0)
)

createPadBtn(
    "DN",
    UDim2.new(0.05, 0, 0.75, 0),
    UDim2.new(0, 35, 0, 30),
    Vector3.new(0, -1, 0)
)

-- 4. Fly Speed Slider
-- The maximum is controlled by FLY_SPEED_MAX at the top.
createSlider(
    "Fly Speed",
    10,
    FLY_SPEED_MAX,
    math.min(50, FLY_SPEED_MAX),
    4,
    function(val)
        FlySpeedValue = val
    end
)

local bodyGyro, bodyVelocity

FlyBtn.MouseButton1Click:Connect(function()
    FlyEnabled = not FlyEnabled

    FlyBtn.Text = "Fly: " ..
        (FlyEnabled and "ON" or "OFF")

    FlyBtn.BackgroundColor3 =
        FlyEnabled
        and Color3.fromRGB(46, 204, 113)
        or Color3.fromRGB(40, 40, 45)

    DPadFrame.Visible = FlyEnabled

    local root =
        LocalPlayer.Character
        and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

    if FlyEnabled and root then

        bodyGyro = Instance.new("BodyGyro", root)
        bodyGyro.P = 9e4
        bodyGyro.maxTorque = Vector3.new(9e5, 9e5, 9e5)
        bodyGyro.cframe = root.CFrame

        bodyVelocity = Instance.new("BodyVelocity", root)
        bodyVelocity.velocity = Vector3.new(0, 0.1, 0)
        bodyVelocity.maxForce = Vector3.new(9e5, 9e5, 9e5)

        task.spawn(function()
            while FlyEnabled
                and LocalPlayer.Character
                and bodyVelocity
                and bodyGyro do

                local currentRoot =
                    LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

                if not currentRoot then
                    break
                end

                bodyGyro.Parent = currentRoot
                bodyVelocity.Parent = currentRoot

                local cameraCFrame =
                    workspace.CurrentCamera.CFrame

                local calculatedDir =
                    Vector3.new(0, 0, 0)

                if UIS:IsKeyDown(Enum.KeyCode.W)
                    or moveDir.Z < 0 then

                    calculatedDir =
                        calculatedDir + cameraCFrame.LookVector
                end

                if UIS:IsKeyDown(Enum.KeyCode.S)
                    or moveDir.Z > 0 then

                    calculatedDir =
                        calculatedDir - cameraCFrame.LookVector
                end

                if UIS:IsKeyDown(Enum.KeyCode.A)
                    or moveDir.X < 0 then

                    calculatedDir =
                        calculatedDir - cameraCFrame.RightVector
                end

                if UIS:IsKeyDown(Enum.KeyCode.D)
                    or moveDir.X > 0 then

                    calculatedDir =
                        calculatedDir + cameraCFrame.RightVector
                end

                if UIS:IsKeyDown(Enum.KeyCode.Space)
                    or moveDir.Y > 0 then

                    calculatedDir =
                        calculatedDir + Vector3.new(0, 1, 0)
                end

                if UIS:IsKeyDown(Enum.KeyCode.LeftShift)
                    or moveDir.Y < 0 then

                    calculatedDir =
                        calculatedDir - Vector3.new(0, 1, 0)
                end

                bodyGyro.cframe = cameraCFrame

                bodyVelocity.velocity =
                    calculatedDir.Magnitude > 0
                    and calculatedDir.Unit * FlySpeedValue
                    or Vector3.new(0, 0, 0)

                RunService.RenderStepped:Wait()
            end
        end)

    else

        if bodyGyro then
            bodyGyro:Destroy()
        end

        if bodyVelocity then
            bodyVelocity:Destroy()
        end

        moveDir = Vector3.new(0, 0, 0)
    end
end)

-- 5. Noclip
local NoclipBtn = createButton("Noclip: OFF", 5)

NoclipBtn.MouseButton1Click:Connect(function()
    NoclipEnabled = not NoclipEnabled

    NoclipBtn.Text = "Noclip: " ..
        (NoclipEnabled and "ON" or "OFF")

    NoclipBtn.BackgroundColor3 =
        NoclipEnabled
        and Color3.fromRGB(46, 204, 113)
        or Color3.fromRGB(40, 40, 45)
end)

RunService.Stepped:Connect(function()
    if NoclipEnabled and LocalPlayer.Character then
        for _, part in pairs(
            LocalPlayer.Character:GetDescendants()
        ) do

            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

-- 6. Teleport to Random Player
local TPBtn =
    createButton("⚡ Teleport to Random Player", 6)

TPBtn.MouseButton1Click:Connect(function()
    local allPlayers = Players:GetPlayers()
    local targets = {}

    for _, p in pairs(allPlayers) do
        if p ~= LocalPlayer
            and p.Character
            and p.Character:FindFirstChild("HumanoidRootPart") then

            table.insert(targets, p)
        end
    end

    if #targets > 0 then

        local randomPlayer =
            targets[math.random(1, #targets)]

        LocalPlayer.Character.HumanoidRootPart.CFrame =
            randomPlayer.Character.HumanoidRootPart.CFrame
            * CFrame.new(0, 2, -3)

        TPBtn.Text =
            "🎯 Teleported to "
            .. randomPlayer.DisplayName

    else
        TPBtn.Text = "❌ No targets found"
    end

    task.delay(1.5, function()
        TPBtn.Text = "⚡ Teleport to Random Player"
    end)
end)

-- 7. Player ESP
local PlayerESPBtn =
    createButton("Player ESP: OFF", 7)

local playerHighlights = {}

local function applyPlayerESP(p)
    if p == LocalPlayer then
        return
    end

    p.CharacterAdded:Connect(function(char)

        if PlayerESPEnabled then

            local hl = Instance.new("Highlight", char)
            hl.FillColor = Color3.fromRGB(52, 152, 219)
            hl.OutlineColor = Color3.fromRGB(255, 255, 255)

            playerHighlights[p] = hl
        end

        p.CharacterRemoving:Connect(function()
            if playerHighlights[p] then
                playerHighlights[p] = nil
            end
        end)
    end)

    if p.Character and PlayerESPEnabled then

        local hl =
            Instance.new("Highlight", p.Character)

        hl.FillColor =
            Color3.fromRGB(52, 152, 219)

        playerHighlights[p] = hl
    end
end

PlayerESPBtn.MouseButton1Click:Connect(function()

    PlayerESPEnabled = not PlayerESPEnabled

    PlayerESPBtn.Text =
        "Player ESP: "
        .. (PlayerESPEnabled and "ON" or "OFF")

    PlayerESPBtn.BackgroundColor3 =
        PlayerESPEnabled
        and Color3.fromRGB(46, 204, 113)
        or Color3.fromRGB(40, 40, 45)

    if PlayerESPEnabled then

        for _, p in pairs(Players:GetPlayers()) do
            applyPlayerESP(p)
        end

    else

        for p, hl in pairs(playerHighlights) do
            if hl then
                hl:Destroy()
            end
        end

        playerHighlights = {}
    end
end)

Players.PlayerAdded:Connect(applyPlayerESP)

-- 8. Monster & Server Distance Linker ESP
local MonsterESPBtn =
    createButton("Monster Linker ESP: OFF", 8)

local activeLinks = {}

MonsterESPBtn.MouseButton1Click:Connect(function()

    MonsterESPEnabled = not MonsterESPEnabled

    MonsterESPBtn.Text =
        "Monster Linker ESP: "
        .. (MonsterESPEnabled and "ON" or "OFF")

    MonsterESPBtn.BackgroundColor3 =
        MonsterESPEnabled
        and Color3.fromRGB(46, 204, 113)
        or Color3.fromRGB(40, 40, 45)

    if not MonsterESPEnabled then

        for _, adornment in pairs(activeLinks) do
            adornment:Destroy()
        end

        activeLinks = {}
    end
end)

RunService.RenderStepped:Connect(function()

    if not MonsterESPEnabled
        or not LocalPlayer.Character
        or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then

        return
    end

    -- Clean old traces
    for _, adornment in pairs(activeLinks) do
        adornment:Destroy()
    end

    activeLinks = {}

    local myRoot =
        LocalPlayer.Character.HumanoidRootPart

    -- Scans Workspace for NPCs, Enemies, and Monsters
    for _, obj in pairs(workspace:GetDescendants()) do

        if obj:IsA("Humanoid")
            and obj.Parent
            and obj.Parent:IsA("Model")
            and obj.Parent ~= LocalPlayer.Character
            and not Players:GetPlayerFromCharacter(obj.Parent) then

            local enemyRoot =
                obj.Parent:FindFirstChild("HumanoidRootPart")
                or obj.Parent:FindFirstChild("Torso")

            if enemyRoot then

                -- Red Highlight Box
                local hl =
                    Instance.new("BoxHandleAdornment")

                hl.Size =
                    enemyRoot.Parent:GetExtentsSize()

                hl.AlwaysOnTop = true
                hl.ZIndex = 5
                hl.Color3 = Color3.fromRGB(231, 76, 60)
                hl.Adornee = enemyRoot
                hl.Transparency = 0.5
                hl.Parent = ScreenGui

                table.insert(activeLinks, hl)

                -- Laser Tracer beams connecting threat directly to player
                local line =
                    Instance.new("LineHandleAdornment")

                line.Length =
                    (myRoot.Position - enemyRoot.Position).Magnitude

                line.CFrame =
                    CFrame.lookAt(
                        myRoot.Position,
                        enemyRoot.Position
                    )

                line.AlwaysOnTop = true
                line.Thickness = 3
                line.ZIndex = 4
                line.Color3 = Color3.fromRGB(231, 76, 60)
                line.Adornee = myRoot
                line.Parent = ScreenGui

                table.insert(activeLinks, line)
            end
        end
    end
end)

-- YouTube Social Button
local YTBtn =
    createButton(
        "📺 YouTube: @animica",
        9,
        Color3.fromRGB(196, 30, 58)
    )

YTBtn.MouseButton1Click:Connect(function()

    local ytLink =
        "https://www.youtube.com/@animica"

    local clipSuccess, _ =
        pcall(function()
            setclipboard(ytLink)
        end)

    YTBtn.Text =
        clipSuccess
        and "✅ Link Copied!"
        or "❌ Couldn't Copy Link"

    task.wait(2)

    YTBtn.Text =
        "📺 YouTube: @animica"
end)
