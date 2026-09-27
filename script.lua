local P=game:GetService("Players")
local R=game:GetService("RunService")
local U=game:GetService("UserInputService")
local C=workspace.CurrentCamera
local L=P.LocalPlayer
local PG=L:WaitForChild("PlayerGui")

local cfg={ESP=false,AIM=false,HMURD=true,HFOV=150,HSM=0.3,SILENT=false,INV=false,NOC=false,SPD=20,JMP=60,FLY=false,FLYSPD=60,ADODGE=false,INFJUMP=false,GOD=false,AFARM=false,AFSPD=2,AWIN=false,KILLALL=false,FLING=false,FLT=nil,ANTIAFK=false,CROSS=false,HITBOX=false,HBS=3,SPIN=false}

local function role(p)
    if not p or not p.Character then return "?" end
    if p.Team then
        local t=p.Team.Name:lower()
        if t:find("murder") then return "Murderer" end
        if t:find("sheriff") then return "Sheriff" end
    end
    for _,c in pairs({p.Character,p:FindFirstChild("Backpack")}) do
        if c then for _,t in pairs(c:GetChildren()) do
            if t:IsA("Tool") then
                local n=t.Name:lower()
                if n:find("knife") then return "Murderer" end
                if n:find("gun") then return "Sheriff" end
            end
        end end
    end
    return "Innocent"
end

local RC={Murderer=Color3.fromRGB(255,60,60),Sheriff=Color3.fromRGB(60,160,255),Innocent=Color3.fromRGB(60,255,120),["?"]=Color3.fromRGB(180,180,180)}

local ig=Instance.new("ScreenGui",PG)
ig.IgnoreGuiInset=true
local bg=Instance.new("Frame",ig)
bg.Size=UDim2.new(1,0,1,0)
bg.BackgroundColor3=Color3.new(0,0,0)
local hl=Instance.new("TextLabel",bg)
hl.Size=UDim2.new(1,0,1,0)
hl.BackgroundTransparency=1
hl.Text="Hello"
hl.TextColor3=Color3.fromRGB(0,255,200)
hl.Font=Enum.Font.GothamBlack
hl.TextSize=90
hl.TextTransparency=1
task.spawn(function()
    for i=1,10 do hl.TextTransparency-=0.1; task.wait(0.04) end
    task.wait(1)
    for i=1,10 do hl.TextTransparency+=0.1; task.wait(0.04) end
    ig:Destroy()
end)

local sg=Instance.new("ScreenGui",PG)
sg.IgnoreGuiInset=true
sg.ResetOnSpawn=false

local ob=Instance.new("TextButton",sg)
ob.Size=UDim2.new(0,40,0,40)
ob.Position=UDim2.new(0,10,0.5,-20)
ob.BackgroundColor3=Color3.fromRGB(25,25,30)
ob.Text="T"
ob.TextColor3=Color3.fromRGB(200,200,210)
ob.Font=Enum.Font.GothamBold
ob.TextSize=18
ob.Draggable=true
ob.Visible=false
Instance.new("UICorner",ob).CornerRadius=UDim.new(1,0)

local m=Instance.new("Frame",sg)
m.Size=UDim2.new(0,500,0,340)
m.Position=UDim2.new(0.5,-250,0.5,-170)
m.BackgroundColor3=Color3.fromRGB(18,18,22)
m.BorderSizePixel=0
m.Draggable=true
m.Active=true
Instance.new("UICorner",m).CornerRadius=UDim.new(0,10)

