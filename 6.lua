local OrionLib
local sources = {
    "https://raw.githubusercontent.com/shlexware/Orion/main/source",
    "https://pastebin.com/raw/FUEx0f3G",
    "https://raw.githubusercontent.com/ItzzExcel/Preview/main/Orion"
}

for i, source in ipairs(sources) do
    local success, result = pcall(function()
        return loadstring(game:HttpGet(source))()
    end)
    if success then
        OrionLib = result
        break
    end
end

local Window = OrionLib:MakeWindow({Name = "郝蕾脚本 v2.3", HidePremium = false, SaveConfig = false, IntroEnabled = false})

local player = game.Players.LocalPlayer

game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "郝蕾脚本"; Text ="正在加载脚本做好的脚本有更多的资源"; Duration = 2; })wait(3)
game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "郝蕾脚本"; Text ="付费版,包含了市面上大部分脚本"; Duration = 2; })wait(2)
game:GetService("StarterGui"):SetCore("SendNotification",{ Title = "郝蕾脚本"; Text ="载入成功"; Duration = 3; })

local InfoTab = Window:MakeTab({Name = "信息", Icon = "rbxassetid://4483345998", PremiumOnly = false})
InfoTab:AddLabel("郝蕾脚本")
InfoTab:AddLabel("作者：郝蕾")
InfoTab:AddLabel("师傅江砚辰")
InfoTab:AddLabel("作者qq3131827878")
InfoTab:AddLabel("账户信息")
InfoTab:AddLabel("你的账号:"..player.AccountAge.."世纪")
InfoTab:AddLabel("你的用户名:"..game.Players.LocalPlayer.Character.Name)
InfoTab:AddLabel("服务器名称:"..game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)

local ScriptsTab = Window:MakeTab({Name = "脚本合集", Icon = "rbxassetid://4483345998", PremiumOnly = false})
ScriptsTab:AddButton({Name = "鱼脚本", Callback = function()
    loadstring(game:HelpGet(utf8.char((function() return table.unpack({104,116,116,112,115,58,47,47,115,104,122,46,97,108,47,126,70,105,115,104,83,99,114,105,112,116,78,101,119})end)())))();
end})
ScriptsTab:AddButton({Name = "皮脚本", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
end})
ScriptsTab:AddButton({Name = "星河脚本", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/AWDX-DYVB/test/main/%E6%B2%B3%E6%B5%81%E6%97%A0%E5%AF%86%E9%92%A5.lua"))()
end})
ScriptsTab:AddButton({Name = "静心脚本", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/jxdjbx/gggggghjjnbb/main/jdjdd"))()
end})
ScriptsTab:AddButton({Name = "冷脚本", Callback = function()
    getgenv().Leng="冷脚本QQ群815883059" loadstring(game:HttpGet("https://raw.githubusercontent.com/odhdshhe/lenglenglenglenglenglenglenglenglenglenglengleng-cold-script-LBT-H/refs/heads/main/LENG-cold-script-LBT-H.txt"))()
end})
ScriptsTab:AddButton({Name = "XK脚本", Callback = function()
    loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\34\104\116\116\112\115\58\47\47\114\97\119\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\103\121\99\103\99\104\103\121\102\121\116\100\116\116\114\47\115\104\101\110\113\105\110\47\114\101\102\115\47\104\101\97\100\115\47\109\97\105\110\47\72\69\46\108\117\97\34\41\41\40\41")()
end})
ScriptsTab:AddButton({Name = "也是脚本但不知道名", Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/KwARpDxV",true))()
end})
ScriptsTab:AddButton({Name = "动感星期五", Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/KwARpDxV",true))()
end})

