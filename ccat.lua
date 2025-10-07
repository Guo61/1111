local success, Library = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/OPEN-SOURCE-UI-ROBLOX/refs/heads/main/X2ZU%20UI%20ROBLOX%20OPEN%20SOURCE/DummyUi-leak-by-x2zu/fetching-main/Tools/Framework.luau"))()
end)

if not success or not Library then
    Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()
end

local Window = Library:Window({
    Title = "郝蕾 Hub",
    Desc = "需要时开启反挂机",
    Icon = "skull",
    Theme = "Dark",
    Config = {
        Keybind = Enum.KeyCode.LeftControl,
        Size = UDim2.new(0, 500, 0, 350)
    },
    CloseUIButton = {
        Enabled = true,
        Text = "打开/关闭"
    }
})

task.spawn(function()
    repeat task.wait() until Window and Window:FindFirstChild("Main") ~= nil
    
    local SidebarLine = Instance.new("Frame")
    SidebarLine.Size = UDim2.new(0, 1, 1, 0)
    SidebarLine.Position = UDim2.new(0, 140, 0, 0)
    SidebarLine.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SidebarLine.BorderSizePixel = 0
    SidebarLine.ZIndex = 5
    SidebarLine.Name = "SidebarLine"
    
    local mainFrame = Window:FindFirstChild("Main")
    if mainFrame then
        SidebarLine.Parent = mainFrame
    end
end)

local ranks = {"Rank 1", "Rank 2", "Rank 3", "Rank 4", "Rank 5", "Rank 6", "Rank 7", "Rank 8", "Rank 9", "Rank 10"}

_G.Stepped = nil
_G.Clipon = false
_G.rebirthLoop = false
_G.autoBrawl = false

local autoOrbStates = {
    orange = {isRunning = false, shouldStop = false},
    red = {isRunning = false, shouldStop = false},
    yellow = {isRunning = false, shouldStop = false},
    gem = {isRunning = false, shouldStop = false},
    blue = {isRunning = false, shouldStop = false}
}

function identifyDevice()
    local userInputService = game:GetService("UserInputService")
    local platform = userInputService:GetPlatform()
    
    if platform == Enum.Platform.Windows or platform == Enum.Platform.OSX or platform == Enum.Platform.Linux then
        return "电脑 (PC)"
    elseif platform == Enum.Platform.IOS then
        return "移动端 (iOS)"
    elseif platform == Enum.Platform.Android then
        return "移动端 (Android)"
    elseif platform == Enum.Platform.XBoxOne or platform == Enum.Platform.PS4 then
        return "游戏主机"
    else
        return "其他设备"
    end
end

local antiWalkFlingConn

local function enableAntiWalkFling()
    if antiWalkFlingConn then
        antiWalkFlingConn:Disconnect()
    end
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")

    local MAX_VELOCITY_MAGNITUDE = 80
    local TELEPORT_BACK_ON_FLING = true
    local lastPositions = {}

    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            local humanoid = character:WaitForChild("Humanoid")
            local rootPart = character:WaitForChild("HumanoidRootPart")

            humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
            
            lastPositions[player.UserId] = rootPart.Position
        end)
    end)

    antiWalkFlingConn = RunService.Heartbeat:Connect(function()
        for _, player in ipairs(Players:GetPlayers()) do
            local character = player.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                local humanoid = character:FindFirstChild("Humanoid")
                
                if rootPart and humanoid and humanoid.Health > 0 then
                    local currentVelocity = rootPart.AssemblyLinearVelocity
                    local velocityMagnitude = currentVelocity.Magnitude

                    if velocityMagnitude > MAX_VELOCITY_MAGNITUDE then
                        if TELEPORT_BACK_ON_FLING and lastPositions[player.UserId] then
                            rootPart.CFrame = CFrame.new(lastPositions[player.UserId])
                        end
                        
                        rootPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                    else
                        lastPositions[player.UserId] = rootPart.Position
                    end
                end
            end
        end
    end)
end

local function disableAntiWalkFling()
    if antiWalkFlingConn then
        antiWalkFlingConn:Disconnect()
        antiWalkFlingConn = nil
    end
end

local espEnabled = false
local espConnections = {}
local espHighlights = {}
local espNameTags = {}

local function createESP(player)
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = char:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "CatHub_ESP"
    highlight.Adornee = char
    highlight.FillColor = Color3.new(1, 0, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = char
    espHighlights[player] = highlight

    local nameTag = Instance.new("BillboardGui")
    nameTag.Name = "CatHub_NameTag"
    nameTag.Adornee = humanoidRootPart
    nameTag.Size = UDim2.new(0, 150, 0, 20)
    nameTag.StudsOffset = Vector3.new(0, 2.8, 0)
    nameTag.AlwaysOnTop = true
    nameTag.Parent = humanoidRootPart
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = player.Name
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextSize = 14
    textLabel.TextScaled = false
    textLabel.Parent = nameTag
    espNameTags[player] = nameTag
end

local function removeESP(player)
    if espHighlights[player] and espHighlights[player].Parent then
        espHighlights[player]:Destroy()
        espHighlights[player] = nil
    end
    if espNameTags[player] and espNameTags[player].Parent then
        espNameTags[player]:Destroy()
        espNameTags[player] = nil
    end
end

local function toggleESP(state)
    espEnabled = state
    if state then
        for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                pcall(createESP, player)
            end
        end

        espConnections.playerAdded = game.Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Wait()
            pcall(createESP, player)
        end)
        espConnections.playerRemoving = game.Players.PlayerRemoving:Connect(function(player)
            removeESP(player)
        end)
    else
        if espConnections.playerAdded then espConnections.playerAdded:Disconnect() end
        if espConnections.playerRemoving then espConnections.playerRemoving:Disconnect() end
        for player, _ in pairs(espHighlights) do
            removeESP(player)
        end
        espHighlights = {}
        espNameTags = {}
    end
