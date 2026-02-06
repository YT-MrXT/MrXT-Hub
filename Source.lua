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
    -- Aimbot
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

    -- Visuals (ESP)
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

-- HOME (REFORMULADA)
local home = window:CreateTab({ Name = "Home", Title = "Home", Icon = "rbxassetid://96457830014743" })
home:AddSection("Welcome MrXT Hub")
home:AddButton({ Name = "Copy Discord Server", Callback = function() setclipboard("https://discord.gg/v3GFFNDj9") end })

-- COMBAT
local combat = window:CreateTab({ Name = "Combat", Title = "Combat", Icon = "rbxassetid://96457830014743" })
combat:AddToggle({ Name = "Aimbot Assist", Callback = function(v) states.aimbot = v end })
combat:AddDropdown({ Name = "Aim Target", Options = {"Head", "HumanoidRootPart", "LowerTorso"}, Default = "Head", Callback = function(v) states.aimPart = v end })
combat:AddSlider({ Name = "Smoothness", Min = 1, Max = 10, Default = 2, Callback = function(v) states.smoothness = v/10 end })
combat:AddToggle({ Name = "Auto Clicker", Callback = function(v) states.autoClick = v end })
combat:AddToggle({ Name = "Spin-Bot", Callback = function(v) states.spinBot = v end })

-- MOVEMENT
local move = window:CreateTab({ Name = "Movement", Title = "Movement", Icon = "rbxassetid://96457830014743" })
move:AddToggle({ Name = "Fly", Callback = function(v) 
    states.fly = v
    if states.fly then
        local bv = Instance.new("BodyVelocity", player.Character.HumanoidRootPart)
        bv.Name = "XT_F"; bv.MaxForce = Vector3.new(1,1,1) * math.huge
        task.spawn(function()
            while states.fly do bv.Velocity = camera.CFrame.LookVector * states.flySpeed; task.wait() end
            bv:Destroy()
        end)
    end
end })
move:AddToggle({ Name = "Noclip", Callback = function(v) states.noclip = v end })
move:AddToggle({ Name = "Infinite Jump", Callback = function(v) states.infJump = v end })
move:AddSlider({ Name = "WalkSpeed", Min = 16, Max = 1000, Default = 16, Callback = function(v) player.Character.Humanoid.WalkSpeed = v end })
move:AddSlider({ Name = "JumpPower", Min = 50, Max = 1000, Default = 50, Callback = function(v) player.Character.Humanoid.JumpPower = v end })
move:AddSlider({ Name = "Fly Speed", Min = 10, Max = 1000, Default = 50, Callback = function(v) states.flySpeed = v end })

-- VISUALS
local visual = window:CreateTab({ Name = "Visuals", Title = "Visuals", Icon = "rbxassetid://96457830014743" })
visual:AddToggle({ Name = "ESP (Glow)", Callback = function(v) states.esp = v end })
visual:AddToggle({ Name = "ESP (Names)", Callback = function(v) states.espNames = v end })
visual:AddButton({ Name = "Fullbright", Callback = function() Lighting.Brightness = 2; Lighting.ClockTime = 14; Lighting.GlobalShadows = false end })
visual:AddSlider({ Name = "Field of View (FOV)", Min = 70, Max = 120, Default = 70, Callback = function(v) camera.FieldOfView = v end })

-- WORLD & FPS
local world = window:CreateTab({ Name = "World", Title = "World", Icon = "rbxassetid://96457830014743" })
world:AddButton({ Name = "Remove Textures (FPS Boost)", Callback = function()
    for _,v in pairs(game:GetDescendants()) do
        if v:IsA("CharacterMesh") or v:IsA("Decal") or v:IsA("Texture") then v:Destroy() end
    end
end })
world:AddButton({ Name = "Remove Fog", Callback = function() Lighting.FogEnd = 9e9 end })
world:AddButton({ Name = "Force Shift Lock (Mobile)", Callback = function() player.DevEnableMouseLock = true end })

