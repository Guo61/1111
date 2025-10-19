local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SpeedLegendsUI"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 280, 0, 220)
mainFrame.Position = UDim2.new(0.5, 0, 0.3, 0)
mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Active = true
mainFrame.Draggable = true

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

local gradient = Instance.new("UIGradient")
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(45, 45, 60)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 40))
})
gradient.Rotation = 45
gradient.Parent = mainFrame

local shadow = Instance.new("UIStroke")
shadow.Color = Color3.fromRGB(80, 120, 200)
shadow.Thickness = 2
shadow.Transparency = 0.3
shadow.Parent = mainFrame

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
titleBar.BorderSizePixel = 0

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 10)
titleCorner.Parent = titleBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "Title"
titleLabel.Size = UDim2.new(1, -80, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "极速传奇"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextSize = 14
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 25, 0, 25)
minimizeButton.Position = UDim2.new(1, -60, 0, 2)
minimizeButton.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
minimizeButton.BackgroundTransparency = 0.8
minimizeButton.BorderSizePixel = 0
minimizeButton.Text = "−"
minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizeButton.TextSize = 18
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.AutoButtonColor = false

local minimizeCorner = Instance.new("UICorner")
minimizeCorner.CornerRadius = UDim.new(0, 4)
minimizeCorner.Parent = minimizeButton

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.new(0, 25, 0, 25)
closeButton.Position = UDim2.new(1, -30, 0, 2)
closeButton.BackgroundColor3 = Color3.fromRGB(220, 80, 80)
closeButton.BackgroundTransparency = 0.8
closeButton.BorderSizePixel = 0
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 18
closeButton.Font = Enum.Font.GothamBold
closeButton.AutoButtonColor = false

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 4)
closeCorner.Parent = closeButton

minimizeButton.Parent = titleBar
closeButton.Parent = titleBar
titleBar.Parent = mainFrame

local minimizedFrame = Instance.new("Frame")
minimizedFrame.Name = "MinimizedFrame"
minimizedFrame.Size = UDim2.new(0, 120, 0, 35)
minimizedFrame.Position = UDim2.new(0.5, 0, 0.1, 0)
minimizedFrame.AnchorPoint = Vector2.new(0.5, 0)
minimizedFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
minimizedFrame.BorderSizePixel = 0
minimizedFrame.Visible = false
minimizedFrame.Active = true
minimizedFrame.Draggable = true

local minimizedCorner = Instance.new("UICorner")
minimizedCorner.CornerRadius = UDim.new(0, 8)
minimizedCorner.Parent = minimizedFrame

local minimizedShadow = Instance.new("UIStroke")
minimizedShadow.Color = Color3.fromRGB(80, 120, 200)
minimizedShadow.Thickness = 2
minimizedShadow.Transparency = 0.3
minimizedShadow.Parent = minimizedFrame

local minimizedLabel = Instance.new("TextLabel")
minimizedLabel.Name = "MinimizedLabel"
minimizedLabel.Size = UDim2.new(1, -10, 1, 0)
minimizedLabel.Position = UDim2.new(0, 5, 0, 0)
minimizedLabel.BackgroundTransparency = 1
minimizedLabel.Text = "JYC"
minimizedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
minimizedLabel.Font = Enum.Font.GothamBold
minimizedLabel.TextSize = 12
minimizedLabel.TextXAlignment = Enum.TextXAlignment.Left
minimizedLabel.Parent = minimizedFrame

local restoreButton = Instance.new("TextButton")
restoreButton.Name = "RestoreButton"
restoreButton.Size = UDim2.new(0, 20, 0, 20)
restoreButton.Position = UDim2.new(1, -25, 0.5, 0)
restoreButton.AnchorPoint = Vector2.new(0, 0.5)
restoreButton.BackgroundColor3 = Color3.fromRGB(80, 150, 255)
restoreButton.BackgroundTransparency = 0.8
restoreButton.BorderSizePixel = 0
restoreButton.Text = "+"
restoreButton.TextColor3 = Color3.fromRGB(255, 255, 255)
restoreButton.TextSize = 14
restoreButton.Font = Enum.Font.GothamBold
restoreButton.AutoButtonColor = false