end

local selectedPlayer = nil
local playerDropdown

local function getPlayerNames()
    local names = {}
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(names, player.Name)
        end
    end
    return names
end

local Tab = Window:Tab({Title = "主页", Icon = "crown"})

Tab:Section({Title = "By 郝蕾\n脚本免费 请勿倒卖"})

Tab:Button({
    Title = "设备信息",
    Description = "显示当前设备信息",
    Callback = function()
        Window:Notify({
            Title = "设备信息",
            Desc = "当前设备: " .. identifyDevice(),
            Time = 5
        })
    end
})

Tab:Button({  
    Title = "反挂机",  
    Desc = "不要随意开启!",  
    Description = "从Github加载并执行反挂机",  
    Callback = function()  
        Window:Notify({  
            Title = "Cat Hub",  
            Desc = "正在加载反挂机脚本...",  
            Time = 3  
        })  

        print("开始加载反挂机脚本...")  

        local url = "https://raw.githubusercontent.com/Guo61/Cat-/refs/heads/main/%E5%8F%8D%E6%8C%82%E6%9C%BA.lua"

        local success, response = pcall(function()  
            return game:HttpGet(url, true)  
        end)  

        if success and response and #response > 100 then  
            print("脚本加载成功")  

            local executeSuccess, executeError = pcall(function()  
                loadstring(response)()  
            end)  

            if executeSuccess then  
                Window:Notify({  
                    Title = "郝蕾Hub",  
                    Desc = "反挂机脚本加载并执行成功!",  
                    Time = 5  
                })  
                print("反挂机脚本执行成功")  
            else  
                Window:Notify({  
                    Title = "郝蕾",  
                    Desc = "脚本执行错误: " .. tostring(executeError),  
                    Time = 5  
                })  
                warn("脚本执行失败:", executeError)  
            end  

        else  
            Window:Notify({  
                Title = "郝蕾Hub",  
                Desc = "反挂机脚本加载失败，请检查网络",  
                Time = 5  
            })  
            warn("脚本加载失败")  
        end  

        print("加载完毕并执行")  
    end  
})

Tab:Button({
    Title = "显示FPS",
    Description = "在屏幕上显示当前FPS",
    Callback = function()
        local FpsGui = Instance.new("ScreenGui") 
        local FpsXS = Instance.new("TextLabel") 
        FpsGui.Name = "FPSGui" 
        FpsGui.ResetOnSpawn = false 
        FpsGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling 
        FpsXS.Name = "FpsXS" 
        FpsXS.Size = UDim2.new(0, 100, 0, 50) 
        FpsXS.Position = UDim2.new(0, 10, 0, 10) 
        FpsXS.BackgroundTransparency = 1 
        FpsXS.Font = Enum.Font.SourceSansBold 
        FpsXS.Text = "FPS: 0" 
        FpsXS.TextSize = 20 
        FpsXS.TextColor3 = Color3.new(1, 1, 1) 
        FpsXS.Parent = FpsGui 
        
        local function updateFpsXS()
            local fps = math.floor(1 / game:GetService("RunService").RenderStepped:Wait())
            FpsXS.Text = "FPS: " .. fps
        end 
        
        game:GetService("RunService").RenderStepped:Connect(updateFpsXS) 
        FpsGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
        
        Window:Notify({
            Title = "郝蕾Hub",
            Desc = "FPS显示已开启",
            Time = 3
        })
    end
})

Tab:Toggle({
    Title = "显示范围",
    Desc = "显示玩家范围",
    Callback = function(state)
        local HeadSize = 20
        local highlight = Instance.new("Highlight")
        highlight.Adornee = nil
        highlight.OutlineTransparency = 0
        highlight.FillTransparency = 0.7
        highlight.FillColor = Color3.fromHex("#0000FF")

        local function applyHighlight(character)
            if not character:FindFirstChild("CatHub_RangeHighlight") then
                local clone = highlight:Clone()
                clone.Adornee = character
                clone.Name = "CatHub_RangeHighlight"
                clone.Parent = character
            end
        end

        local function removeHighlight(character)
            local h = character:FindFirstChild("CatHub_RangeHighlight")
            if h then
                h:Destroy()
            end
        end

        if state then
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player.Name ~= game.Players.LocalPlayer.Name and player.Character then
                    applyHighlight(player.Character)
                end
            end
            game.Players.PlayerAdded:Connect(function(player)
                player.CharacterAdded:Connect(function(character)
                    task.wait(1)
                    applyHighlight(character)
                end)
            end)
            game.Players.PlayerRemoving:Connect(function(player)
                if player.Character then
                    removeHighlight(player.Character)
                end
            end)
        else
            for _, player in ipairs(game.Players:GetPlayers()) do
                if player.Character then
                    removeHighlight(player.Character)
                end
            end
        end
    end
})

