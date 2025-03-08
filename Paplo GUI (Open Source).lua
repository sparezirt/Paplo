local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Paplo Forsaken [BETA]",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Paplo Script Very Op",
   LoadingSubtitle = "Loading..",
   Theme = "Amber Glow", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "IgnoreThis"
   },

   Discord = {
      Enabled = false, -- Prompt the user to join your Discord server if their executor supports it
      Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ ABCD would be ABCD
      RememberJoins = true -- Set this to false to make them join the discord every time they load it up
   },

   KeySystem = true, -- Set this to true to use our key system
   KeySettings = {
      Title = "Paplo Keysystem",
      Subtitle = "Join Discord (Later)",
      Note = "No key as of now, password is key", -- Use this to tell the user how to get a key
      FileName = "PaploKey", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"key"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})


local Tab = Window:CreateTab("ESP") -- Title, Image

local Section = Tab:CreateSection("It's over, i just got wallhacks!")

local Button = Tab:CreateButton({
   Name = "Killer ESP",
   Callback = function()
Rayfield:Notify({
   Title = "Killer ESP Activated.",
   Content = "The killer is Now highlighted, Watch out for them🤨",
   Duration = 2,
   Image = 0,
})

local Players = game.Workspace:WaitForChild("Players")
local RunService = game:GetService("RunService")
local function createOutlineESP(model, outlineColor, fillColor)
    local highlight = model:FindFirstChild("Highlight")
    if not highlight then
        highlight = Instance.new("Highlight")
        highlight.Parent = model
        highlight.Adornee = model
    end
    highlight.FillTransparency = 0.75
    highlight.FillColor = fillColor
    highlight.OutlineColor = outlineColor
    highlight.OutlineTransparency = 0
end
local function createBillboardGui(target, text, color)
    local billboardGui = target:FindFirstChildOfClass("BillboardGui")
    if not billboardGui then
        billboardGui = Instance.new("BillboardGui")
        billboardGui.Adornee = target
        billboardGui.Size = UDim2.new(0, 100, 0, 25)
        billboardGui.AlwaysOnTop = true
        billboardGui.Parent = target.Parent
        billboardGui.StudsOffset = Vector3.new(0, 2, 0) 
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextScaled = true
        textLabel.TextColor3 = color
        textLabel.Text = text
        textLabel.Font = Enum.Font.Antique
        textLabel.Parent = billboardGui
    else
        billboardGui.TextLabel.Text = text
        billboardGui.TextLabel.TextColor3 = color
        billboardGui.TextLabel.Font = Enum.Font.Antique
        billboardGui.StudsOffset = Vector3.new(0, 2, 0)  -- Apply offset even if BillboardGui already exists
    end
end
local function applyHighlighting(model)
    local humanoid = model:FindFirstChildOfClass("Humanoid")
    if humanoid and model:FindFirstChild("HumanoidRootPart") then
        createOutlineESP(model, Color3.fromRGB(128, 0, 0), Color3.fromRGB(64, 0, 0))  -- Dark red colors
        createBillboardGui(model:FindFirstChild("HumanoidRootPart"), model.Name, Color3.fromRGB(128, 0, 0))  -- Dark red color
    end
end
local function highlightKillers()
    local killersGroup = Players:FindFirstChild("Killers")
    if killersGroup then
        for _, killer in pairs(killersGroup:GetChildren()) do
            applyHighlighting(killer)
        end
    end
end
highlightKillers()
Players.DescendantAdded:Connect(function(descendant)
    if descendant.Parent and descendant.Parent.Name == "Killers" then
        applyHighlighting(descendant)
    end
end)
Players.DescendantRemoving:Connect(function(descendant)
    if descendant:IsA("Model") and descendant.Name == "Killers" then
        descendant.AncestryChanged:Connect(function(_, parent)
            if parent then
                applyHighlighting(descendant)
            end
        end)
    end
end)
   end,
})