local restoreCorner = Instance.new("UICorner")
restoreCorner.CornerRadius = UDim.new(0, 4)
restoreCorner.Parent = restoreButton

restoreButton.Parent = minimizedFrame
minimizedFrame.Parent = screenGui

local contentFrame = Instance.new("Frame")
contentFrame.Name = "ContentFrame"
contentFrame.Size = UDim2.new(1, -20, 1, -40)
contentFrame.Position = UDim2.new(0, 10, 0, 35)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local autoRebirthToggle = Instance.new("TextButton")
autoRebirthToggle.Name = "AutoRebirthToggle"
autoRebirthToggle.Size = UDim2.new(1, 0, 0, 35)
autoRebirthToggle.Position = UDim2.new(0, 0, 0, 10)
autoRebirthToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
autoRebirthToggle.Text = "自动重生:关闭"
autoRebirthToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
autoRebirthToggle.Font = Enum.Font.GothamSemibold
autoRebirthToggle.TextSize = 12
autoRebirthToggle.AutoButtonColor = true

local rebirthCorner = Instance.new("UICorner")
rebirthCorner.CornerRadius = UDim.new(0, 6)
rebirthCorner.Parent = autoRebirthToggle

local rebirthStroke = Instance.new("UIStroke")
rebirthStroke.Color = Color3.fromRGB(100, 150, 255)
rebirthStroke.Thickness = 1
rebirthStroke.Transparency = 0.5
rebirthStroke.Parent = autoRebirthToggle

local autoExpToggle = Instance.new("TextButton")
autoExpToggle.Name = "AutoExpToggle"
autoExpToggle.Size = UDim2.new(1, 0, 0, 35)
autoExpToggle.Position = UDim2.new(0, 0, 0, 55)
autoExpToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
autoExpToggle.Text = "刷经验:关闭"
autoExpToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
autoExpToggle.Font = Enum.Font.GothamSemibold
autoExpToggle.TextSize = 12
autoExpToggle.AutoButtonColor = true

local expCorner = Instance.new("UICorner")
expCorner.CornerRadius = UDim.new(0, 6)
expCorner.Parent = autoExpToggle

local expStroke = Instance.new("UIStroke")
expStroke.Color = Color3.fromRGB(100, 150, 255)
expStroke.Thickness = 1
expStroke.Transparency = 0.5
expStroke.Parent = autoExpToggle