local tb=Instance.new("Frame",m)
tb.Size=UDim2.new(1,0,0,36)
tb.BackgroundColor3=Color3.fromRGB(22,22,26)
tb.BorderSizePixel=0
Instance.new("UICorner",tb).CornerRadius=UDim.new(0,10)
local tt=Instance.new("TextLabel",tb)
tt.Size=UDim2.new(1,-50,1,0)
tt.Position=UDim2.new(0,12,0,0)
tt.BackgroundTransparency=1
tt.Text="TOLA HUB"
tt.TextColor3=Color3.fromRGB(230,230,240)
tt.Font=Enum.Font.GothamBold
tt.TextSize=13
tt.TextXAlignment=Enum.TextXAlignment.Left
local cb=Instance.new("TextButton",tb)
cb.Size=UDim2.new(0,24,0,24)
cb.Position=UDim2.new(1,-30,0,6)
cb.BackgroundColor3=Color3.fromRGB(60,30,35)
cb.Text="✕"
cb.TextColor3=Color3.fromRGB(220,100,100)
cb.Font=Enum.Font.GothamBold
Instance.new("UICorner",cb).CornerRadius=UDim.new(0,6)
cb.MouseButton1Click:Connect(function() m.Visible=false; ob.Visible=true end)
ob.MouseButton1Click:Connect(function() m.Visible=true; ob.Visible=false end)

local sb=Instance.new("Frame",m)
sb.Size=UDim2.new(0,120,1,-46)
sb.Position=UDim2.new(0,5,0,41)
sb.BackgroundColor3=Color3.fromRGB(20,20,24)
Instance.new("UICorner",sb).CornerRadius=UDim.new(0,8)
local sl=Instance.new("UIListLayout",sb)
sl.Padding=UDim.new(0,2)
local sp=Instance.new("UIPadding",sb)
sp.PaddingTop=UDim.new(0,5)
sp.PaddingLeft=UDim.new(0,5)
sp.PaddingRight=UDim.new(0,5)

local ct=Instance.new("ScrollingFrame",m)
ct.Size=UDim2.new(1,-135,1,-46)
ct.Position=UDim2.new(0,130,0,41)
ct.BackgroundTransparency=1
ct.ScrollBarThickness=3
ct.CanvasSize=UDim2.new(0,0,0,0)
ct.AutomaticCanvasSize=Enum.AutomaticSize.Y
ct.ClipsDescendants=true
local cl=Instance.new("UIListLayout",ct)
cl.Padding=UDim.new(0,5)

local tabs={}
local function Tab(n,i)
    local b=Instance.new("TextButton",sb)
    b.Size=UDim2.new(1,0,0,28)
    b.BackgroundColor3=Color3.fromRGB(25,25,30)
    b.Text=i.."  "..n
    b.TextColor3=Color3.fromRGB(150,150,160)
    b.Font=Enum.Font.Gotham
    b.TextSize=11
    b.TextXAlignment=Enum.TextXAlignment.Left
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
    local f=Instance.new("Frame",ct)
    f.Size=UDim2.new(1,-4,0,0)
    f.BackgroundTransparency=1
    f.Visible=false
    f.AutomaticSize=Enum.AutomaticSize.Y
    local l=Instance.new("UIListLayout",f)
    l.Padding=UDim.new(0,5)
    b.MouseButton1Click:Connect(function()
        for _,t in pairs(tabs) do t.F.Visible=false; t.B.BackgroundColor3=Color3.fromRGB(25,25,30); t.B.TextColor3=Color3.fromRGB(150,150,160) end
        f.Visible=true
        b.BackgroundColor3=Color3.fromRGB(45,45,55)
        b.TextColor3=Color3.fromRGB(230,230,240)
    end)
    tabs[n]={B=b,F=f}
    return f
end

local function S(p,t)
    local l=Instance.new("TextLabel",p)
    l.Size=UDim2.new(1,0,0,16)
    l.BackgroundTransparency=1
    l.Text=t:upper()
    l.TextColor3=Color3.fromRGB(90,90,100)
    l.Font=Enum.Font.GothamBold
    l.TextSize=10
    l.TextXAlignment=Enum.TextXAlignment.Left
end