Tab:Button({
    Title = "半隐身",
    Desc = "悬浮窗关不掉",
    Description = "从GitHub加载并执行隐身脚本",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invisible-35376"))()
        print("隐身脚本已加载并执行")
    end
})

Tab:Button({
    Title = "玩家入退提示",
    Description = "从GitHub加载并执行提示脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua"))()
        print("提示脚本已加载并执行")
    end
})

Tab:Button({
    Title = "甩飞",
    Description = "从GitHub加载并执行甩飞脚本",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
        print("甩飞脚本已加载并执行")
    end
})

Tab:Toggle({
    Title = "防甩飞",
    Desc = "不要和甩飞同时开启!",
    Callback = function(state)
        if state then
            enableAntiWalkFling()
            Window:Notify({
                Title = "防甩飞",
                Desc = "防甩飞已开启",
                Time = 3
            })
        else
            disableAntiWalkFling()
            Window:Notify({
                Title = "防甩飞",
                Desc = "防甩飞已关闭",
                Time = 3
            })
        end
    end
})

Tab:Toggle({
    Title = "人物透视 (ESP)",
    Desc = "显示其他玩家的透视框和名字",
    Default = false,
    Callback = toggleESP
})

playerDropdown = Tab:Dropdown({
    Title = "选择要传送的玩家",
    Values = getPlayerNames(),
    Callback = function(value)
        selectedPlayer = value
        Window:Notify({
            Title = "玩家选择",
            Desc = "已选择玩家: " .. value,
            Time = 2
        })
    end
})

Tab:Button({
    Title = "传送至选中玩家",
    Desc = "传送到选中的玩家",
    Callback = function()
        if not selectedPlayer then
            Window:Notify({
                Title = "传送失败",
                Desc = "请先选择一个玩家",
                Time = 3
            })
            return
        end
        
        local targetPlayer = game.Players:FindFirstChild(selectedPlayer)
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local character = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            humanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
            Window:Notify({
                Title = "传送成功",
                Desc = "已传送到玩家: " .. selectedPlayer,
                Time = 3
            })
        else
            Window:Notify({
                Title = "传送失败",
                Desc = "无法找到目标玩家或玩家没有角色",
                Time = 3
            })
        end
    end
})

local function refreshPlayerList()
    if playerDropdown then
        local newPlayers = getPlayerNames()
        
        Window:Notify({
            Title = "玩家列表",
            Desc = "玩家列表已刷新，当前玩家数: " .. (#newPlayers),
            Time = 3
        })
    end
end

Tab:Button({
    Title = "刷新玩家列表",
    Desc = "手动刷新可传送的玩家列表",
    Callback = function()
        refreshPlayerList()
    end
})

Tab:Slider({
    Title = "设置速度",
    Desc = "可输入",
    Min = 0,
    Max = 520,
    Rounding = 0,
    Value = 25,
    Callback = function(val)
        local player = game.Players.LocalPlayer
        local character = player.Character
        if not character then
            character = player.CharacterAdded:Wait()
        end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = val
            print("人物行走速度已设置为:", val)
        else
            print("未找到人类oid对象，无法设置速度")
        end
    end
})

Tab:Slider({
    Title = "设置个人重力",
    Desc = "默认值即为最大值",
    Min = 0,
    Max = 196.2,
    Rounding = 1,
    Value = 196.2,
    Callback = function(val)
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local rootPart = character:WaitForChild("HumanoidRootPart", 10) 
        if not rootPart then
            print("等待HumanoidRootPart超时")
            return
        end

        local oldGravity = rootPart:FindFirstChild("PersonalGravity")
        if oldGravity then
            oldGravity:Destroy()
        end

        if val ~= workspace.Gravity then
            local personalGravity = Instance.new("BodyForce")
            personalGravity.Name = "PersonalGravity"
            local mass = rootPart:GetMass()
            local force = Vector3.new(0, mass * (workspace.Gravity - val), 0)
            personalGravity.Force = force
            personalGravity.Parent = rootPart
            print("个人重力已设置为:", val, "，力大小：", force.Y)
        else
            print("个人重力已恢复默认")
        end
    end
})

Tab:Slider({
    Title = "设置跳跃高度",
    Desc = "可输入",
    Min = 0,
    Max = 200,
    Rounding = 0,
    Value = 50,
    Callback = function(val)
        local player = game.Players.LocalPlayer
        local character = player.Character
        if not character then
            character = player.CharacterAdded:Wait()
        end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.JumpPower = val
            print("人物跳跃力量已设置为:", val)
        else
            print("未找到人类oid对象，无法设置跳跃高度")
        end
    end
})

Tab:Button({
    Title = "飞行",
    Description = "从GitHub加载并执行飞行脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/Cat-/refs/heads/main/%E9%A3%9E%E8%A1%8C%E8%84%9A%E6%9C%AC.lua"))()
        print("飞行脚本已加载并执行")
    end
})

Tab:Button({
    Title = "无限跳",
    Desc = "概率关不了",
    Description = "从GitHub加载并执行无限跳脚本",
    Callback = function()
       loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))()
        print("无限跳已加载并执行")
    end
})

Tab:Button({
    Title = "自瞄",
    Desc = "宙斯自瞄",
    Description = "从GitHub加载并执行自瞄脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/main/Arceus%20Aimbot.lua"))()
        print("自瞄已加载并执行")
    end
})

