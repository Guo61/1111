local function setupAntiCheatBypass()
    if setidentity then
        for i = 1, 10 do
            spawn(function()
                setidentity(2)
            end)
        end
    end

    if hookfunction then
        local originalHook = hookfunction
        hookfunction = function(func, newfunc)
            local success = pcall(originalHook, func, newfunc)
            return func
        end
    end

    if debug and debug.getinfo then
        local originalGetInfo = debug.getinfo
        debug.getinfo = function(func, what)
            local info = originalGetInfo(func, what)
            if info and info.source then
                if string.find(info.source, "Ninja") or string.find(info.source, "注入") then
                    info.source = "=[C]"
                end
            end
            return info
        end
    end

    local oldNamecall
    if metatable and getmetatable(game) then
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            if method == "FireServer" then
                local remoteName = tostring(self)
                if string.find(remoteName:lower(), "anticheat") or 
                   string.find(remoteName:lower(), "report") or
                   string.find(remoteName:lower(), "security") then
                    return nil
                end
            end
            
            if method == "Kick" and self == game.Players.LocalPlayer then
                return nil
            end

            return oldNamecall(self, ...)
        end)
    end

    local protectedFunctions = {"writefile", "readfile", "loadstring", "getconnections", "getgc", "getreg"}
    for _, funcName in ipairs(protectedFunctions) do
        if _G[funcName] then
            local originalFunc = _G[funcName]
            _G[funcName] = function(...)
                local success, result = pcall(originalFunc, ...)
                if success then
                    return result
                end
                return nil
            end
        end
    end

    if getfenv then
        local originalGetFenv = getfenv
        getfenv = function(level)
            if level and type(level) == "number" and level > 0 then
                return originalGetFenv(level)
            end
            local env = {}
            local mt = {
                __index = function(t, k)
                    if k == "script" then return nil end
                    return _G[k]
                end,
                __newindex = function(t, k, v)
                    rawset(t, k, v)
                end
            }
            setmetatable(env, mt)
            return env
        end
    end

    if getgenv then
        getgenv().INJECTED = nil
        getgenv().CHEATING = nil
        getgenv().EXPLOIT = nil
    end

    return true
end

local function setupRemoteProtection()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    
    local function sanitizeRemote(remote)
        if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
            local oldFire = remote.FireServer
            remote.FireServer = function(self, ...)
                local args = {...}
                local shouldBlock = false
                
                for _, arg in ipairs(args) do
                    if type(arg) == "string" then
                        if string.find(arg:lower(), "inject") or
                           string.find(arg:lower(), "cheat") or
                           string.find(arg:lower(), "exploit") then
                            shouldBlock = true
                            break
                        end
                    end
                end
                
                if not shouldBlock then
                    return oldFire(self, ...)
                end
            end
        end
    end

    for _, obj in pairs(ReplicatedStorage:GetDescendants()) do
        sanitizeRemote(obj)
    end

    ReplicatedStorage.DescendantAdded:Connect(sanitizeRemote)
end

local function debugAntiCheatFailure()
    local function testFunction(funcName)
        local exists = type(_G[funcName]) == "function"
        return exists
    end
    
    local criticalFunctions = {
        "setidentity", "hookfunction", "hookmetamethod", 
        "getnamecallmethod", "getgenv", "getreg"
    }
    
    local availableFunctions = {}
    for _, func in ipairs(criticalFunctions) do
        if testFunction(func) then
            table.insert(availableFunctions, func)
        end
    end
    
    return availableFunctions
end

local function createFallbackBypass()
    local fallbackSuccess = true
    
    if getgenv then
        getgenv().SCRIPT_LOADED = true
        getgenv().DEBUG_MODE = true
    end
    
    if setidentity then
        local success = pcall(function()
            setidentity(2)
        end)
        fallbackSuccess = fallbackSuccess and success
    end
    
    if getrenv then
        local renv = getrenv()
        if renv and type(renv) == "table" then
            renv.INJECTED = nil
            renv.CHEATING = nil
        end
    end
    
    local function safeHookEvent(eventName, callback)
        local success, result = pcall(function()
            local event = game:GetService(eventName)
            if event then
                event:Connect(callback)
                return true
            end
        end)
        return success
    end
    
    safeHookEvent("Players", function(player)
        if player == game.Players.LocalPlayer then
            player.Kick:Connect(function()
                return nil
            end)
        end
    end)
    
    return fallbackSuccess