local function T(p,t,d,cb)
    local b=Instance.new("TextButton",p)
    b.Size=UDim2.new(1,0,0,28)
    b.BackgroundColor3=Color3.fromRGB(28,28,34)
    b.Text=""
    b.AutoButtonColor=false
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
    local lb=Instance.new("TextLabel",b)
    lb.Size=UDim2.new(1,-50,1,0)
    lb.Position=UDim2.new(0,10,0,0)
    lb.BackgroundTransparency=1
    lb.Text=t
    lb.TextColor3=d and Color3.fromRGB(230,230,240) or Color3.fromRGB(140,140,150)
    lb.Font=Enum.Font.Gotham
    lb.TextSize=11
    lb.TextXAlignment=Enum.TextXAlignment.Left
    local i=Instance.new("Frame",b)
    i.Size=UDim2.new(0,26,0,14)
    i.Position=UDim2.new(1,-36,0.5,-7)
    i.BackgroundColor3=d and Color3.fromRGB(0,255,200) or Color3.fromRGB(60,60,70)
    i.BorderSizePixel=0
    Instance.new("UICorner",i).CornerRadius=UDim.new(1,0)
    local k=Instance.new("Frame",i)
    k.Size=UDim2.new(0,10,0,10)
    k.Position=d and UDim2.new(1,-12,0.5,-5) or UDim2.new(0,2,0.5,-5)
    k.BackgroundColor3=Color3.fromRGB(255,255,255)
    k.BorderSizePixel=0
    Instance.new("UICorner",k).CornerRadius=UDim.new(1,0)
    local s=d
    b.MouseButton1Click:Connect(function()
        s=not s
        lb.TextColor3=s and Color3.fromRGB(230,230,240) or Color3.fromRGB(140,140,150)
        i.BackgroundColor3=s and Color3.fromRGB(0,255,200) or Color3.fromRGB(60,60,70)
        k.Position=s and UDim2.new(1,-12,0.5,-5) or UDim2.new(0,2,0.5,-5)
        cb(s)
    end)
end

local function Sl(p,t,mn,mx,d,cb)
    local f=Instance.new("Frame",p)
    f.Size=UDim2.new(1,0,0,36)
    f.BackgroundColor3=Color3.fromRGB(28,28,34)
    Instance.new("UICorner",f).CornerRadius=UDim.new(0,6)
    local lb=Instance.new("TextLabel",f)
    lb.Size=UDim2.new(1,-12,0,14)
    lb.Position=UDim2.new(0,8,0,3)
    lb.BackgroundTransparency=1
    lb.Text=t.."  —  "..d
    lb.TextColor3=Color3.fromRGB(170,170,180)
    lb.Font=Enum.Font.Gotham
    lb.TextSize=10
    lb.TextXAlignment=Enum.TextXAlignment.Left
    local bar=Instance.new("Frame",f)
    bar.Size=UDim2.new(1,-16,0,4)
    bar.Position=UDim2.new(0,8,0,25)
    bar.BackgroundColor3=Color3.fromRGB(45,45,52)
    Instance.new("UICorner",bar).CornerRadius=UDim.new(0,2)
    local fl=Instance.new("Frame",bar)
    fl.Size=UDim2.new((d-mn)/(mx-mn),0,1,0)
    fl.BackgroundColor3=Color3.fromRGB(0,255,200)
    fl.BorderSizePixel=0
    Instance.new("UICorner",fl).CornerRadius=UDim.new(0,2)
    local dr=false
    bar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=true end end)
    bar.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then dr=false end end)
    U.InputChanged:Connect(function(i)
        if dr and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            local r=math.clamp((i.Position.X-bar.AbsolutePosition.X)/bar.AbsoluteSize.X,0,1)
            local v=math.floor(mn+(mx-mn)*r)
            fl.Size=UDim2.new(r,0,1,0)
            lb.Text=t.."  —  "..v
            cb(v)
        end
    end)
end

local function Btn(p,t,cb)
    local b=Instance.new("TextButton",p)
    b.Size=UDim2.new(1,0,0,26)
    b.BackgroundColor3=Color3.fromRGB(35,35,42)
    b.Text="  "..t
    b.TextColor3=Color3.fromRGB(200,200,210)
    b.Font=Enum.Font.Gotham
    b.TextSize=11
    b.TextXAlignment=Enum.TextXAlignment.Left
    Instance.new("UICorner",b).CornerRadius=UDim.new(0,6)
    b.MouseButton1Click:Connect(cb)
end

local Comb=Tab("Combat","⚔")
local Vis=Tab("Visuals","👁")
local Mov=Tab("Movement","🏃")
local Far=Tab("Farm","💰")
local Mis=Tab("Misc","⚙")

