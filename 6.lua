local LBLG = Instance.new("ScreenGui")
local LBL = Instance.new("TextLabel")
local player = game.Players.LocalPlayer

LBLG.Name = "LBLG"
LBLG.Parent = game.CoreGui
LBLG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LBLG.Enabled = true
LBL.Name = "LBL"
LBL.Parent = LBLG
LBL.BackgroundColor3 = Color3.new(1, 1, 1)
LBL.BackgroundTransparency = 1
LBL.BorderColor3 = Color3.new(0, 0, 0)
LBL.Position = UDim2.new(0.75,0,0.010,0)
LBL.Size = UDim2.new(0, 133, 0, 30)
LBL.Font = Enum.Font.GothamSemibold
LBL.Text = "TextLabel"
LBL.TextColor3 = Color3.new(1, 1, 1)
LBL.TextScaled = true
LBL.TextSize = 14
LBL.TextWrapped = true
LBL.Visible = true

local FpsLabel = LBL
local Heartbeat = game:GetService("RunService").Heartbeat
local LastIteration, Start
local FrameUpdateTable = { }

game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "郝蕾脚本"; Text ="正在加载脚本做好的脚本有更多的资源"; Duration = 2; })wait(3)

game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "郝蕾脚本"; Text ="付费版,包含了市面上大部分脚本"; Duration = 2; })wait(2)

game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "郝蕾脚本"; Text ="载入成功"; Duration = 3; })

local function HeartbeatUpdate()
	LastIteration = tick()
	for Index = #FrameUpdateTable, 1, -1 do
		FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
	end
	FrameUpdateTable[1] = LastIteration
	local CurrentFPS = (tick() - Start >= 1 and #FrameUpdateTable) or (#FrameUpdateTable / (tick() - Start))
	CurrentFPS = CurrentFPS - CurrentFPS % 1
	FpsLabel.Text = ("现在时间:"..os.date("%H").."时"..os.date("%M").."分"..os.date("%S"))
end
Start = tick()
Heartbeat:Connect(HeartbeatUpdate)

local library = loadstring(game:HttpGet(('https://github.com/DevSloPo/Auto/raw/main/Ware-obfuscated.lua')))()
local window = library:new("郝蕾脚本 v2.3")

local InfoTab = window:Tab("信息", "7733774602")
local InfoSection1 = InfoTab:section("作者信息", true)
InfoSection1:Label("郝蕾脚本")
InfoSection1:Label("作者：郝蕾")
InfoSection1:Label("师傅江砚辰")
InfoSection1:Label("作者qq3131827878")

local InfoSection2 = InfoTab:section("你的信息", true)
InfoSection2:Label("账户信息")
InfoSection2:Label("你的账号:"..player.AccountAge.."世纪")
InfoSection2:Label("你的用户名:"..game.Players.LocalPlayer.Character.Name)
InfoSection2:Label("服务器名称:"..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)

local ScriptsTab = window:Tab("脚本合集", "7733774602")
local ScriptsSection = ScriptsTab:section("脚本合集", true)

ScriptsSection:Button("鱼脚本", function()
    loadstring(game:HelpGet(utf8.char((function() return table.unpack({104,116,116,112,115,58,47,47,115,104,122,46,97,108,47,126,70,105,115,104,83,99,114,105,112,116,78,101,119})end)())))();
end)

ScriptsSection:Button("皮脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
end)

ScriptsSection:Button("星河脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AWDX-DYVB/test/main/%E6%B2%B3%E6%B5%81%E6%97%A0%E5%AF%86%E9%92%A5.lua"))()
end)

ScriptsSection:Button("静心脚本", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/jxdjbx/gggggghjjnbb/main/jdjdd"))()
end)

ScriptsSection:Button("冷脚本", function()
    getgenv().Leng="冷脚本QQ群815883059" loadstring(game:HttpGet("https://raw.githubusercontent.com/odhdshhe/lenglenglenglenglenglenglenglenglenglenglengleng-cold-script-LBT-H/refs/heads/main/LENG-cold-script-LBT-H.txt"))()
end)

ScriptsSection:Button("XK脚本", function()
    loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\103\121\99\103\99\104\103\121\102\121\116\100\116\116\114\47\115\104\101\110\113\105\110\47\114\101\102\115\47\104\101\97\100\115\47\109\97\105\110\47\72\69\46\108\117\97\34\41\41\40\41")()
end)

ScriptsSection:Button("也是脚本但不知道名", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/KwARpDxV",true))()
end)

ScriptsSection:Button("动感星期五", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/KwARpDxV",true))()
end)

local UniversalTab = window:Tab("通用", "7733774602")
local UniversalSection = UniversalTab:section("通用", true)

UniversalSection:Button("甩人", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
end)

UniversalSection:Button("替身", function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/SkrillexMe/SkrillexLoader/main/SkrillexLoadMain')))()
end)

UniversalSection:Button("爬墙", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end)

UniversalSection:Button("汉化阿尔宙斯自瞄", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/sgbs/main/%E4%B8%81%E4%B8%81%20%E6%B1%89%E5%8C%96%E8%87%AA%E7%9E%84.txt"))()
end)