Tab:Toggle({
    Title = "子弹追踪",
    Default = false,
    Callback = function(state)
    end
})

Tab:Toggle({
    Title = "夜视",
    Default = false,
    Callback = function(isEnabled)
    end
})

Tab:Toggle({
    Title = "穿墙",
    Default = false,
    Callback = function(NC)
    end
})

Tab:Button({
    Title = "切换服务器",
    Desc = "切换到相同游戏的另一个服务器",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local placeId = game.PlaceId
        
        TeleportService:Teleport(placeId, game.Players.LocalPlayer)
        Window:Notify({
            Title = "服务器",
            Desc = "正在切换服务器...",
            Time = 3
        })
    end
})

Tab:Button({
    Title = "重新加入服务器",
    Desc = "尝试重新加入当前服务器",
    Callback = function()
        local TeleportService = game:GetService("TeleportService")
        local placeId = game.PlaceId
        local jobId = game.JobId
        
        TeleportService:TeleportToPlaceInstance(placeId, jobId, game.Players.LocalPlayer)
        Window:Notify({
            Title = "服务器",
            Desc = "正在重新加入服务器...",
            Time = 3
        })
    end
})

Tab:Button({
    Title = "复制服务器邀请链接",
    Desc = "复制当前服务器的邀请链接到剪贴板",
    Callback = function()
        local inviteLink = "roblox://experiences/start?placeId=" .. game.PlaceId .. "&gameInstanceId=" .. game.JobId
        setclipboard(inviteLink)
        Window:Notify({
            Title = "服务器",
            Desc = "邀请链接已复制到剪贴板",
            Time = 3
        })
    end
})

Tab:Button({
    Title = "复制服务器ID",
    Desc = "复制当前服务器的Job ID到剪贴板",
    Callback = function()
        setclipboard(game.JobId)
        Window:Notify({
            Title = "服务器",
            Desc = "服务器ID已复制: " .. game.JobId,
            Time = 3
        })
    end
})