local UniversalTab = Window:MakeTab({Name = "通用", Icon = "rbxassetid://4483345998", PremiumOnly = false})
UniversalTab:AddButton({Name = "甩人", Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/zqyDSUWX"))()
end})
UniversalTab:AddButton({Name = "替身", Callback = function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/SkrillexMe/SkrillexLoader/main/SkrillexLoadMain')))()
end})
UniversalTab:AddButton({Name = "爬墙", Callback = function()
    loadstring(game:HttpGet("https://pastebin.com/raw/zXk4Rq2r"))()
end})
UniversalTab:AddButton({Name = "汉化阿尔宙斯自瞄", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/sgbs/main/%E4%B8%81%E4%B8%81%20%E6%B1%89%E5%8C%96%E8%87%AA%E7%9E%84.txt"))()
end})
UniversalTab:AddButton({Name = "工具挂", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Bebo-Mods/BeboScripts/main/StandAwekening.lua"))()
end})
UniversalTab:AddButton({Name = "甩飞", Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dingding123hhh/hknvh/main/%E7%94%A9%E9%A3%9E.txt"))()
end})
UniversalTab:AddButton({Name = "铁拳", Callback = function()
    loadstring(game:HttpGet('https://raw.githubusercontent.com/0Ben1/fe/main/obf_rf6iQURzu1fqrytcnLBAvW34C9N55kS9g9G3CKz086rC47M6632sEd4ZZYB0AYgV.lua.txt'))()
end})
UniversalTab:AddSlider({Name = "设置重力", Min = 196.2, Max = 1000, Default = 196.2, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "重力值", Callback = function(val) game.Workspace.Gravity = val end})
UniversalTab:AddSlider({Name = "跳跃高度", Min = 50, Max = 400, Default = 50, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "高度", Callback = function(val) spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.JumpPower = val end end) end})
UniversalTab:AddSlider({Name = "步行速度", Min = 16, Max = 400, Default = 16, Color = Color3.fromRGB(255,255,255), Increment = 1, ValueName = "速度", Callback = function(val) spawn(function() while task.wait() do game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val end end) end})
UniversalTab:AddToggle({Name = "夜视", Default = false, Callback = function(Value) if Value then game.Lighting.Ambient = Color3.new(1, 1, 1) else game.Lighting.Ambient = Color3.new(0, 0, 0) end end})
UniversalTab:AddToggle({Name = "自动互动", Default = false, Callback = function(state) if state then autoInteract = true while autoInteract do for _, descendant in pairs(workspace:GetDescendants()) do if descendant:IsA("ProximityPrompt") then fireproximityprompt(descendant) end end task.wait(0.25) end else autoInteract = false end end})

local DoorsTab = Window:MakeTab({Name = "doors", Icon = "rbxassetid://4483345998", PremiumOnly = false})
DoorsTab:AddButton({Name = "最强汉化", Callback = function() loadstring(game:HttpGet("\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\54\53\84\119\84\56\106\97"))() end})

