game:GetService("StarterGui"):SetCore("SendNotification", { 
    Title = "MrXT";
    Text = "BY MrXT";
    Icon = "rbxthumb://type=Asset&id=96866982801235&w=150&h=150";
    Duration = 5;
})

local p=game.Players.LocalPlayer local g=Instance.new("ScreenGui",p.PlayerGui) g.ResetOnSpawn=false local f=Instance.new("Frame",g) f.Size=UDim2.new(0,190,0,40) f.Position=UDim2.new(.5,-100,0,12) f.BackgroundColor3=Color3.fromRGB(5,5,5) f.BackgroundTransparency=.1 Instance.new("UICorner",f).CornerRadius=UDim.new(0,10) local i=Instance.new("ImageLabel",f) i.Size=UDim2.new(0,28,0,28) i.Position=UDim2.new(0,8,.5,-14) i.BackgroundTransparency=1 i.Image="rbxthumb://type=Asset&id=96866982801235&w=150&h=150" Instance.new("UICorner",i).CornerRadius=UDim.new(1,0) local t=Instance.new("TextLabel",f) t.Size=UDim2.new(1,-54,1,0) t.Position=UDim2.new(0,40,0,0) t.BackgroundTransparency=1 t.Text="By MrXT" t.TextColor3=Color3.new(1,1,1) t.Font=Enum.Font.GothamBold t.TextSize=16 t.TextYAlignment=Enum.TextYAlignment.Center

return loadstring(game:HttpGet("https://raw.githubusercontent.com/DevHub-roblox/script-SYNTRAX-Hub/refs/heads/main/Game/Bloxfruit/SYNTRAXHub/main.txt.lua"))()