end

local function enhancedAntiCheatBypass()
    local debugInfo = debugAntiCheatFailure()
    if #debugInfo == 0 then
        return createFallbackBypass()
    end
    
    local bypassModules = {}
    
    if hookmetamethod then
        local success = pcall(function()
            local oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                if method == "Kick" and self == game.Players.LocalPlayer then
                    return nil
                end
                return oldNamecall(self, ...)
            end)
            table.insert(bypassModules, "防踢出")
        end)
    end
    
    if setidentity then
        local success = pcall(function()
            spawn(function()
                setidentity(2)
            end)
        end)
        table.insert(bypassModules, "身份伪装")
    end
    
    if getgenv then
        pcall(function()
            local env = getgenv()
            env.__ANTICHEAT_LOADED = true
            env.__DEBUG_MODE = true
        end)
        table.insert(bypassModules, "环境清理")
    end
    
    collectgarbage("collect")
    
    return #bypassModules > 0
end

local function setupRobustAntiCheat()
    local maxRetries = 3
    local retryDelay = 1
    
    for attempt = 1, maxRetries do
        local success = enhancedAntiCheatBypass()
        
        if success then
            local remoteSuccess = pcall(setupRemoteProtection)
            local mainSuccess = pcall(setupAntiCheatBypass)
            
            if mainSuccess or remoteSuccess then
                return true
            end
        end
        
        if attempt < maxRetries then
            wait(retryDelay)
            retryDelay = retryDelay * 2
        end
    end
    
    return createFallbackBypass()
end

local function cleanEnvironment()
    if getgenv then
        for k, v in pairs(getgenv()) do
            if type(k) == "string" and (string.find(k:lower(), "inject") or 
               string.find(k:lower(), "cheat") or 
               string.find(k:lower(), "exploit")) then
                getgenv()[k] = nil
            end
        end
    end
    
    if getreg then
        for _, v in pairs(getreg()) do
            if type(v) == "table" then
                for k2, v2 in pairs(v) do
                    if type(k2) == "string" and (string.find(k2:lower(), "inject") or 
                       string.find(k2:lower(), "cheat")) then
                        v[k2] = nil
                    end
                end
            end
        end
    end
    
    collectgarbage()
end

local bypassSuccess = setupRobustAntiCheat()

if bypassSuccess then
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "郝蕾脚本",
        Text = "反作弊绕过已激活",
        Duration = 3
    })
else
    game:GetService("StarterGui"):SetCore("SendNotification",{
        Title = "郝蕾脚本",
        Text = "使用基础保护模式",
        Duration = 3
    })
end

game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "郝蕾脚本"; Text ="正在加载脚本做好的脚本有更多的资源"; Duration = 2; })wait(3)
game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "郝蕾脚本"; Text ="付费版,包含了市面上大部分脚本"; Duration = 2; })wait(2)
game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "郝蕾脚本"; Text ="载入成功"; Duration = 3; })

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/OPEN-SOURCE-UI-ROBLOX/refs/heads/main/X2ZU%20UI%20ROBLOX%20OPEN%20SOURCE/DummyUi-leak-by-x2zu/fetching-main/Tools/Framework.luau"))()

