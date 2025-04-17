local player = game.Players.LocalPlayer
local camera = game.Workspace.CurrentCamera

local function optimizeRenderDistance()
    for _, part in pairs(workspace:GetChildren()) do
        if part:IsA("BasePart") and (part.Position - camera.CFrame.Position).Magnitude > 500 then
            part:Destroy()
        end
    end
end

local function teleportToPosition(x, y, z)
    local character = player.Character or player.CharacterAdded:Wait()
    if character then
        local targetPosition = Vector3.new(x, y, z)
        character:SetPrimaryPartCFrame(CFrame.new(targetPosition))
    end
end

local function createUI()
    local screenGui = Instance.new("ScreenGui", player.PlayerGui)
    screenGui.Name = "OptimizationUI"

    local frame = Instance.new("Frame", screenGui)
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    frame.BackgroundTransparency = 0.6

    local maximizeButton = Instance.new("TextButton", frame)
    maximizeButton.Size = UDim2.new(0, 30, 0, 30)
    maximizeButton.Position = UDim2.new(0, 10, 0, 10)
    maximizeButton.Text = "+"
    maximizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    maximizeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    maximizeButton.BackgroundTransparency = 0.6

    local minimizeButton = Instance.new("TextButton", frame)
    minimizeButton.Size = UDim2.new(0, 30, 0, 30)
    minimizeButton.Position = UDim2.new(0, 50, 0, 10)
    minimizeButton.Text = "-"
    minimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    minimizeButton.BackgroundTransparency = 0.6

    local optimizeToggleButton = Instance.new("TextButton", frame)
    optimizeToggleButton.Size = UDim2.new(0, 260, 0, 30)
    optimizeToggleButton.Position = UDim2.new(0, 10, 0, 50)
    optimizeToggleButton.Text = "Ligar Otimização de Renderização"
    optimizeToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    optimizeToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    optimizeToggleButton.BackgroundTransparency = 0.6
    local optimizeEnabled = true

    optimizeToggleButton.MouseButton1Click:Connect(function()
        if optimizeEnabled then
            optimizeRenderDistance()
            optimizeToggleButton.Text = "Desligar Otimização de Renderização"
        else
            optimizeToggleButton.Text = "Ligar Otimização de Renderização"
        end
        optimizeEnabled = not optimizeEnabled
    end)

    local teleportButton = Instance.new("TextButton", frame)
    teleportButton.Size = UDim2.new(0, 260, 0, 30)
    teleportButton.Position = UDim2.new(0, 10, 0, 90)
    teleportButton.Text = "Ligar Teleportação"
    teleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    teleportButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    teleportButton.BackgroundTransparency = 0.6
    local teleportEnabled = false

    teleportButton.MouseButton1Click:Connect(function()
        if teleportEnabled then
            teleportToPosition(0, 50, 0)
            teleportButton.Text = "Desligar Teleportação"
        else
            teleportButton.Text = "Ligar Teleportação"
        end
        teleportEnabled = not teleportEnabled
    end)

    maximizeButton.MouseButton1Click:Connect(function()
        frame.Size = UDim2.new(0, 300, 0, 300)
        maximizeButton.Visible = false
        minimizeButton.Visible = true
    end)

    minimizeButton.MouseButton1Click:Connect(function()
        frame.Size = UDim2.new(0, 300, 0, 150)
        minimizeButton.Visible = false
        maximizeButton.Visible = true
    end)

    minimizeButton.Visible = false
end

createUI()