local statusFrame = Instance.new("Frame")
statusFrame.Name = "StatusFrame"
statusFrame.Size = UDim2.new(1, 0, 0, 25)
statusFrame.Position = UDim2.new(0, 0, 0, 100)
statusFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
statusFrame.BorderSizePixel = 0

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 6)
statusCorner.Parent = statusFrame

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "Status"
statusLabel.Size = UDim2.new(1, -10, 1, 0)
statusLabel.Position = UDim2.new(0, 5, 0, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "状态:未运行"
statusLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 11
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = statusFrame

local footerLabel = Instance.new("TextLabel")
footerLabel.Name = "Footer"
footerLabel.Size = UDim2.new(1, 0, 0, 15)
footerLabel.Position = UDim2.new(0, 0, 1, -20)
footerLabel.BackgroundTransparency = 1
footerLabel.Text = "QQ:3395858053"
footerLabel.TextColor3 = Color3.fromRGB(150, 150, 180)
footerLabel.Font = Enum.Font.Gotham
footerLabel.TextSize = 10
footerLabel.Parent = contentFrame

autoRebirthToggle.Parent = contentFrame
autoExpToggle.Parent = contentFrame
statusFrame.Parent = contentFrame
statusLabel.Parent = statusFrame
mainFrame.Parent = screenGui
screenGui.Parent = playerGui

local isAutoRebirthRunning = false
local isAutoExpRunning = false
local rebirthConnection = nil
local expConnection = nil

local function toggleAutoRebirth()
    isAutoRebirthRunning = not isAutoRebirthRunning
    
    if isAutoRebirthRunning then
        autoRebirthToggle.Text = "自动重生:开启"
        autoRebirthToggle.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
        statusLabel.Text = "状态:自动重生运行中"
        
        rebirthConnection = game:GetService("RunService").Heartbeat:Connect(function()
            local A_1 = "rebirthRequest"
            local Event = game:GetService("ReplicatedStorage").rEvents.rebirthEvent
            Event:FireServer(A_1)
        end)
    else
        autoRebirthToggle.Text = "自动重生:关闭"
        autoRebirthToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        statusLabel.Text = "状态:未运行"
        
        if rebirthConnection then
            rebirthConnection:Disconnect()
            rebirthConnection = nil
        end
    end
end

local function toggleAutoExp()
    isAutoExpRunning = not isAutoExpRunning
    
    if isAutoExpRunning then
        autoExpToggle.Text = "刷经验:开启"
        autoExpToggle.BackgroundColor3 = Color3.fromRGB(80, 180, 80)
        statusLabel.Text = "状态:刷经验运行中"
        
        expConnection = game:GetService("RunService").Heartbeat:Connect(function()
            local orbs = {"Gem", "Yellow Orb", "Orange Orb", "Blue Orb"}
            for _, orb in ipairs(orbs) do
                local A_1 = "collectOrb"
                local A_2 = orb
                local A_3 = "City"
                local Event = game:GetService("ReplicatedStorage").rEvents.orbEvent
                Event:FireServer(A_1, A_2, A_3)
            end
        end)
    else
        autoExpToggle.Text = "刷经验:关闭"
        autoExpToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
        statusLabel.Text = "状态:未运行"
        
        if expConnection then
            expConnection:Disconnect()
            expConnection = nil
        end
    end
end

autoRebirthToggle.MouseButton1Click:Connect(toggleAutoRebirth)
autoExpToggle.MouseButton1Click:Connect(toggleAutoExp)

local function minimizeWindow()
    local tweenOut = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 10, 0, 10),
        Position = UDim2.new(0.5, 0, 0.3, 0)
    })
    
    tweenOut:Play()
    tweenOut.Completed:Wait()
    
    mainFrame.Visible = false
    minimizedFrame.Visible = true
    
    local currentPos = mainFrame.Position
    minimizedFrame.Position = UDim2.new(currentPos.X.Scale, currentPos.X.Offset, currentPos.Y.Scale, currentPos.Y.Offset - 0.05)
end

local function restoreWindow()
    local tweenIn = TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 280, 0, 220)
    })
    
    minimizedFrame.Visible = false
    mainFrame.Visible = true
    tweenIn:Play()
end

minimizeButton.MouseButton1Click:Connect(minimizeWindow)
restoreButton.MouseButton1Click:Connect(restoreWindow)

minimizeButton.MouseEnter:Connect(function()
    minimizeButton.BackgroundTransparency = 0.5
end)

minimizeButton.MouseLeave:Connect(function()
    minimizeButton.BackgroundTransparency = 0.8
end)

restoreButton.MouseEnter:Connect(function()
    restoreButton.BackgroundTransparency = 0.5
end)

restoreButton.MouseLeave:Connect(function()
    restoreButton.BackgroundTransparency = 0.8
end)

closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

closeButton.MouseEnter:Connect(function()
    closeButton.BackgroundTransparency = 0.5
end)

closeButton.MouseLeave:Connect(function()
    closeButton.BackgroundTransparency = 0.8
end)

local function buttonHoverEffect(button)
    button.MouseEnter:Connect(function()
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(80, 80, 100)
        })
        tween:Play()
    end)
    
    button.MouseLeave:Connect(function()
        local targetColor = button.Text:find("开启") and Color3.fromRGB(80, 180, 80) or Color3.fromRGB(60, 60, 80)
        local tween = TweenService:Create(button, TweenInfo.new(0.2), {
            BackgroundColor3 = targetColor
        })
        tween:Play()
    end)
end

buttonHoverEffect(autoRebirthToggle)
buttonHoverEffect(autoExpToggle)

local function animateEntrance()
    mainFrame.Size = UDim2.new(0, 10, 0, 10)
    mainFrame.Position = UDim2.new(0.5, 0, 0.3, 0)
    
    local tween = TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 280, 0, 220)
    })
    tween:Play()
end

animateEntrance()

screenGui.DisplayOrder = 999