S(Comb,"AIM")
T(Comb,"Aimbot",false,function(v) cfg.AIM=v end)
T(Comb,"Silent Aim",false,function(v) cfg.SILENT=v end)
T(Comb,"Murderer Only",true,function(v) cfg.HMURD=v end)
Sl(Comb,"FOV",50,500,150,function(v) cfg.HFOV=v end)
Sl(Comb,"Smoothness",10,50,30,function(v) cfg.HSM=v/100 end)

S(Comb,"ATTACK")
T(Comb,"Auto Win (Sheriff)",false,function(v) cfg.AWIN=v end)
T(Comb,"Kill All (Murderer)",false,function(v) cfg.KILLALL=v end)

S(Comb,"DEFENSE")
T(Comb,"Auto-Dodge",false,function(v) cfg.ADODGE=v end)
T(Comb,"God Mode",false,function(v) cfg.GOD=v end)

S(Comb,"FLING")
T(Comb,"Fling To Player",false,function(v) cfg.FLING=v; if not v then cfg.FLT=nil end end)
Btn(Comb,"🎯 Выбрать игрока",function()
    if _G.FG then _G.FG:Destroy() end
    local fg=Instance.new("ScreenGui",PG)
    fg.DisplayOrder=1000
    _G.FG=fg
    local fr=Instance.new("Frame",fg)
    fr.Size=UDim2.new(0,240,0,280)
    fr.Position=UDim2.new(0.5,-120,0.5,-140)
    fr.BackgroundColor3=Color3.fromRGB(18,18,22)
    fr.BorderSizePixel=0
    Instance.new("UICorner",fr).CornerRadius=UDim.new(0,10)
    local ti=Instance.new("TextLabel",fr)
    ti.Size=UDim2.new(1,0,0,32)
    ti.BackgroundColor3=Color3.fromRGB(22,22,26)
    ti.Text="Выбери игрока"
    ti.TextColor3=Color3.fromRGB(230,230,240)
    ti.Font=Enum.Font.GothamBold
    ti.TextSize=12
    Instance.new("UICorner",ti).CornerRadius=UDim.new(0,10)
    local cl=Instance.new("TextButton",ti)
    cl.Size=UDim2.new(0,22,0,22)
    cl.Position=UDim2.new(1,-28,0,5)
    cl.BackgroundColor3=Color3.fromRGB(60,30,35)
    cl.Text="✕"
    cl.TextColor3=Color3.fromRGB(220,100,100)
    cl.Font=Enum.Font.GothamBold
    Instance.new("UICorner",cl).CornerRadius=UDim.new(0,6)
    cl.MouseButton1Click:Connect(function() fg:Destroy() end)
    local fl=Instance.new("ScrollingFrame",fr)
    fl.Size=UDim2.new(1,-12,1,-46)
    fl.Position=UDim2.new(0,6,0,38)
    fl.BackgroundTransparency=1
    fl.ScrollBarThickness=3
    fl.CanvasSize=UDim2.new(0,0,0,0)
    fl.AutomaticCanvasSize=Enum.AutomaticSize.Y
    local flay=Instance.new("UIListLayout",fl)
    flay.Padding=UDim.new(0,3)
    for _,p in pairs(P:GetPlayers()) do
        if p~=L then
            local pb=Instance.new("TextButton",fl)
            pb.Size=UDim2.new(1,-4,0,26)
            pb.BackgroundColor3=Color3.fromRGB(30,30,36)
            pb.Text="  "..p.Name.."  ("..role(p)..")"
            pb.TextColor3=RC[role(p)] or Color3.fromRGB(200,200,210)
            pb.Font=Enum.Font.Gotham
            pb.TextSize=10
            pb.TextXAlignment=Enum.TextXAlignment.Left
            Instance.new("UICorner",pb).CornerRadius=UDim.new(0,6)
            pb.MouseButton1Click:Connect(function()
                cfg.FLT=p
                fg:Destroy()
            end)
        end
    end
end)