UniversalSection:Button("工具挂", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Bebo-Mods/BeboScripts/main/StandAwekening.lua"))()
end)

UniversalSection:Button("甩飞", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/hknvh/main/%E7%94%A9%E9%A3%9E.txt"))()
end)

UniversalSection:Button("铁拳", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
end)

UniversalSection:Slider("设置重力", "", 196.2, 196.2, 1000, false, function(val)
    game.Workspace.Gravity = val
end)

UniversalSection:Slider("跳跃高度", "", 50, 50, 400, false, function(val)
    spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.JumpPower = val end end)
end)

UniversalSection:Slider("步行速度", "", 16, 16, 400, false, function(val)
    spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val end end)
end)

UniversalSection:Toggle("夜视", "", false, function(Value)
    if Value then
        game.Lighting.Ambient = Color3.new(1, 1, 1)
    else
        game.Lighting.Ambient = Color3.new(0, 0, 0)
    end
end)

UniversalSection:Toggle("自动互动", "", false, function(state)
    if state then
        autoInteract = true
        while autoInteract do
            for _, descendant in pairs(workspace:GetDescendants()) do
                if descendant:IsA("ProximityPrompt") then
                    fireproximityprompt(descendant)
                end
            end
            task.wait(0.25)
        end
    else
        autoInteract = false
    end
end)

local DoorsTab = window:Tab("doors", "7733774602")
local DoorsSection = DoorsTab:section("doors", true)
DoorsSection:Button("最强汉化", function()
    loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\54\53\84\119\84\56\106\97"))()
end)

local NinjaTab = window:Tab("忍者传奇", "7733774602")
local NinjaSection = NinjaTab:section("忍者传奇", true)
NinjaSection:Button("忍者传奇1", function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/Zyb150933/zyb/main/123'))()
end)

NinjaSection:Button("叶脚本", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/5TNsz9mj"))()
end)

NinjaSection:Button("传送", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/UzaUDSPK"))()
end)

local PrisonTab = window:Tab("越狱", "7733774602")
local PrisonSection = PrisonTab:section("越狱", true)
PrisonSection:Button("越狱", function()
    loadstring(game:GetObjects("rbxassetid://3762448307")[1].Source)()
end)

local SpeedTab = window:Tab("极速传奇", "7733774602")
local SpeedSection = SpeedTab:section("极速传奇", true)
SpeedSection:Button("1", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/TtmScripter/GoodScript/main/LegendOfSpeed(Chinese)"))()
end)

SpeedSection:Button("2", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/TtmScripter/Legend-of-Speed-Auto-/main/GetPet"))()
end)

local PressureTab = window:Tab("『压力』", "7733774602")
local PressureSection = PressureTab:section("『压力』", true)
PressureSection:Button("压力1", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/Ej3U4LbA"))()
end)

PressureSection:Button("压力2", function()
    loadstring(game:HttpGet(('https://github.com/DocYogurt/Main/raw/main/Scripts/Pressure')))()
end)

local DustyTab = window:Tab("『尘土飞扬的旅行』", "7733774602")
local DustySection = DustyTab:section("『尘土飞扬的旅行』", true)
DustySection:Button("尘土飞扬的旅行1", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AbdouGG/dustytripv1/main/beta"))()
end)

DustySection:Button("尘土飞扬的旅行2", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/artemy133563/Utilities/main/ADustyTrip",true))()
end)

local DeathBallTab = window:Tab("『死亡球』", "7733774602")
local DeathBallSection = DeathBallTab:section("『死亡球』", true)
DeathBallSection:Button("死亡球1", function()
    loadstring(game:HttpGet("https://github.com/Hosvile/InfiniX/releases/latest/download/main.lua",true))()
end)

local CarDealerTab = window:Tab("『汽车经销大亨』", "7733774602")
local CarDealerSection = CarDealerTab:section("『汽车经销大亨』", true)
CarDealerSection:Button("刷星星", function()
    loadstring(game:HttpGet("https://scriptblox.com/raw/LIMITED!-Car-Dealership-Tycoon-Moon-Team-16181"))()
end)

CarDealerSection:Button("汽车经销大亨1", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/IExpIoit/Script/main/Car%20Dealership%20Tycoon.lua"))()
end)

local LumberTab = window:Tab("『伐木大亨』", "7733774602")
local LumberSection = LumberTab:section("『伐木大亨』", true)
LumberSection:Button("伐木大亨1", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/UWU/main/LuaWare.lua", true))()
end)

local AXTab = window:Tab("『AX』", "7733774602")
local AXSection = AXTab:section("『AX』", true)
AXSection:Button("ax所有功能内有ohio", function()
    loadstring(game:HttpGet("https://raw.gitcode.com/Xingtaiduan/Scripts/raw/main/Loader.lua"))()
end)

local ChineseTab = window:Tab("『郝蕾脚本大全』", "7733774602")
local ChineseSection = ChineseTab:section("『郝蕾汉化加大部分资源』", true)

ChineseSection:Button("99虚空", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/99%E5%A4%9C%E8%99%9A%E7%A9%BA.txt"))()
end)