local Button = Tab:CreateButton({
   Name = "Generator ESP",
   Callback = function()
   Rayfield:Notify({
   Title = "Generator ESP Activated.",
   Content = "Generator Highlighted, Fix em while you can :)",
   Duration = 2,
   Image = 0,
})
   local function createOutline(item)
    local Highlight = Instance.new('Highlight')
    Highlight.Parent = item
    Highlight.Adornee = item
    Highlight.OutlineColor = Color3.new(255, 255, 0)
    Highlight.FillColor = Color3.new(0, 0, 0)
    Highlight.FillTransparency = 0.5
end
local function applyESP(item)
    if item:IsA('Model') and item.Name == 'Generator' then
        createOutline(item)
    end
end
for _, v in ipairs(game.Workspace:GetDescendants()) do
    applyESP(v)
end
game.Workspace.DescendantAdded:Connect(function(descendant)
    applyESP(descendant)
end)
game.Workspace.DescendantRemoving:Connect(function(descendant)
    if descendant:IsA('Highlight') then
        descendant:Destroy()
    end
end)
   end,
})

local Button = Tab:CreateButton({
    Name = "Player ESP",
    Callback = function()
        Rayfield:Notify({
            Title = "Player ESP Activated.",
            Content = "All players highlighted.",
            Duration = 2,
            Image = 0,
        })
        local PlayersService = game:GetService("Players")

local function createESP(model, outlineCol, fillCol)
    if model and not model:FindFirstChildOfClass("Highlight") then
        local hl = Instance.new("Highlight")
        hl.Parent = model
        hl.Adornee = model
        hl.FillTransparency = 0.75
        hl.FillColor = fillCol
        hl.OutlineColor = outlineCol
        hl.OutlineTransparency = 0
    end
end

local function createHealthUI(character, textCol)
    local head = character:FindFirstChild("Head")
    if head and not head:FindFirstChild("HealthGui") then
        local healthGui = Instance.new("BillboardGui")
        healthGui.Name = "HealthGui"
        healthGui.Size = UDim2.new(0, 100, 0, 30)
        healthGui.AlwaysOnTop = true
        healthGui.MaxDistance = math.huge
        healthGui.Parent = head

        local healthLabel = Instance.new("TextLabel")
        healthLabel.Size = UDim2.new(1, 0, 1, 0)
        healthLabel.BackgroundTransparency = 1
        healthLabel.TextScaled = true
        healthLabel.Text = ""
        healthLabel.TextColor3 = textCol
        healthLabel.Font = Enum.Font.Antique
        healthLabel.Parent = healthGui
    end
end

local function updateHealthUI()
    for _, player in ipairs(PlayersService:GetPlayers()) do
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local head = character:FindFirstChild("Head")
            if humanoid and head then
                local textCol = humanoid.MaxHealth > 500 and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(255, 255, 255)
                createHealthUI(character, textCol)

                local healthGui = head:FindFirstChild("HealthGui")
                if healthGui then
                    local healthLabel = healthGui:FindFirstChildOfClass("TextLabel")
                    if healthLabel then
                        healthLabel.Text = math.floor(humanoid.Health) .. "/" .. humanoid.MaxHealth
                        healthLabel.TextColor3 = textCol
                    end
                end
            end
        end
    end
end

local function applyESP()
    for _, player in ipairs(PlayersService:GetPlayers()) do
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                local fillCol = Color3.fromRGB(128, 128, 128)
                local outlineCol = Color3.fromRGB(255, 255, 255)

                createESP(character, outlineCol, fillCol)
                createHealthUI(character, outlineCol)
            end
        end
    end
end

applyESP()

PlayersService.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        wait(1)
        applyESP()
    end)
end)

PlayersService.PlayerRemoving:Connect(function(player)
    local character = player.Character
    if character then
        local hl = character:FindFirstChildOfClass("Highlight")
        if hl then
            hl:Destroy()
        end

        local head = character:FindFirstChild("Head")
        if head then
            local healthGui = head:FindFirstChild("HealthGui")
            if healthGui then
                healthGui:Destroy()
            end
        end
    end
end)

while true do
    applyESP()
    updateHealthUI()
    wait(3)
end
    end,
})