S(Vis,"ESP")
T(Vis,"Player ESP",false,function(v) cfg.ESP=v end)

S(Vis,"SCREEN")
T(Vis,"Crosshair",false,function(v) cfg.CROSS=v end)
T(Vis,"Invisible",false,function(v) cfg.INV=v end)

S(Mov,"SPEED")
Sl(Mov,"WalkSpeed",16,300,20,function(v) cfg.SPD=v end)
Sl(Mov,"JumpPower",50,400,60,function(v) cfg.JMP=v end)
T(Mov,"Inf Jump",false,function(v) cfg.INFJUMP=v end)

S(Mov,"FLY")
T(Mov,"Fly",false,function(v) cfg.FLY=v end)
Sl(Mov,"Fly Speed",20,200,60,function(v) cfg.FLYSPD=v end)
T(Mov,"Noclip",false,function(v) cfg.NOC=v end)

S(Far,"AUTO FARM")
T(Far,"Auto Farm",false,function(v) cfg.AFARM=v end)
Sl(Far,"Speed",1,5,2,function(v) cfg.AFSPD=v end)

S(Mis,"UTILITY")
T(Mis,"Anti-AFK",false,function(v) cfg.ANTIAFK=v end)
T(Mis,"Hitbox Expander",false,function(v) cfg.HITBOX=v end)
Sl(Mis,"Hitbox Size",2,15,3,function(v) cfg.HBS=v end)
T(Mis,"SpinBot",false,function(v) cfg.SPIN=v end)

tabs["Combat"].B.BackgroundColor3=Color3.fromRGB(45,45,55)
tabs["Combat"].B.TextColor3=Color3.fromRGB(230,230,240)
tabs["Combat"].F.Visible=true

local EO={}
R.RenderStepped:Connect(function()
    if cfg.ESP then
        for _,p in pairs(P:GetPlayers()) do
            if p~=L and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local d=(p.Character.HumanoidRootPart.Position-L.Character.HumanoidRootPart.Position).Magnitude
                if d<=1500 and not EO[p] then
                    local h=Instance.new("Highlight",p.Character)
                    h.FillColor=RC[role(p)] or RC["?"]
                    h.OutlineColor=Color3.new(1,1,1)
                    h.FillTransparency=0.5
                    EO[p]=h
                end
            end
        end
    else
        for p,h in pairs(EO) do h:Destroy(); EO[p]=nil end
    end
end)

R.RenderStepped:Connect(function()
    if cfg.AIM then
        local cl,sh=nil,cfg.HFOV
        for _,p in pairs(P:GetPlayers()) do
            if p~=L and p.Character and p.Character:FindFirstChild("Head") then
                if cfg.HMURD and role(p)~="Murderer" then continue end
                local pos,on=C:WorldToViewportPoint(p.Character.Head.Position)
                if on then
                    local mo=U:GetMouseLocation()
                    local d=(Vector2.new(pos.X,pos.Y)-mo).Magnitude
                    if d<sh then sh=d; cl=p.Character.Head end
                end
            end
        end
        if cl then C.CFrame=C.CFrame:Lerp(CFrame.new(C.CFrame.Position,cl.Position),cfg.HSM) end
    end
end)

R.Heartbeat:Connect(function()
    if L.Character and L.Character:FindFirstChildOfClass("Humanoid") then
        L.Character.Humanoid.WalkSpeed=cfg.SPD
        L.Character.Humanoid.JumpPower=cfg.JMP
        if cfg.GOD then L.Character.Humanoid.Health=L.Character.Humanoid.MaxHealth end
        if cfg.SPIN then L.Character.HumanoidRootPart.CFrame=L.Character.HumanoidRootPart.CFrame*CFrame.Angles(0,math.rad(30),0) end
    end
end)