local NinjaTab = Window:MakeTab({Name = "忍者传奇", Icon = "rbxassetid://4483345998", PremiumOnly = false})
NinjaTab:AddButton({Name = "忍者传奇1", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/-/refs/heads/main/hao1.lua"))() end})
NinjaTab:AddButton({Name = "传送", Callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/UzaUDSPK"))() end})

local PrisonTab = Window:MakeTab({Name = "越狱", Icon = "rbxassetid://4483345998", PremiumOnly = false})
PrisonTab:AddButton({Name = "越狱", Callback = function() loadstring(game:GetObjects("rbxassetid://3762448307")[1].Source)() end})

local SpeedTab = Window:MakeTab({Name = "极速传奇", Icon = "rbxassetid://4483345998", PremiumOnly = false})
SpeedTab:AddButton({Name = "1", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/TtmScripter/GoodScript/main/LegendOfSpeed(Chinese)"))() end})
SpeedTab:AddButton({Name = "2", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/TtmScripter/Legend-of-Speed-Auto-/main/GetPet"))() end})

local PressureTab = Window:MakeTab({Name = "『压力』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
PressureTab:AddButton({Name = "压力1", Callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/Ej3U4LbA"))() end})
PressureTab:AddButton({Name = "压力2", Callback = function() loadstring(game:HttpGet(('https://github.com/DocYogurt/Main/raw/main/Scripts/Pressure')))() end})

local DustyTab = Window:MakeTab({Name = "『尘土飞扬的旅行』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
DustyTab:AddButton({Name = "尘土飞扬的旅行1", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AbdouGG/dustytripv1/main/beta"))() end})
DustyTab:AddButton({Name = "尘土飞扬的旅行2", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/artemy133563/Utilities/main/ADustyTrip",true))() end})

local DeathBallTab = Window:MakeTab({Name = "『死亡球』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
DeathBallTab:AddButton({Name = "死亡球1", Callback = function() loadstring(game:HttpGet("https://github.com/Hosvile/InfiniX/releases/latest/download/main.lua",true))() end})

local CarDealerTab = Window:MakeTab({Name = "『汽车经销大亨』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
CarDealerTab:AddButton({Name = "刷星星", Callback = function() loadstring(game:HttpGet("https://scriptblox.com/raw/LIMITED!-Car-Dealership-Tycoon-Moon-Team-16181"))() end})
CarDealerTab:AddButton({Name = "汽车经销大亨1", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/IExpIoit/Script/main/Car%20Dealership%20Tycoon.lua"))() end})

local LumberTab = Window:MakeTab({Name = "『伐木大亨』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
LumberTab:AddButton({Name = "伐木大亨1", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoYunCN/UWU/main/LuaWare.lua", true))() end})

local AXTab = Window:MakeTab({Name = "『AX』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
AXTab:AddButton({Name = "ax所有功能内有ohio", Callback = function() loadstring(game:HttpGet("https://raw.gitcode.com/Xingtaiduan/Scripts/raw/main/Loader.lua"))() end})

local ChineseTab = Window:MakeTab({Name = "『郝蕾脚本大全』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
ChineseTab:AddButton({Name = "99虚空", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/99%E5%A4%9C%E8%99%9A%E7%A9%BA.txt"))() end})
ChineseTab:AddButton({Name = "死铁轨", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E6%AD%BB%E9%93%81%E8%BD%A8.lua"))() end})
ChineseTab:AddButton({Name = "墨水游戏", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E6%B1%89%E5%8C%96%E5%A2%A8%E6%B0%B4Ringta.txt"))() end})
ChineseTab:AddButton({Name = "活了7天", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E4%B8%83%E6%97%A5%E7%94%9F%E6%88%90kkk.txt"))() end})
ChineseTab:AddButton({Name = "BF", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/bf.txt"))() end})
ChineseTab:AddButton({Name = "偷走脑红", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/hdjsjjdgrhj/script-hub/refs/heads/main/偷走脑红"))() end})
ChineseTab:AddButton({Name = "战争大亨", Callback = function() loadstring(game:HttpGet("https://pastefy.app/hDfjNmLP/raw"))() end})
ChineseTab:AddButton({Name = "DOORs", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/VelocityX.lua"))() end})
ChineseTab:AddButton({Name = "跳跃对决", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/%E8%B7%B3%E8%B7%83%E5%AF%B9%E5%86%B3.txt"))() end})
ChineseTab:AddButton({Name = "刀刃球", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/ArgonHubX.lua"))() end})
ChineseTab:AddButton({Name = "造船寻宝", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/zcxb.lua"))() end})
ChineseTab:AddButton({Name = "自然灾害", Callback = function() loadstring(game:HttpGet'https://raw.githubusercontent.com/RunDTM/ZeeroxHub/main/Loader.lua')() end})
ChineseTab:AddButton({Name = "最强战场隐身", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/VexonHub%E6%B1%89%E5%8C%96.txt"))() end})
ChineseTab:AddButton({Name = "最强战场无视平a", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/10tempest01/tempest-hub/refs/heads/main/Launcher.lua"))() end})
ChineseTab:AddButton({Name = "最强战场火车头", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/ATrainSounds/refs/heads/main/ATrain.lua"))() end})

local csTab = Window:MakeTab({Name = "『无敌少侠飞行R15』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
csTab:AddButton({Name = "飞行1", Callback = function() loadstring(game:HttpGet("https://gist.githubusercontent.com/JungleScripts/8dc95c7ce10e86d353d606334a77de88/raw/08f3e2967701463da36f2fc28e9943e63799dd3f/gistfile1.txt"))() end})
csTab:AddButton({Name = "飞行2", Callback = function() loadstring(game:HttpGet("https://gist.githubusercontent.com/JungleScripts/775c6366d91d39fe2633c5805a1d0c23/raw/c8de949402393510a27bcf4482c957b6c3bed2c2/gistfile1.txt"))() end})
csTab:AddButton({Name = "飞行不能停下来", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invinicible-Flight-R15-45414"))() end})

local lolTab = Window:MakeTab({Name = "『吃掉世界』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
lolTab:AddButton({Name = "ccat", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/LED/refs/heads/main/%E5%90%83%E7%95%8C.lua"))() end})

local fytTab = Window:MakeTab({Name = "『终极战场』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
fytTab:AddButton({Name = "Xi PRO", Callback = function() loadstring(game:HttpGet("http://raw.githubusercontent.com/123fa98/Xi_Pro/refs/heads/main/免费/终极战场.lua"))() end})

local nTab = Window:MakeTab({Name = "『偷走脑红朝霞』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
nTab:AddButton({Name = "偷走脑红朝霞", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/342423114514/342423/refs/heads/main/7891.lua"))() end})
nTab:AddButton({Name = "朝霞免费私服", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/yoursvexyyy/VEX-OP/refs/heads/main/free%20server%20finder"))() end})
nTab:AddButton({Name = "偷走脑红朝霞", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/342423114514/342423/refs/heads/main/9178.lua"))() end})

local bTab = Window:MakeTab({Name = "『恐鬼症』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
bTab:AddButton({Name = "恐鬼症", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/1111/refs/heads/main/%E6%81%90%E9%AC%BC%E7%97%87.lua"))() end})

local gTab = Window:MakeTab({Name = "『海战』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
gTab:AddButton({Name = "海战", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/海战.lua"))() end})

local hTab = Window:MakeTab({Name = "『俄亥俄州』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
hTab:AddButton({Name = "俄亥俄州", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/俄亥俄州.lua"))() end})

local qwTab = Window:MakeTab({Name = "『监狱人生』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
qwTab:AddButton({Name = "监狱人生", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/监狱人生.lua"))() end})

local bnTab = Window:MakeTab({Name = "『奶奶』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
bnTab:AddButton({Name = "奶奶", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/奶奶.lua"))() end})

local buTab = Window:MakeTab({Name = "『彩虹朋友』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
buTab:AddButton({Name = "彩虹朋友", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/彩虹朋友.lua"))() end})

local byuTab = Window:MakeTab({Name = "『破坏者谜团』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
byuTab:AddButton({Name = "破坏者谜团", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/破坏者谜团2.lua"))() end})

local bytuTab = Window:MakeTab({Name = "『死亡之夜』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
bytuTab:AddButton({Name = "死亡之夜", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/-/refs/heads/main/%E6%AD%BB%E4%BA%A1%E4%B9%8B%E6%AD%BB(%E5%A4%9A%E5%96%9D%E6%B0%B4%E6%B1%89%E5%8C%96).lua"))() end})

local bkTab = Window:MakeTab({Name = "『巴掌大战』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
bkTab:AddButton({Name = "巴掌大战", Callback = function() loadstring(game:HttpGet(("https://raw.githubusercontent.com/Dusty1234567890/Guide/main/Guide")))() end})

local bmuTab = Window:MakeTab({Name = "『修仙模拟器』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
bmuTab:AddButton({Name = "修仙模拟器", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/1111/refs/heads/main/%E4%BF%AE%E4%BB%99%E6%A8%A1%E6%8B%9F%E5%99%A8%E8%84%9A%E6%9C%AC%E5%BC%80%E6%BA%90.txt"))() end})

local bmruTab = Window:MakeTab({Name = "『格蕾丝』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
bmruTab:AddButton({Name = "格蕾丝", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/XiaoXuAnZang/XKscript/refs/heads/main/GraceXJ.lua"))() end})

local bfuTab = Window:MakeTab({Name = "『一路向西』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
bfuTab:AddButton({Name = "一路向西", Callback = function() loadstring(game:HttpGet("https://pastebin.com/raw/0SKKXLB7"))() end})

local bnuTab = Window:MakeTab({Name = "『FPE』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
bnuTab:AddButton({Name = "FPE", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/FPE-S.lua"))() end})

local biuTab = Window:MakeTab({Name = "『种植花园』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
biuTab:AddButton({Name = "走马观灯", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E8%8A%B1%E5%9B%AD.lua"))() end})

local bcuTab = Window:MakeTab({Name = "『在超市生活一周』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
bcuTab:AddButton({Name = "缝合出品", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E5%9C%A8%E8%B6%85%E5%B8%82%E7%94%9F%E6%B4%BB%E4%B8%80%E5%91%A8.lua"))() end})

local bitTab = Window:MakeTab({Name = "『住宅大屠杀』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
bitTab:AddButton({Name = "缝合出品", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E4%BD%8F%E5%AE%85%E5%A4%A7%E5%B1%A0%E6%9D%80.lua"))() end})

local bruTab = Window:MakeTab({Name = "『矿井』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
bruTab:AddButton({Name = "缝合出品", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E7%9F%BF%E4%BA%95.lua"))() end})

local miuTab = Window:MakeTab({Name = "『河北唐县』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
miuTab:AddButton({Name = "缝合出品", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/a%20%E6%B2%B3%E5%8C%97%E5%94%90%E5%8E%BF.lua"))() end})

local tuTab = Window:MakeTab({Name = "『战斗勇士』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
tuTab:AddButton({Name = "自制", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E6%88%98%E6%96%97%E5%8B%87%E5%A3%AB.lua"))() end})

local bsTab = Window:MakeTab({Name = "『躲避』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
bsTab:AddButton({Name = "躲避", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E8%BA%B2%E9%81%BF.lua"))() end})

local byTab = Window:MakeTab({Name = "『植物大战僵尸』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
byTab:AddButton({Name = "朝霞汉化", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/342423114514/342423/refs/heads/main/7878"))() end})

local kyTab = Window:MakeTab({Name = "『墨水游戏』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
kyTab:AddButton({Name = "墨水游戏", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Xingtaiduan/Script/refs/heads/main/Games/墨水游戏.lua"))() end})

local krTab = Window:MakeTab({Name = "『动物捉迷藏』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
krTab:AddButton({Name = "动物捉迷藏", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E5%8A%A8%E7%89%A9%E6%8D%89%E8%BF%B7%E8%97%8F.lua"))() end})

local kiTab = Window:MakeTab({Name = "『黑暗欺骗』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
kiTab:AddButton({Name = "黑暗欺骗", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/Hunted.lua"))() end})

local kwTab = Window:MakeTab({Name = "『元素大亨』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
kwTab:AddButton({Name = "元素大亨", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E5%85%83%E7%B4%A0%E5%8A%9B%E9%87%8F%E5%A4%A7%E4%BA%A8.lua"))() end})

local kuTab = Window:MakeTab({Name = "『自然灾害黑洞』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
kuTab:AddButton({Name = "黑洞", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ke9460394-dot/ugik/refs/heads/main/V6.txt"))() end})

local mneTab = Window:MakeTab({Name = "『建造一架飞机』", Icon = "rbxassetid://4483345998", PremiumOnly = false})
mneTab:AddButton({Name = "刷钱", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Guo61/his/refs/heads/main/%E5%BB%BA%E9%80%A0%E4%B8%80%E6%9E%B6%E9%A3%9E%E6%9C%BA"))()end})

OrionLib:Init()