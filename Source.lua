local CatLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/YT-MrXT/lab/refs/heads/main/cat/libary/catlibz"))()

local window = CatLib:CreateWindow({
	Title = "MrXT Hub",
	Subtitle = "By MrXT",
	Icon = "rbxassetid://96866982801235",
	Size = UDim2.new(0, 500, 0, 300),
	FloatingButton = {
		Enabled = true,
		Icon = "rbxassetid://96866982801235",
		Size = UDim2.new(0, 60, 0, 60),
		Position = UDim2.new(0, 20, 0, 100),
		Shape = "Square"
	}
})

-- // CONFIGURAÇÕES GLOBAIS
local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local states = {
    aimbot = false,
    aimPart = "Head",
    smoothness = 0.2,
    fly = false,
    flySpeed = 50,
    noclip = false,
    esp = false,
    espNames = false,
    infJump = false,
    autoClick = false,
    spinBot = false
}

-- // SISTEMAS CORE (RENDER)
RunService.Stepped:Connect(function()
    if states.noclip and player.Character then
        for _, v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = false end
        end
    end
    if states.spinBot and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(50), 0)
    end
end)

game:GetService("UserInputService").JumpRequest:Connect(function()
    if states.infJump and player.Character then
        player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

task.spawn(function()
    while task.wait() do
        if states.autoClick then
            local tool = player.Character and player.Character:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if states.aimbot then
        local target, dist = nil, math.huge
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= player and v.Character and v.Character:FindFirstChild(states.aimPart) then
                local pos, visible = camera:WorldToViewportPoint(v.Character[states.aimPart].Position)
                if visible then
                    local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude
                    if mag < dist then target = v; dist = mag end
                end
            end
        end
        if target then
            camera.CFrame = camera.CFrame:Lerp(CFrame.new(camera.CFrame.Position, target.Character[states.aimPart].Position), states.smoothness)
        end
    end

    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= player and v.Character then
            local hl = v.Character:FindFirstChild("XT_Glow")
            if states.esp then
                if not hl then
                    hl = Instance.new("Highlight", v.Character)
                    hl.Name = "XT_Glow"; hl.FillColor = Color3.fromRGB(255, 0, 0)
                end
                local head = v.Character:FindFirstChild("Head")
                if head then
                    local tag = head:FindFirstChild("XT_Tag")
                    if states.espNames and not tag then
                        local b = Instance.new("BillboardGui", head)
                        b.Name = "XT_Tag"; b.AlwaysOnTop = true; b.Size = UDim2.new(0,100,0,50); b.StudsOffset = Vector3.new(0,3,0)
                        local l = Instance.new("TextLabel", b)
                        l.Text = v.Name; l.Size = UDim2.new(1,0,1,0); l.BackgroundTransparency = 1; l.TextColor3 = Color3.new(1,1,1); l.TextStrokeTransparency = 0; l.TextScaled = true
                    elseif not states.espNames and tag then tag:Destroy() end
                end
            else
                if hl then hl:Destroy() end
                if v.Character:FindFirstChild("Head") and v.Character.Head:FindFirstChild("XT_Tag") then v.Character.Head.XT_Tag:Destroy() end
            end
        end
    end
end)

-- // ABAS DO HUB
local home = window:CreateTab({ Name = "Home", Title = "Home", Icon = "rbxassetid://104975690664571" })
home:AddSection("Welcome MrXT Hub")
home:AddDiscordInvite({Icon = "rbxassetid://96866982801235", ServerName = "MrXT Community", Link = "discord.gg/v3GFFNDj9"})
home:AddButton({ Name = "Copy Discord Server", Callback = function() setclipboard("https://discord.gg/v3GFFNDj9") end })

local bf = window:CreateTab({ Name = "Blox Fruits", Title = "Blox Fruits", Icon = "rbxassetid://99035244333265" })
bf:AddSection("Recommended (No Key)")
bf:AddButton({ Name = "MrXT Hub Farm (No Key)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/YT-MrXT/MrXT-Hub-Uni/refs/heads/main/Source.lua"))() end })
bf:AddButton({ Name = "Quantum Onyx (No Key)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/flazhy/QuantumOnyx/refs/heads/main/QuantumOnyx.lua"))() end })
bf:AddButton({ Name = "MrXT Classic (No Key)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/YT-MrXT/MrXT-Classic/refs/heads/main/Source.lua"))() end })
bf:AddButton({ Name = "MrXT Best (No Key)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/YT-MrXT/MrXT-Best/refs/heads/main/Source.lua"))() end })
bf:AddButton({ Name = "Redz Hub (No Key)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/REDZHUB/BloxFruits/main/redz7.lua"))() end })
bf:AddButton({ Name = "Speed Hub (No Key)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/AhmadV9S/SpeedHub/main/Main"))() end })
bf:AddButton({ Name = "Ripper Hub (No Key)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/HibaTheBest/RipperHubV3/main/Main.lua"))() end })