Tab:Button({
    Title = "服务器信息",
    Desc = "显示当前服务器的信息",
    Callback = function()
        local players = game.Players:GetPlayers()
        local maxPlayers = game.Players.MaxPlayers
        local placeId = game.PlaceId
        local jobId = game.JobId
        local serverType = game:GetService("RunService"):IsStudio() and "Studio" or "Live"
        
        Window:Notify({
            Title = "服务器信息",
            Desc = string.format("玩家数量: %d/%d\nPlace ID: %d\nJob ID: %s\n服务器类型: %s", #players, maxPlayers, placeId, jobId, serverType),
            Time = 10
        })
    end
})

local CodeBlock = Tab:Code({
    Title = "Love Players",
    Code = "感谢游玩\nQQ号:3395858053"
})

task.delay(5, function()
    CodeBlock:SetCode("感谢游玩\nQQ号:3395858053")
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("HumanoidRootPart", 10)
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        local oldGravity = rootPart:FindFirstChild("PersonalGravity")
        if oldGravity then
            oldGravity:Destroy()
            print("角色重置，旧个人重力已清理")
        end
    end
end)

Window:Line()

local Extra = Window:Tab({Title = "极速传奇", Icon = "zap"})

local CodeBlock = Extra:Code({
Title = "提示!!!",
Code = "传送功能请勿在其他服务器执行\n该服务器功能暂未补全"
})

task.delay(5, function()
    CodeBlock:SetCode("传送功能请勿在其他服务器执行\n该服务器功能暂未补全")
end)

Extra:Section({Title = "传送", Icon = "wrench"})
Extra:Button({
    Title = "城市",
    Desc = "单击以执行",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.CFrame = CFrame.new(-534.38, 4.07, 437.75)
        Window:Notify({
            Title = "通知",
            Desc = "传送成功",
            Time = 1
        })
    end
})
    
Extra:Button({
    Title = "神秘洞穴",
    Desc = "单击以执行",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.CFrame = CFrame.new(-9683.05, 59.25, 3136.63)
        Window:Notify({
            Title = "通知",
            Desc = "传送成功",
            Time = 1
        })
    end
})

Extra:Button({
    Title = "草地挑战",
    Desc = "单击以执行",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.CFrame = CFrame.new(-1550.49, 34.51, 87.48)
        Window:Notify({
            Title = "通知",
            Desc = "传送成功",
            Time = 1
        })
    end
})

Extra:Button({
    Title = "海市蜃楼挑战",
    Desc = "单击以执行",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.CFrame = CFrame.new(1414.31, 90.44, -2058.34)
        Window:Notify({
            Title = "通知",
            Desc = "传送成功",
            Time = 1
        })
    end
})

Extra:Button({
    Title = "冰霜挑战",
    Desc = "单击以执行",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.CFrame = CFrame.new(2045.63, 64.57, 993.17)
        Window:Notify({
            Title = "通知",
            Desc = "传送成功",
            Time = 1
        })
    end
})

Extra:Button({
    Title = "绿色水晶",
    Desc = "单击以执行",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.CFrame = CFrame.new(385.60, 65.02, 19.00)
        Window:Notify({
            Title = "通知",
            Desc = "传送成功",
            Time = 1
        })
    end
})

Extra:Button({
    Title = "蓝色水晶",
    Desc = "单击以执行",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.CFrame = CFrame.new(-581.56, 4.12, 495.92)
        Window:Notify({
            Title = "通知",
            Desc = "传送成功",
            Time = 1
        })
    end
})

Extra:Button({
    Title = "紫色水晶",
    Desc = "单击以执行",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.CFrame = CFrame.new(-428.17, 4.12, 203.52)
        Window:Notify({
            Title = "通知",
            Desc = "传送成功",
            Time = 1
        })
    end
})

Extra:Button({
    Title = "黄色水晶",
    Desc = "单击以执行",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.CFrame = CFrame.new(-313.23, 4.12, -375.43)
        Window:Notify({
            Title = "通知",
            Desc = "传送成功",
            Time = 1
        })
    end
})

Extra:Button({
    Title = "欧米茄水晶",
    Desc = "单击以执行",
    Callback = function()
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        humanoidRootPart.CFrame = CFrame.new(4532.49, 74.45, 6398.68)
        Window:Notify({
            Title = "通知",
            Desc = "传送成功",
            Time = 1
        })
    end
})

Extra:Section({Title = "自动", Icon = "wrench"})

Extra:Toggle({
    Title = "自动重生",
    Desc = "ARS",
    Default = false,
    Callback = function(ARS)
        if ARS then
            _G.rebirthLoop = true
            while _G.rebirthLoop and task.wait() do
                game:GetService("ReplicatedStorage").rEvents.rebirthEvent:FireServer("rebirthRequest")
            end
        else
            _G.rebirthLoop = false
        end
    end
})

Extra:Button({
    Title = "自动重生和自动刷等级",
    Desc = "单击执行",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/T9wTL150"))()
    end
})

local isRunning = false
local shouldStop = false

Extra:Button({
    Title = "自动吃橙球(city)",
    Desc = "单击以执行/停止",
    Callback = function()
        if not isRunning then
            spawn(function()
                shouldStop = false
                while true do
                    if shouldStop then
                        break
                    end
                    local args = {
                        "collectOrb",
                        "Orange Orb",
                        "City"
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("orbEvent"):FireServer(unpack(args))
                    wait(0.5)
                end
                isRunning = false
            end)
            isRunning = true
            Window:Notify({
                Title = "通知",
                Desc = "正在执行",
                Time = 1
            })
        else
            shouldStop = true
            isRunning = false
            Window:Notify({
                Title = "通知",
                Desc = "已停止执行",
                Time = 1
            })
        end
    end
})

Extra:Button({
    Title = "自动吃红球(city)",
    Desc = "单击以执行/停止",
    Callback = function()
        if not isRunning then
            spawn(function()
                shouldStop = false
                while true do
                    if shouldStop then
                        break
                    end
                    local args = {
                        "collectOrb",
                        "Red Orb",
                        "City"
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("orbEvent"):FireServer(unpack(args))
                    wait(0.5)
                end
                isRunning = false
            end)
            isRunning = true
            Window:Notify({
                Title = "通知",
                Desc = "正在执行",
                Time = 1
            })
        else
            shouldStop = true
            isRunning = false
            Window:Notify({
                Title = "通知",
                Desc = "已停止执行",
                Time = 1
            })
        end
    end
})

local isRunning = false
local shouldStop = false

Extra:Button({
    Title = "自动吃黄球(city)",
    Desc = "单击以执行/停止",
    Callback = function()
        if not isRunning then
            spawn(function()
                shouldStop = false
                while true do
                    if shouldStop then
                        break
                    end
                    local args = {
                        "collectOrb",
                        "Yellow Orb",
                        "City"
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("orbEvent"):FireServer(unpack(args))
                    wait(0.5)
                end
                isRunning = false
            end)
            isRunning = true
            Window:Notify({
                Title = "通知",
                Desc = "正在执行",
                Time = 1
            })
        else
            shouldStop = true
            isRunning = false
            Window:Notify({
                Title = "通知",
                Desc = "已停止执行",
                Time = 1
            })
        end
    end
})

Extra:Button({
    Title = "自动收集宝石(City)",
    Desc = "单击以执行/停止",
    Callback = function()
        if not isRunning then
            spawn(function()
                shouldStop = false
                while true do
                    if shouldStop then
                        break
                    end
                    local args = {
                        "collectOrb",
                        "Gem",
                        "City"
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("orbEvent"):FireServer(unpack(args))
                    wait(0.5)
                end
                isRunning = false
            end)
            isRunning = true
            Window:Notify({
                Title = "通知",
                Desc = "正在执行自动收集宝石",
                Time = 1
            })
        else
            shouldStop = true
            isRunning = false
            Window:Notify({
                Title = "通知",
                Desc = "已停止自动收集宝石",
                Time = 1
            })
        end
    end
})

local isRunning = false
local shouldStop = false

Extra:Button({
    Title = "自动吃蓝球(city)",
    Desc = "单击以执行/停止",
    Callback = function()
        if not isRunning then
            spawn(function()
                shouldStop = false
                while true do
                    if shouldStop then
                        break
                    end
                    local args = {
                        "collectOrb",
                        "Blue Orb",
                        "City"
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("rEvents"):WaitForChild("orbEvent"):FireServer(unpack(args))
                    wait(0.5)
                end
                isRunning = false
            end)
            isRunning = true
            Window:Notify({
                Title = "通知",
                Desc = "正在执行",
                Time = 1
            })
        else
            shouldStop = true
            isRunning = false
            Window:Notify({
                Title = "通知",
                Desc = "已停止执行",
                Time = 1
            })
        end
    end
})

local NinjaTab = Window:Tab({Title = "忍者传奇", Icon = 105059922903197})
NinjaTab:Section({Title = "执行以下功能时请手持剑\n传送功能请勿在其他服务器执行"})

NinjaTab:Toggle({
    Title = "自动挥剑",
    Default = false,
    Callback = function(ATHW)
        getgenv().autoswing = ATHW
        while getgenv().autoswing do
            if not getgenv().autoswing then return end
            
            for _, tool in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if tool:FindFirstChild("ninjitsuGain") then
                    game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                    break
                end
            end
            
            local A_1 = "swingKatana"
            game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(A_1)
            wait()
        end
    end
})

NinjaTab:Toggle({
    Title = "自动售卖",
    Default = false,
    Callback = function(ATSELL)
        getgenv().autosell = ATSELL 
        while getgenv().autosell do
            if not getgenv().autosell then return end
            local sellArea = game:GetService("Workspace").sellAreaCircles["sellAreaCircle16"]
            if sellArea then
                sellArea.circleInner.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                wait(0.1)
                sellArea.circleInner.CFrame = CFrame.new(0,0,0)
                wait(0.1)
            end
        end
    end
})

NinjaTab:Toggle({
    Title = "自动购买排名",
    Default = false,
    Callback = function(ATBP)
        getgenv().autobuyranks = ATBP 
        while getgenv().autobuyranks do
            if not getgenv().autobuyranks then return end
            local deku1 = "buyRank"
            for i = 1, #ranks do
                game:GetService("Players").LocalPlayer.ninjaEvent:FireServer(deku1, ranks[i])
            end
            wait(0.1)
        end
    end
})

NinjaTab:Toggle({
    Title = "自动购买腰带",
    Default = false,
    Callback = function(ATBYD)
        getgenv().autobuybelts = ATBYD 
        while getgenv().autobuybelts do
            if not getgenv().autobuybelts then return end
            local A_1 = "buyAllBelts"
            local A_2 = "Inner Peace Island"
            local Event = game:GetService("Players").LocalPlayer.ninjaEvent
            Event:FireServer(A_1, A_2)
            wait(0.5)
        end
    end
})

NinjaTab:Toggle({
    Title = "自动购买技能",
    Default = false,
    Callback = function(ATB)
        getgenv().autobuyskills = ATB 
        while getgenv().autobuyskills do
            if not getgenv().autobuyskills then return end
            local A_1 = "buyAllSkills"
            local A_2 = "Inner Peace Island"
            local Event = game:GetService("Players").LocalPlayer.ninjaEvent
            Event:FireServer(A_1, A_2)
            wait(0.5)
        end
    end
})

NinjaTab:Toggle({
    Title = "自动购买剑",
    Default = false,
    Callback = function(ATBS)
        getgenv().autobuy = ATBS 
        while getgenv().autobuy do
            if not getgenv().autobuy then return end
            local A_1 = "buyAllSwords"
            local A_2 = "Inner Peace Island"
            local Event = game:GetService("Players").LocalPlayer.ninjaEvent
            Event:FireServer(A_1, A_2)
            wait(0.5)
        end
    end
})

NinjaTab:Button({
    Title = "解锁所有岛",
    Callback = function()
        for _, v in next, game.workspace.islandUnlockParts:GetChildren() do
            if v then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.islandSignPart.CFrame
                wait(0.5)
            end
        end
    end
})

NinjaTab:Section({Title = "传送功能", Icon = "map-pin"})

local basicIslands = {
    {"出生点", CFrame.new(25.665502548217773, 3.4228405952453613, 29.919952392578125)},
    {"附魔岛", CFrame.new(51.17238235473633, 766.1807861328125, -138.44842529296875)},
    {"神秘岛", CFrame.new(171.97178449902344, 4047.380859375, 42.0699577331543)},
    {"太空岛", CFrame.new(148.83824157714844, 5657.18505859375, 73.5014877319336)},
    {"冻土岛", CFrame.new(139.28330993652344, 9285.18359375, 77.36406707763672)},
    {"永恒岛", CFrame.new(149.34817504882812, 13680.037109375, 73.3861312866211)},
    {"沙暴岛", CFrame.new(133.37144470214844, 17686.328125, 72.00334167480469)},
    {"雷暴岛", CFrame.new(143.19349670410156, 24070.021484375, 78.05432891845703)},
    {"远古炼狱岛", CFrame.new(141.27163696289062, 28256.294921875, 69.3790283203125)},
    {"午夜暗影岛", CFrame.new(132.74267578125, 33206.98046875, 57.49557495117875)},
    {"神秘灵魂岛", CFrame.new(137.76148986816406, 39317.5703125, 61.06639862060547)},
    {"冬季奇迹岛", CFrame.new(137.2720184326172, 46010.5546875, 55.941951751708984)},
    {"黄金大师岛", CFrame.new(128.32339477539062, 52607.765625, 56.69411849975586)},
    {"龙传奇岛", CFrame.new(146.35226440429688, 59594.6796875, 77.53300476074219)}
}

for _, island in ipairs(basicIslands) do
    NinjaTab:Button({
        Title = "传送到" .. island[1],
        Callback = function()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            humanoidRootPart.CFrame = island[2]
            Window:Notify({
                Title = "传送成功",
                Desc = "已传送到" .. island[1],
                Time = 2
            })
        end
    })
end

local advancedIslands = {
    {"赛博传奇岛", CFrame.new(137.3321075439453, 66669.1640625, 72.21722412109375)},
    {"天岚超能岛", CFrame.new(135.48077392578125, 70271.15625, 57.02311325073242)},
    {"混沌传奇岛", CFrame.new(148.58590698242188, 74442.8515625, 69.3177719116211)},
    {"灵魂融合岛", CFrame.new(136.9700927734375, 79746.984375, 58.54051971435547)},
    {"黑暗元素岛", CFrame.new(141.697265625, 83198.984375, 72.73107147216797)},
    {"内心和平岛", CFrame.new(135.3157501220703, 87051.0625, 66.78429412841797)},
    {"炽烈涡流岛", CFrame.new(135.08216857910156, 91246.0703125, 69.56692504882812)},
    {"35倍金币区域", CFrame.new(86.2938232421875, 91245.765625, 120.54232788085938)},
    {"死亡宠物", CFrame.new(4593.21337890625, 130.87181091308594, 1430.2239990234375)}
}

for _, island in ipairs(advancedIslands) do
    NinjaTab:Button({
        Title = "传送到" .. island[1],
        Callback = function()
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
            humanoidRootPart.CFrame = island[2]
            Window:Notify({
                Title = "传送成功",
                Desc = "已传送到" .. island[1],
                Time = 2
            })
        end
    })
end

local PowerTab = Window:Tab({Title = "力量传奇", Icon = "zap"})

local CodeBlock = PowerTab:Code({
Title = "提示!!!",
Code = "传送功能请勿在其他服务器执行\n该服务器功能暂未补全"
})

task.delay(5, function()
    CodeBlock:SetCode("传送功能请勿在其他服务器执行\n该服务器功能暂未补全")
end)

PowerTab:Toggle({
    Title = "自动比赛开关",
    Default = false,
    Callback = function(AR)
        _G.autoBrawl = AR
        while _G.autoBrawl do
            wait(2)
            game:GetService("ReplicatedStorage").Events.brawlEvent:FireServer("joinBrawl")
        end
    end
})

PowerTab:Toggle({
    Title = "自动举哑铃",
    Default = false,
    Callback = function(ATYL)
        _G.autoWeight = ATYL
        if ATYL then
            local part = Instance.new("Part", workspace)
            part.Size = Vector3.new(500, 20, 530.1)
            part.Position = Vector3.new(0, 100000, 133.15)
            part.CanCollide = true
            part.Anchored = true
            part.Transparency = 1
            _G.weightPart = part
        else
            if _G.weightPart then
                _G.weightPart:Destroy()
                _G.weightPart = nil
            end
        end
        
        while _G.autoWeight do
            wait()
            if _G.weightPart then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = _G.weightPart.CFrame + Vector3.new(0, 50, 0)
                for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.ClassName == "Tool" and v.Name == "Weight" then
                        v.Parent = game.Players.LocalPlayer.Character
                    end
                end
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            end
        end
    end
})

PowerTab:Toggle({
    Title = "自动俯卧撑",
    Default = false,
    Callback = function(ATFWC)
        _G.autoPushups = ATFWC
        if ATFWC then
            local part = Instance.new("Part", workspace)
            part.Size = Vector3.new(500, 20, 530.1)
            part.Position = Vector3.new(0, 100000, 133.15)
            part.CanCollide = true
            part.Anchored = true
            part.Transparency = 1
            _G.pushupsPart = part
        else
            if _G.pushupsPart then
                _G.pushupsPart:Destroy()
                _G.pushupsPart = nil
            end
        end
        
        while _G.autoPushups do
            wait()
            if _G.pushupsPart then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = _G.pushupsPart.CFrame + Vector3.new(0, 50, 0)
                for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.ClassName == "Tool" and v.Name == "Pushups" then
                        v.Parent = game.Players.LocalPlayer.Character
                    end
                end
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            end
        end
    end
})

PowerTab:Toggle({
    Title = "自动仰卧起坐",
    Default = false,
    Callback = function(ATYWQZ)
        _G.autoSitups = ATYWQZ
        if ATYWQZ then
            local part = Instance.new("Part", workspace)
            part.Size = Vector3.new(500, 20, 530.1)
            part.Position = Vector3.new(0, 100000, 133.15)
            part.CanCollide = true
            part.Anchored = true
            part.Transparency = 1
            _G.situpsPart = part
        else
            if _G.situpsPart then
                _G.situpsPart:Destroy()
                _G.situpsPart = nil
            end
        end
        
        while _G.autoSitups do
            wait()
            if _G.situpsPart then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = _G.situpsPart.CFrame + Vector3.new(0, 50, 0)
                for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.ClassName == "Tool" and v.Name == "Situps" then
                        v.Parent = game.Players.LocalPlayer.Character
                    end
                end
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            end
        end
    end
})

PowerTab:Toggle({
    Title = "自动倒立身体",
    Default = false,
    Callback = function(ATDL)
        _G.autoHandstands = ATDL
        if ATDL then
            local part = Instance.new("Part", workspace)
            part.Size = Vector3.new(500, 20, 530.1)
            part.Position = Vector3.new(0, 100000, 133.15)
            part.CanCollide = true
            part.Anchored = true
            part.Transparency = 1
            _G.handstandsPart = part
        else
            if _G.handstandsPart then
                _G.handstandsPart:Destroy()
                _G.handstandsPart = nil
            end
            -- 重置角色位置到安全位置
            local player = game.Players.LocalPlayer
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
            end
        end
        
        while _G.autoHandstands do
            wait()
            if _G.handstandsPart then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = _G.handstandsPart.CFrame + Vector3.new(0, 50, 0)
                for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.ClassName == "Tool" and v.Name == "Handstands" then
                        v.Parent = game.Players.LocalPlayer.Character
                    end
                end
                game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
            end
        end
    end
})

PowerTab:Toggle({
    Title = "自动锻炼",
    Default = false,
    Callback = function(ATAAA)
        _G.autoTrain = ATAAA
        if ATAAA then
            local part = Instance.new("Part", workspace)
            part.Size = Vector3.new(500, 20, 530.1)
            part.Position = Vector3.new(0, 100000, 133.15)
            part.CanCollide = true
            part.Anchored = true
            part.Transparency = 1
            _G.trainPart = part
        else
            if _G.trainPart then
                _G.trainPart:Destroy()
                _G.trainPart = nil
            end
        end
        
        while _G.autoTrain do
            wait()
            if _G.trainPart then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = _G.trainPart.CFrame + Vector3.new(0, 50, 0)
                for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v.ClassName == "Tool" and (v.Name == "Handstands" or v.Name == "Situps" or v.Name == "Pushups" or v.Name == "Weight") then
                        if v:FindFirstChildOfClass("NumberValue") then
                            v:FindFirstChildOfClass("NumberValue").Value = 0
                        end
                        repeat wait() until game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                        game.Players.LocalPlayer.Character:WaitForChild("Humanoid"):EquipTool(v)
                        game:GetService("Players").LocalPlayer.muscleEvent:FireServer("rep")
                    end
                end
            end
        end
    end
})

PowerTab:Toggle({
    Title = "自动重生",
    Default = false,
    Callback = function(ATRE)
        _G.autoRebirth = ATRE
        while _G.autoRebirth do
            wait()
            game:GetService("ReplicatedStorage").Events.rebirthRemote:InvokeServer("rebirthRequest")
        end
    end
})

PowerTab:Section({Title = "传送"})

PowerTab:Toggle({
    Title = "X-安全地方",
    Desc = "切换安全位置",
    Default = false,
    Callback = function(Place)
        if Place then
            getgenv().place = true
            while getgenv().place do
                wait()
                game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = 
                CFrame.new(-51.6716728, 32.2157211, 1290.41211, 0.9945544, 1.23613528e-08, 
                0.104218982, -7.58742402e-09, 1, 4.62031657e-08, 0.104218982, 
                4.51608102e-08, 0.9945544)
            end
        else
            getgenv().place = false
            wait()
            game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame = 
            CFrame.new(-34.1635208, 3.67689133, 219.640869, 0.599920511, 
            2.24152163e-09, 0.800059617, 4.46125981e-09, 1, -5.43559087e-10, 
            0.800059617, 3.89536625e-09, 0.599920511)
        end
    end
})

PowerTab:Button({
    Title = "传送到出生点",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7, 3, 108)
        Window:Notify({
            Title = "传送成功",
            Desc = "已传送到出生点",
            Time = 2
        })
    end
})

PowerTab:Button({
    Title = "传送到冰霜健身房",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2543, 13, -410)
        Window:Notify({
            Title = "传送成功",
            Desc = "已传送到冰霜健身房",
            Time = 2
        })
    end
})

PowerTab:Button({
    Title = "传送到神话健身房",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2177, 13, 1070)
        Window:Notify({
            Title = "传送成功",
            Desc = "已传送到神话健身房",
            Time = 2
        })
    end
})

PowerTab:Button({
    Title = "传送到永恒健身房",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-6686, 13, -1284)
        Window:Notify({
            Title = "传送成功",
            Desc = "已传送到永恒健身房",
            Time = 2
        })
    end
})

PowerTab:Button({
    Title = "传送到传说健身房",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4676, 997, -3915)
        Window:Notify({
            Title = "传送成功",
            Desc = "已传送到传说健身房",
            Time = 2
        })
    end
})

PowerTab:Button({
    Title = "传送到肌肉之王健身房",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-8554, 22, -5642)
        Window:Notify({
            Title = "传送成功",
            Desc = "已传送到肌肉之王健身房",
            Time = 2
        })
    end
})

PowerTab:Button({
    Title = "传送到安全岛",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-39, 10, 1838)
        Window:Notify({
            Title = "传送成功",
            Desc = "已传送到安全岛",
            Time = 2
        })
    end
})

PowerTab:Button({
    Title = "传送到幸运抽奖区域",
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2606, -2, 5753)
        Window:Notify({
            Title = "传送成功",
            Desc = "已传送到幸运抽奖区域",
            Time = 2
        })
    end
})

Window:Notify({
    Title = "郝蕾Hub",
    Desc = "感谢您的游玩",
    Time = 5
})