U.JumpRequest:Connect(function()
    if cfg.INFJUMP and L.Character then L.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

R.RenderStepped:Connect(function()
    if cfg.FLY and L.Character and L.Character:FindFirstChild("HumanoidRootPart") then
        local mv=Vector3.new()
        if U:IsKeyDown(Enum.KeyCode.W) then mv+=C.CFrame.LookVector end
        if U:IsKeyDown(Enum.KeyCode.S) then mv-=C.CFrame.LookVector end
        if U:IsKeyDown(Enum.KeyCode.A) then mv-=C.CFrame.RightVector end
        if U:IsKeyDown(Enum.KeyCode.D) then mv+=C.CFrame.RightVector end
        if U:IsKeyDown(Enum.KeyCode.Space) then mv+=Vector3.new(0,1,0) end
        L.Character.HumanoidRootPart.Velocity=mv*cfg.FLYSPD
    end
end)

R.Heartbeat:Connect(function()
    if L.Character then
        for _,pt in pairs(L.Character:GetDescendants()) do
            if pt:IsA("BasePart") and pt.Name~="HumanoidRootPart" then pt.Transparency=cfg.INV and 1 or 0 end
            if pt:IsA("Decal") then pt.Transparency=cfg.INV and 1 or 0 end
        end
    end
end)

R.Stepped:Connect(function()
    if cfg.NOC and L.Character then
        for _,pt in pairs(L.Character:GetDescendants()) do
            if pt:IsA("BasePart") then pt.CanCollide=false end
        end
    end
end)

R.Heartbeat:Connect(function()
    if cfg.ADODGE and L.Character then
        for _,p in pairs(P:GetPlayers()) do
            if p~=L and p.Character and role(p)=="Murderer" then
                local d=(p.Character.HumanoidRootPart.Position-L.Character.HumanoidRootPart.Position).Magnitude
                if d<25 then
                    local dir=(L.Character.HumanoidRootPart.Position-p.Character.HumanoidRootPart.Position).Unit
                    L.Character.HumanoidRootPart.Velocity=Vector3.new(dir.X*120,40,dir.Z*120)
                end
            end
        end
    end
end)

R.Heartbeat:Connect(function()
    if cfg.HITBOX then
        for _,p in pairs(P:GetPlayers()) do
            if p~=L and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                p.Character.HumanoidRootPart.Size=Vector3.new(cfg.HBS,cfg.HBS,cfg.HBS)
                p.Character.HumanoidRootPart.Transparency=0.7
            end
        end
    end
end)

task.spawn(function()
    while task.wait(cfg.AFSPD) do
        if cfg.AFARM and L.Character then
            for _,o in pairs(workspace:GetDescendants()) do
                if o:IsA("BasePart") and (o.Name=="Coin" or o.Name:lower():find("coin")) then
                    pcall(function() L.Character.HumanoidRootPart.CFrame=o.CFrame+Vector3.new(0,2,0) end)
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.3) do
        if cfg.AWIN and L.Character and role(L)=="Sheriff" then
            for _,p in pairs(P:GetPlayers()) do
                if p~=L and p.Character and role(p)=="Murderer" then
                    local t=L.Character:FindFirstChildOfClass("Tool")
                    if t then pcall(function() t:Activate() end) end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.5) do
        if cfg.KILLALL and L.Character and role(L)=="Murderer" then
            local t=L.Character:FindFirstChildOfClass("Tool")
            if t then
                for _,p in pairs(P:GetPlayers()) do
                    if p~=L and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        L.Character.HumanoidRootPart.CFrame=p.Character.HumanoidRootPart.CFrame*CFrame.new(0,0,2)
                        pcall(function() t:Activate() end)
                        task.wait(0.1)
                    end
                end
            end
        end
    end
end)

R.Heartbeat:Connect(function()
    if cfg.FLING and cfg.FLT and cfg.FLT.Character and cfg.FLT.Character:FindFirstChild("HumanoidRootPart") then
        local tr=cfg.FLT.Character.HumanoidRootPart
        local v=Instance.new("BodyAngularVelocity",tr)
        v.AngularVelocity=Vector3.new(math.random(-500,500),math.random(-500,500),math.random(-500,500))
        v.MaxTorque=Vector3.new(math.huge,math.huge,math.huge)
        task.wait(0.1)
        v:Destroy()
    end
end)

L.Idled:Connect(function()
    if cfg.ANTIAFK then
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end
end)

print("⚡ TOLA HUB загружен!")
