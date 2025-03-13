local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Paplo Hub",
   Icon = 0, -- Icon in Topbar. Can use Lucide Icons (string) or Roblox Image (number). 0 to use no icon (default).
   LoadingTitle = "Paplo R:Corruption Script Very Op",
   LoadingSubtitle = "Loading..",
   Theme = "AmberGlow", -- Check https://docs.sirius.menu/rayfield/configuration/themes

   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, -- Prevents Rayfield from warning when the script has a version mismatch with the interface

   ConfigurationSaving = {
      Enabled = true, 
      FolderName = Robloxia:Corruption, -- Create a custom folder for your hub/game
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
      FileName = "PaploCorruptionKey", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
      SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
      GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
      Key = {"key"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
   }
})

local Tab = Window:CreateTab("Main") -- Title, Image

local Section = Tab:CreateSection("Misc")

local Button = Tab:CreateButton({
   local Toggle = Tab:CreateToggle({
   Name = "FullBright",
   CurrentValue = false,
   Flag = "Toggle1", 
   Callback = function(Value)
   Rayfield:Notify({
   Title = "Fullbright Is Activated.",
   Content = "Everything is Now Pretty Visible, Hooray!",
   Duration = 2,
   Image = 0,
})
game:GetService("Lighting").Brightness = 0
game:GetService("Lighting").Ambient = Color3.new(255, 255, 255)
game:GetService("Lighting").OutdoorAmbient = Color3.new(255, 255, 255)
game:GetService("Lighting").GlobalShadows = true
game:GetService("Lighting").ColorShift_Bottom = Color3.new(128, 128, 128) 
game:GetService("Lighting").ColorShift_Bottom = Color3.new(255, 255, 255)

game:GetService("Atmosphere").Density = 0.6
game:GetService("Atmosphere").Color = Color3.new(128, 128, 128)
game:GetService("Atmosphere").Decay = Color3.new(255, 255, 255) 

   end,
})

Local Tab = Window:CreateTab("Speed")

Local Section = Tab:CreateSection("Speed options")

Local Label = Tab:CreateLabel("WIP", 0, Color3.fromRGB(90, 90, 90), false)

Rayfield:LoadConfiguration()