bf:AddSection("Advanced (Need Key)")
bf:AddButton({ Name = "Hoho Hub (Need Key)", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/acsu123/HOHO_HUB/main/Loading_GUI'))() end })
bf:AddButton({ Name = "Alchemy Hub (Need Key)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Deidara_A1/AlchemyHub/main/Main.lua"))() end })
bf:AddButton({ Name = "W-Azure (Need Key)", Callback = function() loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3b2169cf534614430541300063f237f8.lua"))() end })
bf:AddButton({ Name = "Mukuro Hub (Need Key)", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/xQuartyx/DonateMe/main/ScriptLoader'))() end })

bf:AddSection("Built-in Features (MrXT)")
local autoStatsStates = { Enabled = false, SelectedStat = "Melee" }
bf:AddDropdown({ Name = "Select Stat to Upgrade", Options = {"Melee", "Defense", "Sword", "Gun", "Demon Fruit"}, Default = "Melee", Callback = function(v) autoStatsStates.SelectedStat = v end })
bf:AddToggle({ Name = "Auto Stats", Callback = function(v) 
    autoStatsStates.Enabled = v
    task.spawn(function()
        while autoStatsStates.Enabled do
            pcall(function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", autoStatsStates.SelectedStat, 1) end)
            task.wait(0.1)
        end
    end)
end })

-- // DETECÇÃO DE SEA E TELEPORTES FILTRADOS
local worldId = game.PlaceId
local seaName = (worldId == 2753915549 and "Sea 1") or (worldId == 4442272160 and "Sea 2") or (worldId == 7449925010 and "Sea 3") or "Unknown"

local allIslands = {
    ["Sea 1"] = {
        ["Starter Island (Pirate)"] = CFrame.new(979, 16, 1419), ["Starter Island (Marine)"] = CFrame.new(-2566, 6, 2045), ["Jungle"] = CFrame.new(-1600, 37, 153), ["Pirate Village"] = CFrame.new(-1185, 4, 3813), ["Desert"] = CFrame.new(897, 6, 4390), ["Middle Town"] = CFrame.new(-689, 7, 1530), ["Frozen Village"] = CFrame.new(1360, 37, -1909), ["Marine Fortress"] = CFrame.new(-5026, 21, 4281), ["Skylands"] = CFrame.new(-4986, 717, -2626), ["Upper Skylands"] = CFrame.new(196, 4776, -4506), ["Prison"] = CFrame.new(4830, 6, 718), ["Colosseum"] = CFrame.new(-3144, 305, -2982), ["Magma Village"] = CFrame.new(-5283, 8, 8504), ["Underwater City"] = CFrame.new(61163, 11, 1569), ["Fountain City"] = CFrame.new(5258, 38, 4050), ["Mob Boss Island"] = CFrame.new(-2850, 7, 5336)
    },
    ["Sea 2"] = {
        ["Kingdom of Rose"] = CFrame.new(147, 23, 2776), ["Cafe"] = CFrame.new(-380, 73, 296), ["Green Zone"] = CFrame.new(-2415, 73, -3172), ["Graveyard"] = CFrame.new(-1499, 133, -2763), ["Snow Mountain"] = CFrame.new(878, 412, -3162), ["Hot and Cold"] = CFrame.new(-5854, 16, -5052), ["Cursed Ship"] = CFrame.new(923, 125, 32852), ["Ice Castle"] = CFrame.new(6148, 294, -6934), ["Forgotten Island"] = CFrame.new(-3032, 239, -10145), ["Dark Arena"] = CFrame.new(3798, 15, -3494), ["Usoapp Island"] = CFrame.new(4800, 8, 2800)
    },
    ["Sea 3"] = {
        ["Port Town"] = CFrame.new(-290, 7, 5344), ["Hydra Island"] = CFrame.new(5748, 610, -253), ["Great Tree"] = CFrame.new(2285, 74, -7105), ["Floating Turtle"] = CFrame.new(-12470, 334, -7517), ["Mansion"] = CFrame.new(-12463, 334, -7520), ["Castle on Sea"] = CFrame.new(-5043, 314, -3157), ["Haunted Castle"] = CFrame.new(-9494, 142, 5526), ["Sea of Treats"] = CFrame.new(-2123, 50, -11915), ["Peanut Island"] = CFrame.new(-2000, 50, -10000), ["Ice Cream Island"] = CFrame.new(-900, 65, -10900), ["Cake Island"] = CFrame.new(-1900, 37, -12000), ["Chocolate Island"] = CFrame.new(150, 24, -12000), ["Tiki Outpost"] = CFrame.new(-16200, 10, 300)
    }
}

local currentSeaIslands = allIslands[seaName] or {}
local islandNames = {} for n, _ in pairs(currentSeaIslands) do table.insert(islandNames, n) end
table.sort(islandNames)
local selectedIsland = islandNames[1] or "No Islands Found"

bf:AddDropdown({ Name = "Teleport ("..seaName..")", Options = islandNames, Default = selectedIsland, Callback = function(v) selectedIsland = v end })
bf:AddButton({ Name = "Teleport", Callback = function()
    local char = player.Character
    if char and char:FindFirstChild("HumanoidRootPart") and currentSeaIslands[selectedIsland] then
        local root = char.HumanoidRootPart
        local target = currentSeaIslands[selectedIsland]
        local bv = Instance.new("BodyVelocity", root)
        bv.Velocity = Vector3.new(0,0,0); bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        local tween = TweenService:Create(root, TweenInfo.new((root.Position - target.Position).Magnitude/300, Enum.EasingStyle.Linear), {CFrame = target})
        tween:Play(); tween.Completed:Connect(function() bv:Destroy() end)
    end
end })

local cv = window:CreateTab({ Name = "Combat & Visuals", Title = "Combat & Visuals", Icon = "rbxassetid://100022175105918" })
cv:AddSection("Combat Settings")
cv:AddButton({ Name = "Aimbot Universal (no key)", Callback = function() loadstring(game:HttpGet("https://bitbucket.org/tekscripts/tkst/raw/9c287b9926e874d965400327b89a2c8ef6a954a5/Scripts/uni-aimbot.lua"))() end })
cv:AddButton({ Name = "GunGame Aimbot (no key)", Callback = function() loadstring(game:HttpGet("https://rawscripts.net/raw/Gunfight-Arena-Gunfight-arena-Script-OP-36785"))() end })
cv:AddToggle({ Name = "Aimbot Assist", Callback = function(v) states.aimbot = v end })
cv:AddDropdown({ Name = "Aim Target", Options = {"Head", "HumanoidRootPart", "LowerTorso"}, Default = "Head", Callback = function(v) states.aimPart = v end })
cv:AddSlider({ Name = "Smoothness", Min = 1, Max = 10, Default = 2, Callback = function(v) states.smoothness = v/10 end })
cv:AddToggle({ Name = "Auto Clicker", Callback = function(v) states.autoClick = v end })
cv:AddToggle({ Name = "Spin-Bot", Callback = function(v) states.spinBot = v end })
cv:AddSection("Visual Settings")
cv:AddToggle({ Name = "ESP (Glow)", Callback = function(v) states.esp = v end })
cv:AddToggle({ Name = "ESP (Names)", Callback = function(v) states.espNames = v end })
cv:AddButton({ Name = "Fullbright", Callback = function() Lighting.Brightness = 2; Lighting.ClockTime = 14; Lighting.GlobalShadows = false end })
cv:AddSlider({ Name = "Field of View (FOV)", Min = 70, Max = 120, Default = 70, Callback = function(v) camera.FieldOfView = v end })
cv:AddSection("World Settings")
cv:AddButton({ Name = "Remove Textures (FPS Boost)", Callback = function() for _,v in pairs(game:GetDescendants()) do if v:IsA("CharacterMesh") or v:IsA("Decal") or v:IsA("Texture") then v:Destroy() end end end })
cv:AddButton({ Name = "Remove Fog", Callback = function() Lighting.FogEnd = 9e9 end })
cv:AddButton({ Name = "Force Shift Lock (Mobile)", Callback = function() player.DevEnableMouseLock = true end })

local move = window:CreateTab({ Name = "Movement", Title = "Movement", Icon = "rbxassetid://96457830014743" })
move:AddToggle({ Name = "Fly", Callback = function(v) 
    states.fly = v
    if states.fly then
        local bv = Instance.new("BodyVelocity", player.Character.HumanoidRootPart)
        bv.Name = "XT_F"; bv.MaxForce = Vector3.new(1,1,1) * math.huge
        task.spawn(function() while states.fly do bv.Velocity = camera.CFrame.LookVector * states.flySpeed; task.wait() end; bv:Destroy() end)
    end
end })
move:AddToggle({ Name = "Noclip", Callback = function(v) states.noclip = v end })
move:AddToggle({ Name = "Infinite Jump", Callback = function(v) states.infJump = v end })
move:AddSlider({ Name = "WalkSpeed", Min = 16, Max = 1000, Default = 16, Callback = function(v) player.Character.Humanoid.WalkSpeed = v end })
move:AddSlider({ Name = "JumpPower", Min = 50, Max = 1000, Default = 50, Callback = function(v) player.Character.Humanoid.JumpPower = v end })
move:AddSlider({ Name = "Fly Speed", Min = 10, Max = 1000, Default = 50, Callback = function(v) states.flySpeed = v end })

local c00lkidd = window:CreateTab({ Name = "c00lkidd", Title = "c00lkidd", Icon = "rbxassetid://78210180370953" })
local selectedPlayer = ""
local function getPlayers() local p = {} for _, v in pairs(game.Players:GetPlayers()) do table.insert(p, v.Name) end return p end
local pDrop = c00lkidd:AddDropdown({ Name = "Select Target", Options = getPlayers(), Default = "None", Callback = function(v) selectedPlayer = v end })
c00lkidd:AddButton({ Name = "Refresh Player List", Callback = function() pDrop:SetOptions(getPlayers()) end })
c00lkidd:AddSection("Universal Chaos")
c00lkidd:AddButton({ Name = "Decal Spam (FE Universal)", Callback = function() local decalID = 8408806737; for _, obj in pairs(workspace:GetDescendants()) do if obj:IsA("BasePart") then local d = Instance.new("Decal", obj); d.Texture = "rbxassetid://"..decalID end end end })
c00lkidd:AddButton({ Name = "Universal Kick/Crash Target", Callback = function() local target = game.Players:FindFirstChild(selectedPlayer); if target then for _, v in pairs(game:GetDescendants()) do if v:IsA("RemoteEvent") and (v.Name:lower():find("kick") or v.Name:lower():find("ban")) then v:FireServer(target, "Exploit") end end end end })
c00lkidd:AddButton({ Name = "Kill Target (FE Check)", Callback = function() local target = game.Players:FindFirstChild(selectedPlayer); if target and target.Character then for _, v in pairs(game:GetDescendants()) do if v:IsA("RemoteEvent") and (v.Name:lower():find("damage")) then v:FireServer(target.Character.Humanoid, 9e9) end end end end })
c00lkidd:AddButton({ Name = "Server Lag (Safe Flood)", Callback = function() task.spawn(function() while task.wait(0.6) do local re = game:GetService("ReplicatedStorage"):FindFirstChild("DefaultChatSystemChatEvents"); if re then re.SayMessageRequest:FireServer(string.rep("c00lkidd ", 25), "All") end end end) end })
c00lkidd:AddSection("Brookhaven Specials")
c00lkidd:AddButton({ Name = "Unlock All House Doors", Callback = function() local re = game:GetService("ReplicatedStorage"):FindFirstChild("RE"); if re then re:FireServer("HouseLock", false) end end })
c00lkidd:AddButton({ Name = "Fire All House Alarms", Callback = function() local re = game:GetService("ReplicatedStorage"):FindFirstChild("RE"); if re then re:FireServer("HouseAlarm", true) end end })
c00lkidd:AddSection("Atmosphere Trolls")
c00lkidd:AddButton({ Name = "JOHN DOE Theme", Callback = function() local sky = game.Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky", game.Lighting); sky.SkyboxBk = "rbxassetid://1012887"; sky.SkyboxDn = "rbxassetid://1012887"; sky.SkyboxFt = "rbxassetid://1012887"; sky.SkyboxLf = "rbxassetid://1012887"; sky.SkyboxRt = "rbxassetid://1012887"; sky.SkyboxUp = "rbxassetid://1012887"; game.Lighting.FogColor = Color3.new(1, 0, 0); game.Lighting.FogEnd = 100; end })
c00lkidd:AddButton({ Name = "Spectate Target", Callback = function() local target = game.Players:FindFirstChild(selectedPlayer); if target and target.Character then camera.CameraSubject = target.Character.Humanoid end end })
c00lkidd:AddButton({ Name = "Reset Camera", Callback = function() camera.CameraSubject = player.Character.Humanoid end })

local utils = window:CreateTab({ Name = "Utils", Title = "Utils", Icon = "rbxassetid://77179710364664" })
utils:AddButton({ Name = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end })
utils:AddButton({ Name = "Anti-AFK", Callback = function() player.Idled:Connect(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),camera.CFrame); task.wait(1); game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),camera.CFrame) end) end })
utils:AddButton({ Name = "Rejoin Server", Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId, player) end })

window:Notify({ Title = "MrXT Hub", Text = "MrXT Hub loaded", Duration = 5 })