local Window = Library:Window({
    Title = "郝蕾脚本 v2.3",
    Desc = "付费版,包含了市面上大部分脚本",
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

local MainTab = Window:Tab({Title = "主页", Icon = "crown"})

MainTab:Section({Title = "账户信息"})
MainTab:Button({
    Title = "显示账户信息", 
    Description = "点击查看详细信息",
    Callback = function()
        Window:Notify({
            Title = "账户信息",
            Desc = "郝蕾脚本\n作者：郝蕾\n师傅江砚辰\n作者qq3131827878\n你的账号:"..player.AccountAge.."世纪\n你的用户名:"..game.Players.LocalPlayer.Character.Name.."\n服务器名称:"..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name,
            Time = 10
        })
    end
})

MainTab:Section({Title = "通用功能"})

MainTab:Button({
    Title = "设备信息",
    Description = "显示当前设备信息",
    Callback = function()
        local function identifyDevice()
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
        
        Window:Notify({
            Title = "设备信息",
            Desc = "当前设备: " .. identifyDevice(),
            Time = 5
        })
    end
})

MainTab:Button({  
    Title = "反挂机",  
    Desc = "不要随意开启!",  
    Description = "从Github加载并执行反挂机",  
    Callback = function()  
        Window:Notify({  
            Title = "郝蕾脚本",  
            Desc = "正在加载反挂机脚本...",  
            Time = 3  
        })  

        local url = "https://raw.githubusercontent.com/Guo61/Cat-/refs/heads/main/%E5%8F%8D%E6%8C%82%E6%9C%BA.lua"

        local success, response = pcall(function()  
            return game:HttpGet(url, true)  
        end)  

        if success and response and #response > 100 then  
            local executeSuccess, executeError = pcall(function()  
                loadstring(response)()  
            end)  

            if executeSuccess then  
                Window:Notify({  
                    Title = "郝蕾脚本",  
                    Desc = "反挂机脚本加载并执行成功!",  
                    Time = 5  
                })  
            else  
                Window:Notify({  
                    Title = "郝蕾脚本",  
                    Desc = "脚本执行错误: " .. tostring(executeError),  
                    Time = 5  
                })  
            end  

        else  
            Window:Notify({  
                Title = "郝蕾脚本",  
                Desc = "反挂机脚本加载失败，请检查网络",  
                Time = 5  
            })  
        end  
    end  
})

MainTab:Button({
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
            Title = "郝蕾脚本",
            Desc = "FPS显示已开启",
            Time = 3
        })
    end
})

MainTab:Toggle({
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
            if not character:FindFirstChild("RangeHighlight") then
                local clone = highlight:Clone()
                clone.Adornee = character
                clone.Name = "RangeHighlight"
                clone.Parent = character
            end
        end

        local function removeHighlight(character)
            local h = character:FindFirstChild("RangeHighlight")
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

MainTab:Button({
    Title = "半隐身",
    Desc = "悬浮窗关不掉",
    Description = "从GitHub加载并执行隐身脚本",
    Callback = function()
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invisible-35376"))()
    end
})

MainTab:Button({
    Title = "玩家入退提示",
    Description = "从GitHub加载并执行提示脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/boyscp/scriscriptsc/main/bbn.lua"))()
    end
})

MainTab:Button({
    Title = "甩飞",
    Description = "从GitHub加载并执行甩飞脚本",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
    end
})

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