ChineseSection:Button("死铁轨", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E6%AD%BB%E9%93%81%E8%BD%A8.lua"))()
end)

ChineseSection:Button("墨水游戏", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E6%B1%89%E5%8C%96%E5%A2%A8%E6%B0%B4Ringta.txt"))()
end)

ChineseSection:Button("活了7天", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E4%B8%83%E6%97%A5%E7%94%9F%E6%88%90kkk.txt"))()
end)

ChineseSection:Button("BF", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/bf.txt"))()
end)

ChineseSection:Button("偷走脑红", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/偷走脑红"))()
end)

ChineseSection:Button("战争大亨", function()
    loadstring(game:HttpGet("https://pastefy.app/hDfjNmLP/raw"))()
end)

ChineseSection:Button("DOORs", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/VelocityX.lua"))()
end)

ChineseSection:Button("跳跃对决", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E8%B7%B3%E8%B7%83%E5%AF%B9%E5%86%B3.txt"))()
end)

ChineseSection:Button("刀刃球", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/ArgonHubX.lua"))()
end)

ChineseSection:Button("造船寻宝", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/zcxb.lua"))()
end)

ChineseSection:Button("自然灾害", function()
    loadstring(game:HttpGet'https://raw.githubusercontent.com/RunDTM/ZeeroxHub/main/Loader.lua')()
end)

ChineseSection:Button("最强战场隐身", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/VexonHub%E6%B1%89%E5%8C%96.txt"))()
end)

ChineseSection:Button("最强战场无视平a", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/10tempest01/tempest-hub/refs/heads/main/Launcher.lua"))()
end)

ChineseSection:Button("最强战场火车头", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/ATrainSounds/refs/heads/main/ATrain.lua"))()
end)

local csTab = window:Tab("『无敌少侠飞行R15』", "7733774602")
local csSection = csTab:section("『无敌少侠飞行R15』", true)
csSection:Button("飞行1", function()
    loadstring(game:HttpGet("https://gist.githubusercontent.com/JungleScripts/8dc95c7ce10e86d353d606334a77de88/raw/08f3e2967701463da36f2fc28e9943e63799dd3f/gistfile1.txt"))()
end)

csSection:Button("飞行2", function()
    loadstring(game:HttpGet("https://gist.githubusercontent.com/JungleScripts/775c6366d91d39fe2633c5805a1d0c23/raw/c8de949402393510a27bcf4482c957b6c3bed2c2/gistfile1.txt"))()
end)

csSection:Button("飞行不能停下来", function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))()
end)

local lolTab = window:Tab("『吃掉世界』", "7733774602")
local lolSection = lolTab:section("『吃掉世界』", true)
lolSection:Button("ccat", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/LED/refs/heads/main/%E5%90%83%E7%95%8C.lua"))()
end)

local fytTab = window:Tab("『终极战场』", "7733774602")
local fytSection = fytTab:section("『终极战场xi』", true)
fytSection:Button("Xi PRO", function()
    loadstring(game:HttpGet("http://raw.githubusercontent.com/123fa98/Xi_Pro/refs/heads/main/免费/终极战场.lua"))()
end)

local nTab = window:Tab("『偷走脑红朝霞』", "7733774602")
local nSection = nTab:section("『偷走脑红』", true)
nSection:Button("偷走脑红朝霞", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/342423114514/342423/refs/heads/main/7891.lua"))()
end)

nSection:Button("朝霞免费私服", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/yoursvexyyy/VEX-OP/refs/heads/main/free%20server%20finder"))()
end)

nSection:Button("偷走脑红朝霞", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/342423114514/342423/refs/heads/main/9178.lua"))()
end)

local bTab = window:Tab("『恐鬼症』", "7733774602")
local bSection = bTab:section("『恐鬼症』", true)
bSection:Button("恐鬼症", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/1111/refs/heads/main/%E6%81%90%E9%AC%BC%E7%97%87.lua"))()
end)

local gTab = window:Tab("『海战』", "7733774602")
local gSection = gTab:section("『海战』", true)
gSection:Button("海战", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/海战.lua"))()
end)

local hTab = window:Tab("『俄亥俄州』", "7733774602")
local hSection = hTab:section("『ohio』", true)
hSection:Button("俄亥俄州", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/俄亥俄州.lua"))()
end)

local qwTab = window:Tab("『监狱人生』", "7733774602")
local qwSection = qwTab:section("『监狱人生』", true)
qwSection:Button("监狱人生", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/监狱人生.lua"))()
end)

local bnTab = window:Tab("『奶奶』", "7733774602")
local bnSection = bnTab:section("『奶奶』", true)
bnSection:Button("奶奶", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/奶奶.lua"))()
end)

local buTab = window:Tab("『彩虹朋友』", "7733774602")
local buSection = buTab:section("『彩虹朋友』", true)
buSection:Button("彩虹朋友", function()
   loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/彩虹朋友.lua"))()
end)

local byuTab = window:Tab("『破坏者谜团』", "7733774602")
local byuSection = byuTab:section("『破坏者谜团』", true)
byuSection:Button("破坏者谜团", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/破坏者谜团2.lua"))()
end)