local Button = Tab:CreateButton({
   Name = "Items ESP",
   Callback = function()
   Rayfield:Notify({
   Title = "Esp Items Is Activated.",
   Content = "Items highlighted, Go take some💊",
   Duration = 3,
   Image = 0,
})
   local Workspace = game:GetService("Workspace")

local function createHighlight(model, outlineColor, fillColor)
    if model and not model:FindFirstChildOfClass("Highlight") then
        local highlight = Instance.new("Highlight")
        highlight.Parent = model
        highlight.Adornee = model
        highlight.FillTransparency = 0.75
        highlight.FillColor = fillColor
        highlight.OutlineColor = outlineColor
        highlight.OutlineTransparency = 0
    end
end

local function createBillboardGui(target, text, color)
    if target and not target:FindFirstChildOfClass("BillboardGui") then
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Adornee = target
        billboardGui.Size = UDim2.new(0, 100, 0, 25)
        billboardGui.AlwaysOnTop = true
        billboardGui.Parent = target

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextScaled = true
        textLabel.TextColor3 = color
        textLabel.Text = text
        textLabel.Font = Enum.Font.Antique  -- Set the font to Antique
        textLabel.Parent = billboardGui
    end
end

local function applyHighlighting(item)
    local targetPart = item:IsA("Model") and item:FindFirstChildWhichIsA("BasePart")
    if targetPart then
        local color
        if item.Name == "BloxyCola" then
            color = Color3.fromRGB(102, 204, 0)  -- Green
        elseif item.Name == "Medkit" then
            color = Color3.fromRGB(102, 204, 0)  -- Green
        else
            return  -- Skip other items
        end
        createHighlight(targetPart, color, color)
        createBillboardGui(targetPart, item.Name, color)
    end
end

local function highlightItems()
    for _, item in pairs(Workspace:GetDescendants()) do
        if item:IsA("Model") and (item.Name == "BloxyCola" or item.Name == "Medkit") then
            applyHighlighting(item)
        end
    end
end

-- Initial application of highlighting to existing items
highlightItems()

-- Event listener for new items
Workspace.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("Model") and (descendant.Name == "BloxyCola" or descendant.Name == "Medkit") then
        wait(1)  -- Give time for the item to fully load
        applyHighlighting(descendant)
    end
end)

-- Event listener for removing highlighting when items are removed
Workspace.DescendantRemoving:Connect(function(descendant)
    if descendant:IsA("Model") then
        local highlight = descendant:FindFirstChildOfClass("Highlight")
        if highlight then
            highlight:Destroy()
        end

        local billboardGui = descendant:FindFirstChildOfClass("BillboardGui")
        if billboardGui then
            billboardGui:Destroy()
        end
    end
end)
   end,
})

local Tab = Window:CreateTab("Gen") 

local Button = Tab:CreateButton({
   Name = "Delayed Auto fix generator (10 Second Delay)",
   Callback = function()
   Rayfield:Notify({
   Title = "Delayed Auto-fix generator Activated",
   Content = "You'll need to Re-Execute it Every round, Muahahaha🦅",
   Duration = 3,
   Image = 0,
})
   while true do
for i, v in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
    if v.Name == "Generator" then
        v:WaitForChild("Remotes"):WaitForChild("RE"):FireServer()
    end
end
wait(10)
end
   end,
})

local Button = Tab:CreateButtom({
   Name = "Delayed Auto fix generator (5 Second Delay)",
   Callback = function()
   Rayfield:Notify({
   Title = "Delayed Auto-fix generator Activated",
   Content = "You will need to Re-execute it Every round.",
   Duration = 3,
   Image = 0,
})
   while true do
for i, v in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
    if v.Name == "Generator" then
        v:WaitForChild("Remotes"):WaitForChild("RE"):FireServer()
    end
end
wait(5)
end
   end,
})

local Input = Tab:CreateInput({
    Name = "Custom Generator Delay Time",
    CurrentValue = "",
    PlaceholderText = "Insert Delay Time (Seconds)",
    RemoveTextAfterFocusLost = false,
    Flag = "InputGeneratorCustom",
    Callback = function(Text)
        Rayfield:Notify({
            Title = "Custom Delay Time Set",
            Content = "Custom Delay Time set to " .. Text,
            Duration = 3,
            Image = 0,
        })
        while true do
            for i, v in pairs(game.Workspace.Map.Ingame.Map:GetChildren()) do
                if v.Name == "Generator" then
                    v:WaitForChild("Remotes"):WaitForChild("RE"):FireServer()
                end
            end
            wait(Text)
        end
    end,
})

local Button = Window:CreateButton("Aimbot")