-- UTILS
local utils = window:CreateTab({ Name = "Utils", Title = "Utils", Icon = "rbxassetid://96457830014743" })
utils:AddButton({ Name = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end })
utils:AddButton({ Name = "Anti-AFK", Callback = function()
    player.Idled:Connect(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),camera.CFrame); task.wait(1); game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),camera.CFrame) end)
end })
utils:AddButton({ Name = "Rejoin Server", Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId, player) end })
utils:AddButton({ Name = "Server Hop", Callback = function()
    local x = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    for _, v in pairs(x.data) do if v.playing < v.maxPlayers then game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id) end end
end })

-- c00lkidd
local c00lkidd = window:CreateTab({ Name = "c00lkidd", Title = "c00lkidd", Icon = "rbxassetid://96457830014743" })

c00lkidd:AddSection("Troll Scripts")

c00lkidd:AddButton({ Name = "Decal Spam", Callback = function()
    local decalID = 8408806737
    local function exPro(root)
        for _, v in pairs(root:GetChildren()) do
            if v:IsA("Decal") and v.Texture ~= "http://www.roblox.com/asset/?id="..decalID then
                v.Parent = nil
            elseif v:IsA("BasePart") then
                v.Material = "Plastic"
                v.Transparency = 0
                for i = 1, 6 do
                    local d = Instance.new("Decal", v)
                    d.Texture = "http://www.roblox.com/asset/?id="..decalID
                    if i == 1 then d.Face = "Front"
                    elseif i == 2 then d.Face = "Back"
                    elseif i == 3 then d.Face = "Right"
                    elseif i == 4 then d.Face = "Left"
                    elseif i == 5 then d.Face = "Top"
                    elseif i == 6 then d.Face = "Bottom" end
                end
            end
            exPro(v)
        end
    end
    exPro(game.Workspace)
    local s = Instance.new("Sky", game.Lighting)
    s.SkyboxBk = "http://www.roblox.com/asset/?id="..decalID
    s.SkyboxDn = "http://www.roblox.com/asset/?id="..decalID
    s.SkyboxFt = "http://www.roblox.com/asset/?id="..decalID
    s.SkyboxLf = "http://www.roblox.com/asset/?id="..decalID
    s.SkyboxRt = "http://www.roblox.com/asset/?id="..decalID
    s.SkyboxUp = "http://www.roblox.com/asset/?id="..decalID
    game.Lighting.TimeOfDay = 12
    task.spawn(function()
        while true do
            game.Lighting.Ambient = Color3.new(math.random(), math.random(), math.random())
            task.wait(0.2)
            game.Lighting.ShadowColor = Color3.new(math.random(), math.random(), math.random())
            task.wait(0.2)
        end
    end)
end })

c00lkidd:AddButton({ Name = "JOHN DOE", Callback = function()
    local redSkyboxAssetId = "rbxassetid://1012887"
    local sky = game.Lighting:FindFirstChildOfClass("Sky") or Instance.new("Sky", game.Lighting)
    sky.SkyboxBk = redSkyboxAssetId
    sky.SkyboxDn = redSkyboxAssetId
    sky.SkyboxFt = redSkyboxAssetId
    sky.SkyboxLf = redSkyboxAssetId
    sky.SkyboxRt = redSkyboxAssetId
    sky.SkyboxUp = redSkyboxAssetId
    local backgroundSound = game:GetService("SoundService"):FindFirstChild("PersistentBGSound") or Instance.new("Sound", game:GetService("SoundService"))
    backgroundSound.Name = "PersistentBGSound"
    backgroundSound.SoundId = "rbxassetid://19094700"
    backgroundSound.PlaybackSpeed = 0.221
    backgroundSound.Looped = true
    backgroundSound.Volume = 1
    backgroundSound:Play()
end })

window:Notify({ Title = "MrXT Hub", Text = "All features are ready!", Duration = 5 })
