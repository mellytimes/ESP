local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local Runservice = game:GetService("RunService")

local espObject = {}

local function RemoveESP(player)
    if espObject[player] then
        espObject[player]:Remove()
        espObject[player] = nil
    end
end
local function createESP(player)
    local NameText = Drawing.new("Text")
    NameText.Size = 16
    NameText.Center = true
    NameText.Visible = true
    NameText.Color = Color3.fromRGB(255,0,255)
    espObject[player] = NameText
end

local function updateESP()
    for player,text in pairs(espObject) do
        local char = player.Character
        local head = char and char:FindFirstChild("Head")
        local humanoid = char and char:FindFirstChild("Humanoid")

        if char and head and humanoid and humanoid.Health > 0 then
            local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
            if onScreen then
                text.Postion = Vector2.new(screenPos.X,screenPos.Y)
                text.Text = player.Name
                text.Visible = true
            else
                text.Visible = false
            end
        else
            text.Visible = false
        end
    end
end
for i,v in pairs(Players:GetPlayers()) do
    if v ~= plr then
        createESP(v)
    end
end
Runservice.Heartbeat:Connect(updateESP)
Players.Heartbeat:Connect(createESP)
Players.Heartbeat:Connect(RemoveESP)