local Toggle = Tab:CreateToggle({
   Name = "1x1x1x1 Mass Infection",
   Callback = function()
   Rayfield:Notify({
   Title = "Mass infection Aimbot Is Activated",
   Content = "Use 1x1x1x1 For this to Function correctly. Make some damage vro😂",
   Duration = 2,
   Image = 0,
})
   local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camlockEnabled = false
local targetPlayer = nil

function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local playerPosition = player.Character and player.Character:FindFirstChild("HumanoidRootPart").Position

    if playerPosition then
        for _, otherPlayer in ipairs(game:GetService("Players"):GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local otherPlayerPosition = otherPlayer.Character.HumanoidRootPart.Position
                local distance = (otherPlayerPosition - playerPosition).Magnitude
                if distance < shortestDistance then
                    closestPlayer = otherPlayer
                    shortestDistance = distance
                end
            end
        end
    end
    return closestPlayer
end

function enableCamlockForDuration()
    targetPlayer = getClosestPlayer()
    if targetPlayer then
        camlockEnabled = true
        delay(2, function()
            camlockEnabled = false
            targetPlayer = nil
        end)
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if camlockEnabled and targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, targetPlayer.Character.HumanoidRootPart.Position)
    end
end)

local playerGui = player:WaitForChild("PlayerGui")
local mainUI = playerGui:WaitForChild("MainUI")
local abilityContainer = mainUI:WaitForChild("AbilityContainer")
local massInfectionButton = abilityContainer:WaitForChild("MassInfection")

local function onMassInfectionButtonPressed()
    enableCamlockForDuration()
end

massInfectionButton.Activated:Connect(onMassInfectionButtonPressed)
   end,
})

local Button = Tab:CreateButton({
   Name = "1x1x1x1 Entanglement",
   Callback = function()
   Rayfield:Notify({
   Title = "Entanglement Aimbot Is Activated.",
   Content = "Use 1x1x1x1 For this to Function correctly, skill issue tbh😔",
   Duration = 2,
   Image = 0,
})
   local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camlockEnabled = false
local targetPlayer = nil

function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge
    local playerPosition = player.Character and player.Character:FindFirstChild("HumanoidRootPart").Position

    if playerPosition then
        for _, otherPlayer in ipairs(game:GetService("Players"):GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local otherPlayerPosition = otherPlayer.Character.HumanoidRootPart.Position
                local distance = (otherPlayerPosition - playerPosition).Magnitude
                if distance < shortestDistance then
                    closestPlayer = otherPlayer
                    shortestDistance = distance
                end
            end
        end
    end
    return closestPlayer
end

function enableCamlockForDuration()
    targetPlayer = getClosestPlayer()
    if targetPlayer then
        camlockEnabled = true
        delay(2, function()
            camlockEnabled = false
            targetPlayer = nil
        end)
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if camlockEnabled and targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, targetPlayer.Character.HumanoidRootPart.Position)
    end
end)

local playerGui = player:WaitForChild("PlayerGui")
local mainUI = playerGui:WaitForChild("MainUI")
local abilityContainer = mainUI:WaitForChild("AbilityContainer")
local entanglementButton = abilityContainer:WaitForChild("Entanglement")

local function onEntanglementButtonPressed()
    enableCamlockForDuration()
end

entanglementButton.Activated:Connect(onEntanglementButtonPressed)
   end,
})