MainTab:Toggle({
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

local espEnabled = false
local espConnections = {}
local espHighlights = {}
local espNameTags = {}

local function createESP(player)
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = char:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "ESP"
    highlight.Adornee = char
    highlight.FillColor = Color3.new(1, 0, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.Parent = char
    espHighlights[player] = highlight

    local nameTag = Instance.new("BillboardGui")
    nameTag.Name = "NameTag"
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

MainTab:Toggle({
    Title = "人物透视 (ESP)",
    Desc = "显示其他玩家的透视框和名字",
    Default = false,
    Callback = toggleESP
})

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

playerDropdown = MainTab:Dropdown({
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

MainTab:Button({
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

MainTab:Button({
    Title = "刷新玩家列表",
    Desc = "手动刷新可传送的玩家列表",
    Callback = function()
        local newPlayers = getPlayerNames()
        Window:Notify({
            Title = "玩家列表",
            Desc = "玩家列表已刷新，当前玩家数: " .. (#newPlayers),
            Time = 3
        })
    end
})

MainTab:Slider({
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
        end
    end
})

MainTab:Slider({
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
        end
    end
})

MainTab:Slider({
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
        end
    end
})

MainTab:Button({
    Title = "飞行",
    Description = "从GitHub加载并执行飞行脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/Cat-/refs/heads/main/%E9%A3%9E%E8%A1%8C%E8%84%9A%E6%9C%AC.lua"))()
    end
})

MainTab:Button({
    Title = "无限跳",
    Desc = "概率关不了",
    Description = "从GitHub加载并执行无限跳脚本",
    Callback = function()
       loadstring(game:HttpGet("https://pastebin.com/raw/V5PQy3y0", true))()
    end
})

MainTab:Button({
    Title = "自瞄",
    Desc = "宙斯自瞄",
    Description = "从GitHub加载并执行自瞄脚本",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/main/Arceus%20Aimbot.lua"))()
    end
})

MainTab:Toggle({
    Title = "子弹追踪",
    Default = false,
    Callback = function(state)
    end
})

MainTab:Toggle({
    Title = "夜视",
    Default = false,
    Callback = function(isEnabled)
        if isEnabled then
            game.Lighting.Ambient = Color3.new(1, 1, 1)
        else
            game.Lighting.Ambient = Color3.new(0, 0, 0)
        end
    end
})

MainTab:Toggle({
    Title = "穿墙",
    Default = false,
    Callback = function(NC)
    end
})

MainTab:Section({Title = "服务器功能"})

MainTab:Button({
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

MainTab:Button({
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

MainTab:Button({
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

MainTab:Button({
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

MainTab:Button({
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

game.Players.LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("HumanoidRootPart", 10)
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        local oldGravity = rootPart:FindFirstChild("PersonalGravity")
        if oldGravity then
            oldGravity:Destroy()
        end
    end
end)

local ScriptsTab = Window:Tab({Title = "脚本合集", Icon = "zap"})
ScriptsTab:Button({Title = "鱼脚本", Callback = function()
    loadstring(game:HelpGet(utf8.char((function() return table.unpack({104,116,116,112,115,58,47,47,115,104,122,46,97,108,47,126,70,105,115,104,83,99,114,105,112,116,78,101,119})end)())))();
end})
ScriptsTab:Button({Title = "皮脚本", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
end})
ScriptsTab:Button({Title = "星河脚本", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AWDX-DYVB/test/main/%E6%B2%B3%E6%B5%81%E6%97%A0%E5%AF%86%E9%92%A5.lua"))()
end})
ScriptsTab:Button({Title = "静心脚本", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/jxdjbx/gggggghjjnbb/main/jdjdd"))()
end})
ScriptsTab:Button({Title = "冷脚本", Callback = function()
    getgenv().Leng="冷脚本QQ群815883059" loadstring(game:HttpGet("https://raw.githubusercontent.com/odhdshhe/lenglenglenglenglenglenglenglenglenglenglengleng-cold-script-LBT-H/refs/heads/main/LENG-cold-script-LBT-H.txt"))()
end})
ScriptsTab:Button({Title = "XK脚本", Callback = function()
    loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\103\121\99\103\99\104\103\121\102\121\116\100\116\116\114\47\115\104\101\110\113\105\110\47\114\101\102\115\47\104\101\97\100\115\47\109\97\105\110\47\72\69\46\108\117\97\34\41\41\40\41")()
end})
ScriptsTab:Button({Title = "也是脚本但不知道名", Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/KwARpDxV",true))()
end})
ScriptsTab:Button({Title = "动感星期五", Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/KwARpDxV",true))()
end})

local UniversalTab = Window:Tab({Title = "通用", Icon = "zap"})
UniversalTab:Button({Title = "甩人", Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
end})
UniversalTab:Button({Title = "替身", Callback = function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/SkrillexMe/SkrillexLoader/main/SkrillexLoadMain')))()
end})
UniversalTab:Button({Title = "爬墙", Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end})
UniversalTab:Button({Title = "汉化阿尔宙斯自瞄", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/sgbs/main/%E4%B8%81%E4%B8%81%20%E6%B1%89%E5%8C%96%E8%87%AA%E7%9E%84.txt"))()
end})
UniversalTab:Button({Title = "工具挂", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Bebo-Mods/BeboScripts/main/StandAwekening.lua"))()
end})
UniversalTab:Button({Title = "甩飞", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/hknvh/main/%E7%94%A9%E9%A3%9E.txt"))()
end})
UniversalTab:Button({Title = "铁拳", Callback = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
end})
UniversalTab:Slider({Title = "设置重力", Min = 196.2, Max = 1000, Default = 196.2, Rounding = 1, Value = 196.2, Callback = function(val) game.Workspace.Gravity = val end})
UniversalTab:Slider({Title = "跳跃高度", Min = 50, Max = 400, Default = 50, Rounding = 0, Value = 50, Callback = function(val) spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.JumpPower = val end end) end})
UniversalTab:Slider({Title = "步行速度", Min = 16, Max = 400, Default = 16, Rounding = 0, Value = 16, Callback = function(val) spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val end end) end})
UniversalTab:Toggle({Title = "夜视", Default = false, Callback = function(Value) if Value then game.Lighting.Ambient = Color3.new(1, 1, 1) else game.Lighting.Ambient = Color3.new(0, 0, 0) end end})

local autoInteract = false
UniversalTab:Toggle({Title = "自动互动", Default = false, Callback = function(state)
    autoInteract = state
    if state then
        while autoInteract do
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    fireproximityprompt(descendant)
                end
            end
            task.wait(0.25)
        end
    end
end})

local DoorsTab = Window:Tab({Title = "doors", Icon = "zap"})
DoorsTab:Button({Title = "最强汉化", Callback = function() loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\54\53\84\119\84\56\106\97"))() end})

local NinjaTab = Window:Tab({Title = "忍者传奇", Icon = "zap"})
NinjaTab:Button({Title = "传送", Callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/UzaUDSPK"))() end})

local PrisonTab = Window:Tab({Title = "越狱", Icon = "zap"})
PrisonTab:Button({Title = "越狱", Callback = function() loadstring(game:GetObjects("rbxassetid://3762448307")[1].Source)() end})

local SpeedTab = Window:Tab({Title = "极速传奇", Icon = "zap"})
SpeedTab:Button({Title = "1", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/TtmScripter/GoodScript/main/LegendOfSpeed(Chinese)"))() end})
SpeedTab:Button({Title = "2", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/TtmScripter/Legend-of-Speed-Auto-/main/GetPet"))() end})

local PressureTab = Window:Tab({Title = "『压力』", Icon = "zap"})
PressureTab:Button({Title = "压力1", Callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/Ej3U4LbA"))() end})
PressureTab:Button({Title = "压力2", Callback = function() loadstring(game:HttpGet(('https://github.com/DocYogurt/Main/raw/main/Scripts/Pressure')))() end})

local DustyTab = Window:Tab({Title = "『尘土飞扬的旅行』", Icon = "zap"})
DustyTab:Button({Title = "尘土飞扬的旅行1", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AbdouGG/dustytripv1/main/beta"))() end})
DustyTab:Button({Title = "尘土飞扬的旅行2", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/artemy133563/Utilities/main/ADustyTrip",true))() end})

local DeathBallTab = Window:Tab({Title = "『死亡球』", Icon = "zap"})
DeathBallTab:Button({Title = "死亡球1", Callback = function() loadstring(game:HttpGet("https://github.com/Hosvile/InfiniX/releases/latest/download/main.lua",true))() end})

local CarDealerTab = Window:Tab({Title = "『汽车经销大亨』", Icon = "zap"})
CarDealerTab:Button({Title = "刷星星", Callback = function() loadstring(game:HttpGet("https://scriptblox.com/raw/LIMITED!-Car-Dealership-Tycoon-Moon-Team-16181"))() end})
CarDealerTab:Button({Title = "汽车经销大亨1", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/IExpIoit/Script/main/Car%20Dealership%20Tycoon.lua"))() end})

local LumberTab = Window:Tab({Title = "『伐木大亨』", Icon = "zap"})
LumberTab:Button({Title = "伐木大亨1", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/UWU/main/LuaWare.lua", true))() end})

local AXTab = Window:Tab({Title = "『AX』", Icon = "zap"})
AXTab:Button({Title = "ax所有功能内有ohio", Callback = function() loadstring(game:HttpGet("https://raw.gitcode.com/Xingtaiduan/Scripts/raw/main/Loader.lua"))() end})

local ChineseTab = Window:Tab({Title = "『郝蕾脚本大全』", Icon = "zap"})
ChineseTab:Button({Title = "99虚空", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/99%E5%A4%9C%E8%99%9A%E7%A9%BA.txt"))() end})
ChineseTab:Button({Title = "死铁轨", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E6%AD%BB%E9%93%81%E8%BD%A8.lua"))() end})
ChineseTab:Button({Title = "墨水游戏", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E6%B1%89%E5%8C%96%E5%A2%A8%E6%B0%B4Ringta.txt"))() end})
ChineseTab:Button({Title = "活了7天", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E4%B8%83%E6%97%A5%E7%94%9F%E6%88%90kkk.txt"))() end})
ChineseTab:Button({Title = "BF", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/bf.txt"))() end})
ChineseTab:Button({Title = "偷走脑红", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/偷走脑红"))() end})
ChineseTab:Button({Title = "战争大亨", Callback = function() loadstring(game:HttpGet("https://pastefy.app/hDfjNmLP/raw"))() end})
ChineseTab:Button({Title = "DOORs", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/VelocityX.lua"))() end})
ChineseTab:Button({Title = "跳跃对决", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E8%B7%B3%E8%B7%83%E5%AF%B9%E5%86%B3.txt"))() end})
ChineseTab:Button({Title = "刀刃球", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/ArgonHubX.lua"))() end})
ChineseTab:Button({Title = "造船寻宝", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/zcxb.lua"))() end})
ChineseTab:Button({Title = "自然灾害", Callback = function() loadstring(game:HttpGet'https://raw.githubusercontent.com/RunDTM/ZeeroxHub/main/Loader.lua')() end})
ChineseTab:Button({Title = "最强战场隐身", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/VexonHub%E6%B1%89%E5%8C%96.txt"))() end})
ChineseTab:Button({Title = "最强战场无视平a", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/10tempest01/tempest-hub/refs/heads/main/Launcher.lua"))() end})
ChineseTab:Button({Title = "最强战场火车头", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/ATrainSounds/refs/heads/main/ATrain.lua"))() end})

local csTab = Window:Tab({Title = "『无敌少侠飞行R15』", Icon = "zap"})
csTab:Button({Title = "飞行1", Callback = function() loadstring(game:HttpGet("https://gist.githubusercontent.com/JungleScripts/8dc95c7ce10e86d353d606334a77de88/raw/08f3e2967701463da36f2fc28e9943e63799dd3f/gistfile1.txt"))() end})
csTab:Button({Title = "飞行2", Callback = function() loadstring(game:HttpGet("https://gist.githubusercontent.com/JungleScripts/775c6366d91d39fe2633c5805a1d0c23/raw/c8de949402393510a27bcf4482c957b6c3bed2c2/gistfile1.txt"))() end})
csTab:Button({Title = "飞行不能停下来", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))() end})

local lolTab = Window:Tab({Title = "『吃掉世界』", Icon = "zap"})
lolTab:Button({Title = "ccat", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/LED/refs/heads/main/%E5%90%83%E7%95%8C.lua"))() end})

local fytTab = Window:Tab({Title = "『终极战场』", Icon = "zap"})
fytTab:Button({Title = "Xi PRO", Callback = function() loadstring(game:HttpGet("http://raw.githubusercontent.com/123fa98/Xi_Pro/refs/heads/main/免费/终极战场.lua"))() end})

local nTab = Window:Tab({Title = "『偷走脑红朝霞』", Icon = "zap"})
nTab:Button({Title = "偷走脑红地卡", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/djbx687/114514888/refs/heads/main/帝卡脑红汉化.txt"))() end})
nTab:Button({Title = "朝霞免费私服", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/yoursvexyyy/VEX-OP/refs/heads/main/free%20server%20finder"))() end})
nTab:Button({Title = "偷走脑红朝霞", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/342423114514/342423/refs/heads/main/9178.lua"))() end})

local bTab = Window:Tab({Title = "『恐鬼症』", Icon = "zap"})
bTab:Button({Title = "恐鬼症", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/1111/refs/heads/main/%E6%81%90%E9%AC%BC%E7%97%87.lua"))() end})

local gTab = Window:Tab({Title = "『海战』", Icon = "zap"})
gTab:Button({Title = "海战", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/海战.lua"))() end})

local hTab = Window:Tab({Title = "『俄亥俄州』", Icon = "zap"})
hTab:Button({Title = "俄亥俄州", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/俄亥俄州.lua"))() end})

local qwTab = Window:Tab({Title = "『监狱人生』", Icon = "zap"})
qwTab:Button({Title = "监狱人生", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/监狱人生.lua"))() end})

local bnTab = Window:Tab({Title = "『奶奶』", Icon = "zap"})
bnTab:Button({Title = "奶奶", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/奶奶.lua"))() end})

local buTab = Window:Tab({Title = "『彩虹朋友』", Icon = "zap"})
buTab:Button({Title = "彩虹朋友", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/彩虹朋友.lua"))() end})

local byuTab = Window:Tab({Title = "『破坏者谜团』", Icon = "zap"})
byuTab:Button({Title = "破坏者谜团", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/破坏者谜团2.lua"))() end})

local bytuTab = Window:Tab({Title = "『死亡之夜』", Icon = "zap"})
bytuTab:Button({Title = "死亡之夜", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/-/refs/heads/main/%E6%AD%BB%E4%BA%A1%E4%B9%8B%E6%AD%BB(%E5%A4%9A%E5%96%9D%E6%B0%B4%E6%B1%89%E5%8C%96).lua"))() end})

local bkTab = Window:Tab({Title = "『巴掌大战』", Icon = "zap"})
bkTab:Button({Title = "巴掌大战", Callback = function() loadstring(game:HttpGet(("https://raw.githubusercontent.com/Dusty1234567890/Guide/main/Guide")))() end})

local bmuTab = Window:Tab({Title = "『修仙模拟器』", Icon = "zap"})
bmuTab:Button({Title = "修仙模拟器", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/1111/refs/heads/main/%E4%BF%AE%E4%BB%99%E6%A8%A1%E6%8B%9F%E5%99%A8%E8%84%9A%E6%9C%AC%E5%BC%80%E6%BA%90.txt"))() end})

local bmruTab = Window:Tab({Title = "『格蕾丝』", Icon = "zap"})
bmruTab:Button({Title = "格蕾丝", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoXuAnZang/XKscript/refs/heads/main/GraceXJ.lua"))() end})

local bfuTab = Window:Tab({Title = "『一路向西』", Icon = "zap"})
bfuTab:Button({Title = "一路向西", Callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/0SKKXLB7"))() end})

local bnuTab = Window:Tab({Title = "『FPE』", Icon = "zap"})
bnuTab:Button({Title = "FPE", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/FPE-S.lua"))() end})

local biuTab = Window:Tab({Title = "『种植花园』", Icon = "zap"})
biuTab:Button({Title = "走马观灯", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E8%8A%B1%E5%9B%AD.lua"))() end})

local bcuTab = Window:Tab({Title = "『在超市生活一周』", Icon = "zap"})
bcuTab:Button({Title = "缝合出品", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E5%9C%A8%E8%B6%85%E5%B8%82%E7%94%9F%E6%B4%BB%E4%B8%80%E5%91%A8.lua"))() end})

local bitTab = Window:Tab({Title = "『住宅大屠杀』", Icon = "zap"})
bitTab:Button({Title = "缝合出品", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E4%BD%8F%E5%AE%85%E5%A4%A7%E5%B1%A0%E6%9D%80.lua"))() end})

local bruTab = Window:Tab({Title = "『矿井』", Icon = "zap"})
bruTab:Button({Title = "缝合出品", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E7%9F%BF%E4%BA%95.lua"))() end})

local miuTab = Window:Tab({Title = "『河北唐县』", Icon = "zap"})
miuTab:Button({Title = "缝合出品", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/a%20%E6%B2%B3%E5%8C%97%E5%94%90%E5%8E%BF.lua"))() end})

local tuTab = Window:Tab({Title = "『战斗勇士』", Icon = "zap"})
tuTab:Button({Title = "自制", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E6%88%98%E6%96%97%E5%8B%87%E5%A3%AB.lua"))() end})

local bsTab = Window:Tab({Title = "『躲避』", Icon = "zap"})
bsTab:Button({Title = "躲避", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E8%BA%B2%E9%81%BF.lua"))() end})

local byTab = Window:Tab({Title = "『植物大战机器人』", Icon = "zap"})
byTab:Button({Title = "朝霞汉化", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/7878%20(1)"))() end})

local kyTab = Window:Tab({Title = "『墨水游戏』", Icon = "zap"})
kyTab:Button({Title = "墨水游戏", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/墨水游戏.lua"))() end})

local krTab = Window:Tab({Title = "『动物捉迷藏』", Icon = "zap"})
krTab:Button({Title = "动物捉迷藏", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E5%8A%A8%E7%89%A9%E6%8D%89%E8%BF%B7%E8%97%8F.lua"))() end})

local kiTab = Window:Tab({Title = "『黑暗欺骗』", Icon = "zap"})
kiTab:Button({Title = "黑暗欺骗", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/Hunted.lua"))() end})

local kwTab = Window:Tab({Title = "『元素大亨』", Icon = "zap"})
kwTab:Button({Title = "元素大亨", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E5%85%83%E7%B4%A0%E5%8A%9B%E9%87%8F%E5%A4%A7%E4%BA%A8.lua"))() end})

local kuTab = Window:Tab({Title = "『自然灾害黑洞』", Icon = "zap"})
kuTab:Button({Title = "黑洞", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/V6.txt"))() end})

local mneTab = Window:Tab({Title = "『建造一架飞机』", Icon = "zap"})
mneTab:Button({Title = "刷钱", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E5%BB%BA%E9%80%A0%E4%B8%80%E6%9E%B6%E9%A3%9E%E6%9C%BA"))()end})

local AntiCheatTab = Window:Tab({Title = "反检测", Icon = "zap"})

AntiCheatTab:Button({Title = "刷新反检测系统", Callback = function()
    local success = setupRobustAntiCheat()
    
    if success then
        Window:Notify({
            Title = "反检测系统",
            Desc = "反检测系统已全面激活",
            Time = 5
        })
    else
        Window:Notify({
            Title = "反检测系统",
            Desc = "使用基础保护模式",
            Time = 5
        })
    end
end})

AntiCheatTab:Toggle({Title = "隐藏注入环境", Default = false, Callback = function(state)
    if state then
        if setidentity then
            for i = 1, 5 do
                spawn(function()
                    setidentity(2)
                end)
            end
        end
        Window:Notify({
            Title = "隐藏注入环境",
            Desc = "环境伪装已启用",
            Time = 3
        })
    else
        if setidentity then
            setidentity(8)
        end
    end
end})

AntiCheatTab:Button({Title = "深度清理环境", Callback = function()
    cleanEnvironment()
    Window:Notify({
        Title = "环境清理",
        Desc = "深度环境清理完成",
        Time = 3
    })
end})

AntiCheatTab:Toggle({Title = "防踢出保护", Default = true, Callback = function(state)
    if state then
        if not getgenv().AntiKickHook then
            getgenv().AntiKickHook = true
            local oldNamecall
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                if method == "Kick" and self == game.Players.LocalPlayer then
                    return nil
                end
                return oldNamecall(self, ...)
            end)
        end
        Window:Notify({
            Title = "防踢出保护",
            Desc = "踢出保护已启用",
            Time = 3
        })
    else
        getgenv().AntiKickHook = false
    end
end})

AntiCheatTab:Toggle({Title = "拦截反作弊报告", Default = true, Callback = function(state)
    if state then
        if not getgenv().BlockReports then
            getgenv().BlockReports = true
            local oldNamecall
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                if method == "FireServer" then
                    local remoteName = tostring(self)
                    if string.find(remoteName:lower(), "anticheat") or 
                       string.find(remoteName:lower(), "report") then
                        return nil
                    end
                end
                return oldNamecall(self, ...)
            end)
        end
        Window:Notify({
            Title = "报告拦截",
            Desc = "反作弊报告拦截已启用",
            Time = 3
        })
    else
        getgenv().BlockReports = false
    end
end})

AntiCheatTab:Button({Title = "诊断系统状态", Callback = function()
    local availableFuncs = debugAntiCheatFailure()
    local status = {}
    
    if getgenv().AntiKickHook then
        table.insert(status, "✓ 防踢出保护")
    else
        table.insert(status, "✗ 防踢出保护")
    end
    
    if getgenv().BlockReports then
        table.insert(status, "✓ 报告拦截")
    else
        table.insert(status, "✗ 报告拦截")
    end
    
    if #availableFuncs > 3 then
        table.insert(status, "✓ 高级功能")
    else
        table.insert(status, "⚠ 基础功能")
    end
    
    Window:Notify({
        Title = "系统状态",
        Desc = table.concat(status, "\n") .. "\n可用函数: " .. #availableFuncs,
        Time = 5
    })
end})

AntiCheatTab:Button({Title = "安全模式", Callback = function()
    Window:Notify({
        Title = "安全模式",
        Desc = "启动最小化安全保护...",
        Time = 3
    })
    
    local success = createFallbackBypass()
    
    if success then
        Window:Notify({
            Title = "安全模式",
            Desc = "基础保护已激活",
            Time = 5
        })
    else
        Window:Notify({
            Title = "安全模式",
            Desc = "保护启动失败",
            Time = 5
        })
    end
end})