local Button = Tab:CreateButton({
   Name = "Dusekkar Aimbot (Switchable)",
   Callback = function()
   Rayfield:Notify({
   Title = "Dusekkar Aimbot Is Activated.",
   Content = "Use Dusekkar for this to work, Snipe em! (Dont use in lobby, doesnt work.)",
   Duration = 2,
   Image = 0,
})
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local toggleButton = Instance.new("TextButton")
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 200, 0, 50)  -- Width: 200 pixels, Height: 50 pixels
toggleButton.Position = UDim2.new(0.5, 150, 0.5, -200)  -- Centered on the screen
toggleButton.Text = "Choose Target"
toggleButton.BackgroundColor3 = Color3.fromRGB(30, 144, 255)  -- Initial color: Dodger Blue
toggleButton.TextColor3 = Color3.new(1, 1, 1)  -- White text
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 24
local sayHello = true
local survivorCamlockEnabled = false
local killerCamlockEnabled = false
local survivorConnection
local killerConnection
toggleButton.MouseButton1Click:Connect(function()
    local player = game.Players.LocalPlayer
    local mouse = player:GetMouse()
    if survivorConnection then
        survivorConnection:Disconnect()
        survivorCamlockEnabled = false
    end
    if killerConnection then
        killerConnection:Disconnect()
        killerCamlockEnabled = false
    end
    if sayHello then
        local targetPlayer = nil
        function getClosestPlayer()
            local closestPlayer = nil
            local closestDistance = math.huge
            local camera = workspace.CurrentCamera
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local screenPosition, onScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                    if onScreen then
                        local distance = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(screenPosition.X, screenPosition.Y)).magnitude
                        if distance < closestDistance then
                            closestDistance = distance
                            closestPlayer = v
                        end
                    end
                end
            end
            return closestPlayer
        end
        function enableSurvivorCamlockForDuration()
            targetPlayer = getClosestPlayer()
            if targetPlayer then
                survivorCamlockEnabled = true
                delay(2, function()
                    survivorCamlockEnabled = false
                    targetPlayer = nil
                end)
            end
        end
        survivorConnection = game:GetService("RunService").RenderStepped:Connect(function()
            if survivorCamlockEnabled and targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, targetPlayer.Character.HumanoidRootPart.Position)
            end
        end)
        local playerGui = player:WaitForChild("PlayerGui")
        local mainUI = playerGui:WaitForChild("MainUI")
        local abilityContainer = mainUI:WaitForChild("AbilityContainer")
        local plasmaBeamButton = abilityContainer:WaitForChild("PlasmaBeam")
        local function onPlasmaBeamButtonPressed()
            enableSurvivorCamlockForDuration()
        end
        plasmaBeamButton.Activated:Connect(onPlasmaBeamButtonPressed)
        toggleButton.Text = "Target: Survivors"
        toggleButton.BackgroundColor3 = Color3.fromRGB(34, 139, 34)  -- Green color for Survivors
    else
        local targetObject = nil
        function getTargetObject()
            local killersFolder = workspace:WaitForChild("Players"):WaitForChild("Killers")
            local closestObject = nil
            local closestDistance = math.huge
            for _, v in pairs(killersFolder:GetChildren()) do
                if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
                    local screenPosition = workspace.CurrentCamera:WorldToScreenPoint(v.HumanoidRootPart.Position)
                    local distance = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(screenPosition.X, screenPosition.Y)).magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestObject = v
                    end
                end
            end
            return closestObject
        end
        function enableKillerCamlockForDuration()
            targetObject = getTargetObject()
            if targetObject then
                killerCamlockEnabled = true
                delay(2, function()
                    killerCamlockEnabled = false
                    targetObject = nil
                end)
            end
        end
        killerConnection = game:GetService("RunService").RenderStepped:Connect(function()
            if killerCamlockEnabled and targetObject and targetObject:FindFirstChild("HumanoidRootPart") then
                workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, targetObject.HumanoidRootPart.Position)
            end
        end)
        local playerGui = player:WaitForChild("PlayerGui")
        local mainUI = playerGui:WaitForChild("MainUI")
        local abilityContainer = mainUI:WaitForChild("AbilityContainer")
        local plasmaBeamButton = abilityContainer:WaitForChild("PlasmaBeam")
        local function onPlasmaBeamButtonPressed()
            enableKillerCamlockForDuration()
        end
        plasmaBeamButton.Activated:Connect(onPlasmaBeamButtonPressed)
        toggleButton.Text = "Target: Killer"
        toggleButton.BackgroundColor3 = Color3.fromRGB(220, 0, 0)  -- Crimson color for Killer
    end
    sayHello = not sayHello  -- Toggle the state
end)
   end,
})

local Button = Tab:CreateButton({
   Name = "Chance Aimbot (Use Shiftlock/First Person)",
   Callback = function()
   Rayfield:Notify({
   Title = "Chance Aimbot Is Activated.",
   Content = "Use chance for This to work, Obviously🤨",
   Duration = 2,
   Image = 0,
})

   local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local camlockEnabled = false
local targetObject = nil

function getTargetObject()
    local killersFolder = workspace:WaitForChild("Players"):WaitForChild("Killers")
    local closestObject = nil
    local closestDistance = math.huge
    for _, v in pairs(killersFolder:GetChildren()) do
        if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
            local screenPosition = workspace.CurrentCamera:WorldToScreenPoint(v.HumanoidRootPart.Position)
            local distance = (Vector2.new(mouse.X, mouse.Y) - Vector2.new(screenPosition.X, screenPosition.Y)).magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestObject = v
            end
        end
    end
    return closestObject
end

function enableCamlockForDuration()
    targetObject = getTargetObject()
    if targetObject then
        camlockEnabled = true
        delay(2, function()
            camlockEnabled = false
            targetObject = nil
        end)
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if camlockEnabled and targetObject and targetObject:FindFirstChild("HumanoidRootPart") then
        workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, targetObject.HumanoidRootPart.Position)
    end
end)

local playerGui = player:WaitForChild("PlayerGui")
local mainUI = playerGui:WaitForChild("MainUI")
local abilityContainer = mainUI:WaitForChild("AbilityContainer")
local shootButton = abilityContainer:WaitForChild("Shoot")

local function onShootButtonPressed()
    enableCamlockForDuration()
end

shootButton.Activated:Connect(onShootButtonPressed)
   end,
})

local Tab = Window:CreateTab("Misc")

local Button = Tab:CreateButton({
   Name = "Fullbright (OP)",
   Callback = function()
   Rayfield:Notify({
   Title = "Fullbright Is Activated.",
   Content = "Everything is Now Pretty Visible, Hooray!",
   Duration = 2,
   Image = 0,
})
game:GetService("Lighting").Brightness = 0.7
game:GetService("Lighting").Ambient = Color3.new(0.75, 0.75, 0.75)
game:GetService("Lighting").OutdoorAmbient = Color3.new(0.75, 0.75, 0.75)
game:GetService("Lighting").GlobalShadows = false
game:GetService("Lighting").FogEnd = 100000
   end,
})

local Button = Tab:CreateButton({
    Name = "Remove Slowness effect",
    Callback = function()
        Rayfield:Notify({
            Title = "Slowness Effect Removed.",
            Content = " ",
            Duration = 6.5,
            Image = 0,
        })
        game:GetService("ReplicatedStorage").Modules.StatusEffects.Slowness:Destroy()
    end,
})

local Button = Tab:CreateButton({
   Name = "Remove Blindness effect",
   Callback = function()
   Rayfield:Notify({
   Title = "Blindness effect Removed.",
   Content = " ",
   Duration = 2,
   Image = 0,
})
   game:GetService("ReplicatedStorage").Modules.StatusEffects.Blindness:Destroy()
   end,
})

local Toggle = Tab:CreateToggle({
	Name = "Auto 1x1x1x1 Popup",
	CurrentValue = false,
	Flag = "Toggle1x1Popupboi", -- Ensure every element has a different flag if you're using configuration saving to avoid overlaps
	Callback = function(Value)
		local VIM = game:GetService("VirtualInputManager")
		local running = true
		
		local function runScript()
			while running do
				local player = game:GetService("Players").LocalPlayer
				local popups = player.PlayerGui.TemporaryUI:GetChildren()

				for _, i in ipairs(popups) do
					if i.Name == "1x1x1x1Popup" then
						local centerX = i.AbsolutePosition.X + (i.AbsoluteSize.X / 2)
						local centerY = i.AbsolutePosition.Y + (i.AbsoluteSize.Y / 2) + 50
						VIM:SendMouseButtonEvent(
							centerX,
							centerY,
							Enum.UserInputType.MouseButton1.Value,
							true,
							player.PlayerGui,
							1
						)
						VIM:SendMouseButtonEvent(
							centerX,
							centerY,
							Enum.UserInputType.MouseButton1.Value,
							false,
							player.PlayerGui,
							1
						)
					end
				end
				task.wait(0.1)
			end
		end
		
		if Value then
			running = true
			spawn(runScript)
		else
			running = false
		end
	end,
})

local Button = Tab:CreateButton({
   Name = "Infinite Stamina",
   CurrentValue = false,
   Flag = "Toggleinfinitestamina", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
   Callback = function(Value)
        stam = Value
        local stamscript = require(game.ReplicatedStorage.Systems.Character.Game.Sprinting)

        local connection
        connection = game:GetService("RunService").Heartbeat:Connect(function()
            if not stam then
                connection:Disconnect()
                stamscript.StaminaLossDisabled = nil
                return
            end
            stamscript.StaminaLossDisabled = function() 
            end
        end)
   end,
})

local Tab = Window:CreateTab("Credits")

local Label = Tab:CreateLabel("Credit to uhh i forgor💀💀💀 (probably sonixdev on discord yasuf community prob prob😂)", 0, Color3.fromRGB(90, 90, 90), false) -- Title, Icon, Color, IgnoreTheme
