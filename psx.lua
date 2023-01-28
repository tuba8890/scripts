-- VARIABLES
local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/UI-Interface/CustomFIeld/main/RayField.lua'))()
local Orbs = getsenv(game.Players.LocalPlayer.PlayerScripts.Scripts.Game.Orbs)
local Lootbags = getsenv(game.Players.LocalPlayer.PlayerScripts.Scripts.Game.Lootbags)
local WorldCmds = require(game:GetService("ReplicatedStorage").Library.Client.WorldCmds)
local FrameworkLibrary = require(game.ReplicatedStorage.Framework.Library)
local Client = require(game.ReplicatedStorage.Library.Client)
local strengthDeleteUnder = 1000

-- BYPASS ENVIRONMENT CHECK
debug.setupvalue(Client.Network.Invoke, 1, function() return true end)
debug.setupvalue(Client.Network.Fire, 1, function() return true end)

-- TABLES
local eggs = {}
for _, egg in ipairs(game.ReplicatedStorage.Game.Eggs:GetDescendants()) do
    if egg:IsA("ModuleScript") then
        if not table.find(eggs, egg.Name) then
            local eggConfig = require(egg)
            if eggConfig['hatchable'] then
                table.insert(eggs, egg.Name)
            end
        end 
    end
end

local eggsInfo = {}
for _, egg in ipairs(game.ReplicatedStorage.Game.Eggs:GetDescendants()) do
    if egg:IsA("ModuleScript") then
        local eggConfig = require(egg)
        if eggConfig['hatchable'] then
            eggConfigTable = {egg.Name, eggConfig.area, eggConfig.cost, eggConfig.currency}
            table.insert(eggsInfo, eggConfigTable)
        end
    end
end

local areas = {}
for _, areaScript in ipairs(game.ReplicatedStorage.Directory.Areas:GetDescendants()) do
    if areaScript:IsA("ModuleScript") then
        for i, val in pairs(require(areaScript)) do
            if val['hidden'] then break end;
            if not table.find(areas, val['name']) then
                table.insert(areas, val['name'])
            end
        end
    end
end


-- FUNCTIONS
function GetCoins(Area)
    local Coins = {}
    for i,v in next, Client.Network.Invoke('Get Coins') do 
        
        if v.a == Area then 
            Coins[i] = v
        end 
    end 
    return Coins
end 

function findPet(numberID)
    for _, child in ipairs(game:GetService("ReplicatedStorage").Game.Pets:GetChildren()) do
        if string.match(child.Name, "^"..numberID.." ") then
            for _, child2 in ipairs(child:GetChildren()) do
                if child2:IsA("ModuleScript") then
                    return require(child2)
                end
            end
        end
    end
end

function AutoDelete()
    task.spawn(function()
        while task.wait() do
            if not Rayfield.Flags.AutoDelete.CurrentValue then break end;
            local savedPets = FrameworkLibrary.Save.Get().Pets

            for i,v in pairs(savedPets) do 
                local petConfig = findPet(v.id)
        
                local petRarity = petConfig.rarity
                local petMaxStrength = petConfig.strengthMax

                if petRarity == "Basic" and Rayfield.Flags.AutoDeleteBasic.CurrentValue then
                    local args = {
                        [1] = {
                            [1] = v.uid
                        }
                    }
                    Client.Network.Invoke("Delete Several Pets", unpack(args))
                    
                elseif petRarity == "Rare" and Rayfield.Flags.AutoDeleteRare.CurrentValue then
                    local args = {
                        [1] = {
                            [1] = v.uid
                        }
                    }
                    Client.Network.Invoke("Delete Several Pets", unpack(args))
                elseif petRarity == "Epic" and Rayfield.Flags.AutoDeleteEpic.CurrentValue then
                    local args = {
                        [1] = {
                            [1] = v.uid
                        }
                    }
                    Client.Network.Invoke("Delete Several Pets", unpack(args))
                elseif petRarity == "Legendary" and Rayfield.Flags.AutoDeleteLegendary.CurrentValue then
                    local args = {
                        [1] = {
                            [1] = v.uid
                        }
                    }
                    Client.Network.Invoke("Delete Several Pets", unpack(args))
                elseif petRarity == "Mythical" and Rayfield.Flags.AutoDeleteMythical.CurrentValue then
                    local args = {
                        [1] = {
                            [1] = v.uid
                        }
                    }
                    Client.Network.Invoke("Delete Several Pets", unpack(args))
                elseif petRarity == "Secret" and Rayfield.Flags.AutoDeleteSecret.CurrentValue then
                    local args = {
                        [1] = {
                            [1] = v.uid
                        }
                    }
                    Client.Network.Invoke("Delete Several Pets", unpack(args))
                elseif petMaxStrength < strengthDeleteUnder and Rayfield.Flags.AutoDeleteBelowStrength.CurrentValue then
                    local args = {
                        [1] = {
                            [1] = v.uid
                        }
                    }
                    Client.Network.Invoke("Delete Several Pets", unpack(args))
                end
        
            end 

            task.wait(5)

        end
    end)
end

function renameAllPets(petName)
    local savedPets = FrameworkLibrary.Save.Get().Pets
    for i,v in pairs(savedPets) do 
        output = nil

        local args = {
            [1] = v.uid,
            [2] = petName
        }

        repeat
            output = Client.Network.Invoke("Rename Pet", unpack(args))
            task.wait(0.3)
        until output
    end    
end

function GetEquippedPets()
    return Client.PetCmds.GetEquipped() 
end 

function AutoHatch()
    task.spawn(function()
        while task.wait() do
            if not Rayfield.Flags.AutoHatch.CurrentValue then break end;
            if Rayfield.Flags.TeleportToEgg.CurrentValue then
                eggConfig = nil
                for i, val in pairs(eggsInfo) do
                    if val[1] == Rayfield.Flags.SelectedEgg.CurrentOption then
                        eggConfig = val
                    end
                end

                if eggConfig[2] == "Town" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Town") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(288, 103, 178)
                    end
                elseif eggConfig[2] == "Forest" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Town") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(290, 103, 218)
                    end
                elseif eggConfig[2] == "Beach" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Town") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(288, 103, 259)
                    end
                elseif eggConfig[2] == "Mine" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Town") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(289, 103, 299)
                    end
                elseif eggConfig[2] == "Winter" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Town") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(339, 116, 178)
                    end
                elseif eggConfig[2] == "Glacier" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Town") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(337, 116, 218)
                    end
                elseif eggConfig[2] == "Desert" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Town") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(339, 116, 259)
                    end
                elseif eggConfig[2] == "Volcano" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Town") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(340, 116, 298)
                    end
                elseif eggConfig[2] == "Enchanted Forest" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Samurai") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3353, 124, 192)
                    end
                elseif eggConfig[2] == "Ancient Island" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Samurai") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3391, 124, 193)
                    end
                elseif eggConfig[2] == "Samurai Island" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Samurai") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3431, 124, 193)
                    end
                elseif eggConfig[2] == "Candy Island" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Samurai") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3453, 124, 217)
                    end
                elseif eggConfig[2] == "Haunted Island" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Samurai") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3452, 124, 259)
                    end
                elseif eggConfig[2] == "Hell Island" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Samurai") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3430, 124, 285)
                    end
                elseif eggConfig[2] == "Heaven Island" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Samurai") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3391, 124, 284)
                    end
                elseif eggConfig[2] == "Heavens Gate" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Samurai") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(3349, 124, 285)
                    end
                elseif eggConfig[2] == "Dark Tech" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Steampunk") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(432, 96, 3078)
                    end
                elseif eggConfig[2] == "Tech City" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Steampunk") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(431, 96, 3155)
                    end
                elseif eggConfig[2] == "Steamkpunk" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Steampunk") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(465, 101, 3154)
                    end
                elseif eggConfig[2] == "Alien Lab" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Steampunk") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(464, 101, 3077)
                    end
                elseif eggConfig[2] == "Glitch" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Steampunk") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(495, 108, 3058)
                    end
                elseif eggConfig[2] == "Alien Forest" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Steampunk") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(493, 108, 3134)
                    end
                elseif eggConfig[2] == "Axolotl Deep Ocean" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Ocean") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4519, -15, 3716)
                    end
                elseif eggConfig[2] == "Axolotl Deep" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Ocean") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4521, -15, 3754)
                    end
                elseif eggConfig[2] == "Pixel Forest" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Pixel Forest") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4527, -15, 2412)
                    end
                elseif eggConfig[2] == "Pixel Forest" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Pixel Forest") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4527, -15, 2412)
                    end
                elseif eggConfig[2] == "Cat Paradise" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Cat Kingdom") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4557, -15, 3146)
                    end
                elseif eggConfig[2] == "Cat Backyard" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Cat Kingdom") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4555, -15, 3112)
                    end
                elseif eggConfig[2] == "Cat Taiga" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Cat Kingdom") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4553, -15, 3075)
                    end
                elseif eggConfig[2] == "Doodle Meadow" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Doodle Barn") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7774, 98, 3834)
                    end
                elseif eggConfig[2] == "Doodle Peaks" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Doodle Barn") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7773, 98, 3881)
                    end
                elseif eggConfig[2] == "Doodle Farm" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Doodle Barn") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7774, 98, 3933)
                    end
                elseif eggConfig[2] == "Doodle Oasis" then
                    if game:GetService("Workspace"):FindFirstChild("__MAP"):FindFirstChild("Areas"):FindFirstChild("Doodle Barn") then 
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(7777, 98, 3985)
                    end
                end
            end
            Client.Network.Invoke("Buy Egg", Rayfield.Flags.SelectedEgg.CurrentOption, false, false)
        end
    end)
end

function StringToBool(str)
	if str == "true" or str == "false" then
		local boolNew
		
		if str == "true" then
			boolNew = true
		elseif str == "false" then
			boolNew = false
		end
		
		return boolNew
	else
		warn("Parameter must be a string!")
		return nil
	end
end

function AutoClaimFreeRewards()
    task.spawn(function()
        while task.wait() do
            if not Rayfield.Flags.AutoClaimFreeRewards.CurrentValue then break end;
            local args = {
                [1] = 1
            }            
            Client.Network.Invoke("Redeem Free Gift", unpack(args))
            local args = {
                [1] = 2
            }            
            Client.Network.Invoke("Redeem Free Gift", unpack(args))
            local args = {
                [1] = 3
            }            
            Client.Network.Invoke("Redeem Free Gift", unpack(args))
            local args = {
                [1] = 4
            }            
            Client.Network.Invoke("Redeem Free Gift", unpack(args))
            local args = {
                [1] = 5
            }            
            Client.Network.Invoke("Redeem Free Gift", unpack(args))
            local args = {
                [1] = 6
            }            
            Client.Network.Invoke("Redeem Free Gift", unpack(args))
            local args = {
                [1] = 7
            }            
            Client.Network.Invoke("Redeem Free Gift", unpack(args))
            local args = {
                [1] = 8
            }            
            Client.Network.Invoke("Redeem Free Gift", unpack(args))
            local args = {
                [1] = 9
            }            
            Client.Network.Invoke("Redeem Free Gift", unpack(args))
            local args = {
                [1] = 10
            }            
            Client.Network.Invoke("Redeem Free Gift", unpack(args))
            local args = {
                [1] = 11
            }            
            Client.Network.Invoke("Redeem Free Gift", unpack(args))
            local args = {
                [1] = 12
            }            
            Client.Network.Invoke("Redeem Free Gift", unpack(args))
            task.wait(5)
        end
    end)
end

function AutoClaimVIPRewards()
    task.spawn(function()
        while task.wait() do
            if not Rayfield.Flags.AutoClaimVIPRewards.CurrentValue then break end;
            Client.Network.Invoke("Redeem VIP Rewards")
            task.wait(5)
        end
    end)
end

function AutoFarm()
    task.spawn(function()
        while true do
            if not Rayfield.Flags.AutoFarm.CurrentValue then break end;

            if Rayfield.Flags.SendAllPets.CurrentValue then

                local Pets = GetEquippedPets()
                local Coins = GetCoins(Rayfield.Flags.SelectedArea.CurrentOption)
                for i,v in next, Coins do
                    if workspace.__THINGS.Coins:FindFirstChild(i) and Rayfield.Flags.AutoFarm.CurrentValue then 
                        for _, Pet in next, Pets do 
                            spawn(function()
                                    Client.Network.Invoke('Join Coin', i, {Pet.uid})
                                    Client.Network.Fire('Farm Coin', i, Pet.uid)
                            end)
                        end 
                    end
                    repeat task.wait() until not workspace.__THINGS.Coins:FindFirstChild(i)
                end 

            else

                local Pets = GetEquippedPets()
                local Coins = GetCoins(Rayfield.Flags.SelectedArea.CurrentOption)
                for _,Pet in next, Pets do
                    spawn(function()
                        for i,v in next, Coins do 
                            if workspace.__THINGS.Coins:FindFirstChild(i) and Rayfield.Flags.AutoFarm.CurrentValue then 
                                spawn(function()
                                    Client.Network.Invoke('Join Coin', i, {Pet.uid})
                                    Client.Network.Fire('Farm Coin', i, Pet.uid)
                                    repeat task.wait() until not workspace.__THINGS.Coins:FindFirstChild(i)
                                end)
                            end
                        end
                    end)
                end 

            end
            task.wait(Rayfield.Flags.FarmingTime.CurrentValue)
        end
    end)
end

function AutoFuse()
    task.spawn(function()
        while true do
            if not Rayfield.Flags.AutoFuse.CurrentValue then break end;
            petTable = {}
            local savedPets = FrameworkLibrary.Save.Get().Pets
            for i,v in pairs(savedPets) do
                petTableInsert = {v.id, v.uid}
                if not table.find(petTable, petTableInsert) then
                    table.insert(petTable, petTableInsert)
                end
            end

            testTable = {}

            for i, val in pairs(petTable) do   
                if not testTable[val[1]] then
                    testTable[val[1]] = 1
                else
                    testTable[val[1]] = testTable[val[1]] + 1
                end
            end  

            for i, val in pairs(testTable) do 
                if val > Rayfield.Flags.AutoFuse.CurrentValue then
                    deletePetTable = {}
                    countTo = 0
                    for ii, v in pairs(petTable) do
                        if table.find(v, i) then
                            countTo = countTo + 1
                            deletePetTable[countTo] = v[2]
                        end
                    end
                    local args = {
                        [1] = {deletePetTable}
                    }
                    Client.Network.Invoke("Fuse Pets", unpack(args)) -- Not sure why this doesn't invoke and fuse???
                end
            end
            task.wait(5)          
        end
    end)
end

workspace.__THINGS.Orbs.ChildAdded:Connect(function(v)
    if Rayfield.Flags.AutoCollectOrbs.CurrentValue then
        Orbs.Collect(v)
    end
end)

workspace.__THINGS.Lootbags.ChildAdded:Connect(function(v)
    if Rayfield.Flags.AutoCollectLootbags.CurrentValue then
        Lootbags.Collect(v)
    end
end)


-- UI
local Window = Rayfield:CreateWindow({
    Name = "🛰️ Axion Hub",
    LoadingTitle = "🛰️ Axion Hub",
    LoadingSubtitle = "by tuba",
    ConfigurationSaving = {
       Enabled = false,
       FolderName = true, -- Create a custom folder for your hub/game
       FileName = "Axion Hub"
    },
    Discord = {
       Enabled = false,
       Invite = "sirius", -- The Discord invite code, do not include discord.gg/
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Sirius Hub",
       Subtitle = "Key System",
       Note = "Join the discord (discord.gg/sirius)",
       FileName = "SiriusKey",
       SaveKey = true,
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = "Hello"
    }
})

local infoTab = Window:CreateTab("Info", 4483362458)
local farmingTab = Window:CreateTab("Farming")
local eggTab = Window:CreateTab("Eggs")
local petTab = Window:CreateTab("Pets")
local serversTab = Window:CreateTab("Servers")
local miscTab = Window:CreateTab("Misc")
local configTab = Window:CreateTab("Config")

-- FARMING TAB
--      FARMING
local farmingSection = farmingTab:CreateSection("Farming", true)
local autoFarmToggle = farmingTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarm",
    Callback = function(Value)
        if Value then
            print("🛰️ Axion | Enabled AutoFarm")
            AutoFarm()
        else
            print("🛰️ Axion | Disabled AutoFarm")

        end
    end,
})
local selectedAreaDropdown = farmingTab:CreateDropdown({
    Name = "Selected Area",
    Options = areas,
    CurrentOption = "Town",
    Flag = "SelectedArea", 
    Callback = function(Option)
        print("🛰️ Axion | SelectedArea changed to "..Option)
    end,
})
local farmingModeDropdown = farmingTab:CreateDropdown({
    Name = "Farming Mode",
    Options = {"Normal"},
    CurrentOption = "Normal",
    Flag = "SelectedFarmingMode", 
    Callback = function(Option)
        print("🛰️ Axion | SelectedFarmingMode changed to "..Option)
    end,
})
local farmingTimeSlider = farmingTab:CreateSlider({
    Name = "Farming Time",
    Range = {0, 1},
    Increment = 0.01,
    Suffix = "Seconds",
    CurrentValue = 0.09,
    Flag = "FarmingTime",
    Callback = function(Value)
    
    end,
 })
local sendAllPetsToggle = farmingTab:CreateToggle({
    Name = "Send All Pets",
    CurrentValue = false,
    Flag = "SendAllPets",
    Callback = function(Value)
        if Value then
            print("🛰️ Axion | Enabled SendAllPets")
        else
            print("🛰️ Axion | Disabled SendAllPets")

        end
    end,
})

local autoCollectSection = farmingTab:CreateSection("Auto Collect", true)
local autoCollectOrbsToggle = farmingTab:CreateToggle({
    Name = "Auto Collect Orbs",
    CurrentValue = false,
    Flag = "AutoCollectOrbs",
    Callback = function(Value)
        if Value then
            print("🛰️ Axion | Enabled AutoCollectOrbs")
            for i,v in pairs(workspace.__THINGS.Orbs:GetChildren()) do 
                Orbs.Collect(v)
            end 
        else
            print("🛰️ Axion | Disabled AutoCollectOrbs")
        end
    end,
})
local autoCollectLootbagsToggle = farmingTab:CreateToggle({
    Name = "Auto Collect Lootbags",
    CurrentValue = false,
    Flag = "AutoCollectLootbags",
    Callback = function(Value)
        if Value then
            print("🛰️ Axion | Enabled AutoCollectLootbags")
            for i,v in pairs(workspace.__THINGS.Lootbags:GetChildren()) do 
                Lootbags.Collect(v)
            end  
        else
            print("🛰️ Axion | Disabled AutoCollectLootbags")
        end
    end,
})
-- EGG TAB
--      AUTO HATCH
local openEggSection = eggTab:CreateSection("Auto Hatch", true)
local selectedEggDropdown = eggTab:CreateDropdown({
    Name = "Selected Egg",
    Options = eggs,
    CurrentOption = "Cracked Egg",
    Flag = "SelectedEgg", 
    Callback = function(Option)
        print("🛰️ Axion | SelectedEgg changed to "..Option)
    end,
})
local openOneEggButton = eggTab:CreateButton({
    Name = "Open 1 Egg",
    Interact = 'Open',
    Callback = function()
        Client.Network.Invoke("Buy Egg", Rayfield.Flags.SelectedEgg.CurrentOption)
        print("🛰️ Axion | Opened a "..Rayfield.Flags.SelectedEgg.CurrentOption)
    end,
})
local autoHatchToggle = eggTab:CreateToggle({
    Name = "Auto Hatch",
    CurrentValue = false,
    Flag = "AutoHatch",
    Callback = function(Value)
        if Value then
            print("🛰️ Axion | Enabled AutoHatch")
            AutoHatch()
        else
            print("🛰️ Axion | Disabled AutoHatch")

        end
    end,
})
local teleportToEggToggle = eggTab:CreateToggle({
    Name = "Teleport to Egg",
    CurrentValue = false,
    Flag = "TeleportToEgg",
    Callback = function(Value)
        if Value then
            print("🛰️ Axion | Enabled TeleportToEgg")
        else
            print("🛰️ Axion | Disabled TeleportToEgg")

        end
    end,
})
local disableEggAnimationButton = eggTab:CreateButton({
    Name = "Disable Egg Animation",
    Info = "This will disable the egg hatching animation.",
    Interact = 'Disable',
    Callback = function()
        for i,v in pairs(getgc(true)) do
            if (typeof(v) == 'table' and rawget(v, 'OpenEgg')) then
                v.OpenEgg = function()
                    return
                end
            end
        end
        print("🛰️ Axion | Disabled egg animation")
    end,
})

--      AUTO DELETE
local autoDeleteSection = eggTab:CreateSection("Auto Delete", true)

local autoDeleteToggle = eggTab:CreateToggle({
    Name = "Auto Delete",
    CurrentValue = false,
    Flag = "AutoDelete",
    Callback = function(Value)
        if Value then
            print("🛰️ Axion | Enabled AutoDelete")
            AutoDelete()
        else
            print("🛰️ Axion | Disabled AutoDelete")

        end
    end,
})
local autoDeleteBelowStrengthToggle = eggTab:CreateToggle({
    Name = "Auto Delete Below Strength",
    CurrentValue = false,
    Flag = "AutoDeleteBelowStrength",
    Callback = function(Value)
        if Value then
            print("🛰️ Axion | Enabled AutoDeleteBelowStrength")

        else
            print("🛰️ Axion | Disabled AutoDeleteBelowStrength")
        end
    end,
})
local autoDeleteBelowStrengthTextText = eggTab:CreateLabel("Auto Deleted Below Strength Currently Set To: "..tostring(strengthDeleteUnder))

local autoDeleteBelowStrengthText = eggTab:CreateInput({
    Name = "Strength To Delete Under",
    Info = "Only works if above setting is enabled.",
    PlaceholderText = "1000",
    NumbersOnly = true,
    OnEnter = true, 
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        strengthDeleteUnder = Text
        print("🛰️ Axion | Changed StrengthToDeleteUnder")
        autoDeleteBelowStrengthTextText:Set("Auto Deleted Below Strength Currently Set To: "..tostring(strengthDeleteUnder))
    end,
})

local deleteBasicToggle = eggTab:CreateToggle({
    Name = "Auto Delete Basic",
    CurrentValue = false,
    Flag = "AutoDeleteBasic",
    Callback = function(Value)
        if Value then
            print("🛰️ Axion | Enabled AutoDeleteBasic")
        else
            print("🛰️ Axion | Disabled AutoDeleteBasic")

        end
    end,
})
local deleteRareToggle = eggTab:CreateToggle({
    Name = "Auto Delete Rare",
    CurrentValue = false,
    Flag = "AutoDeleteRare",
    Callback = function(Value)
        if Value then
            print("🛰️ Axion | Enabled AutoDeleteRare")
        else
            print("🛰️ Axion | Disabled AutoDeleteRare")

        end
    end,
})
local deleteEpicToggle = eggTab:CreateToggle({
    Name = "Auto Delete Epic",
    CurrentValue = false,
    Flag = "AutoDeleteEpic",
    Callback = function(Value)
        if Value then
            print("🛰️ Axion | Enabled AutoDeleteEpic")
        else
            print("🛰️ Axion | Disabled AutoDeleteEpic")

        end
    end,
})
local deleteLegendaryToggle = eggTab:CreateToggle({
    Name = "Auto Delete Legendary",
    CurrentValue = false,
    Flag = "AutoDeleteLegendary",
    Callback = function(Value)
        if Value then
            print("🛰️ Axion | Enabled AutoDeleteLegendary")
        else
            print("🛰️ Axion | Disabled AutoDeleteLegendary")

        end
    end,
})
local deleteMythicalToggle = eggTab:CreateToggle({
    Name = "Auto Delete Mythical",
    CurrentValue = false,
    Flag = "AutoDeleteMythical",
    Callback = function(Value)
        if Value then
            print("🛰️ Axion | Enabled AutoDeleteMythical")
        else
            print("🛰️ Axion | Disabled AutoDeleteMythical")

        end
    end,
})
local deleteSecretToggle = eggTab:CreateToggle({
    Name = "Auto Delete Secret",
    CurrentValue = false,
    Flag = "AutoDeleteSecret",
    Callback = function(Value)
        if Value then
            print("🛰️ Axion | Enabled AutoDeleteSecret")
        else
            print("🛰️ Axion | Disabled AutoDeleteSecret")

        end
    end,
})

-- PET TAB
--      ALL PET FUNCTIONS
local allPetSection = petTab:CreateSection("All Pets", true)

local renameAllPetsText = petTab:CreateInput({
    Name = "Rename all Pets",
    Info = "This will rename all pets in your pet library.",
    PlaceholderText = "tuba",
    NumbersOnly = false,
    OnEnter = true, 
    RemoveTextAfterFocusLost = false,
    Callback = function(Text)
        print("🛰️ Axion | Renamed all pets")
        renameAllPets(Text)
    end,
})

local machineSection = petTab:CreateSection("Machines", true)
local fuseMachineSection = petTab:CreateSection("Fuse", true)

-- local autoFuseToggle = petTab:CreateToggle({
--     Name = "Auto Fuse",
--     CurrentValue = false,
--     Flag = "AutoFuse",
--     Callback = function(Value)
--         if Value then
--             print("🛰️ Axion | Enabled AutoFuse")
--             AutoFuse()
--         else
--             print("🛰️ Axion | Disabled AutoFuse")
--         end
--     end,
-- })

-- local fuseAmountSlider = petTab:CreateSlider({
--     Name = "Fuse Amount",
--     Range = {3, 12},
--     Increment = 1,
--     Suffix = "Pets",
--     CurrentValue = 3,
--     Flag = "FuseAmount", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
--     Callback = function(Value)
--     -- The function that takes place when the slider changes
--     -- The variable (Value) is a number which correlates to the value the slider is currently at
--     end,
--  })
-- MISC TAB
--      AUTO CLAIM
local rewardSection = miscTab:CreateSection("Rewards", true)

local autoClaimFreeRewardsToggle = miscTab:CreateToggle({
    Name = "Auto Claim Free Rewards",
    CurrentValue = false,
    Flag = "AutoClaimFreeRewards",
    Callback = function(Value)
        if Value then
            print("🛰️ Axion | Enabled AutoClaimFreeRewards")
            AutoClaimFreeRewards()
        else
            print("🛰️ Axion | Disabled AutoClaimFreeRewards")

        end
    end,
})

local autoClaimVIPRewardsToggle = miscTab:CreateToggle({
    Name = "Auto Claim VIP Rewards",
    CurrentValue = false,
    Flag = "AutoClaimVIPRewards",
    Callback = function(Value)
        if Value then
            print("🛰️ Axion | Enabled AutoClaimVIPRewards")
            AutoClaimVIPRewards()
        else
            print("🛰️ Axion | Disabled AutoClaimVIPRewards")

        end
    end,
})

-- OTHER TAB
--      CONFIG
function loadConfiguration()
    if syn then
        if isfolder("Axion Hub") then
            if isfile("Axion Hub/config.json") then
                local loadedConfig = game:GetService('HttpService'):JSONDecode(readfile("Axion Hub/config.json"))
                
                -- EGGS


                task.spawn(function()
                    autoHatchToggle:Set(loadedConfig['eggs']['hatching']['autoHatch']) 
                end)
                task.spawn(function()
                    selectedEggDropdown:Set(loadedConfig['eggs']['hatching']['selectedEgg'])
                end)
                task.spawn(function()
                    teleportToEggToggle:Set(loadedConfig['eggs']['hatching']['teleportToEgg']) 
                end)
                task.spawn(function()
                    autoDeleteToggle:Set(loadedConfig['eggs']['autoDelete']['autoDelete']) 
                end)
                task.spawn(function()
                    autoDeleteBelowStrengthToggle:Set(loadedConfig['eggs']['autoDelete']['autoDeleteBelowStrength']) 
                end)
                task.spawn(function()
                    strengthDeleteUnder = loadedConfig['eggs']['autoDelete']['autoDeleteBelowStrengthAmount']
                end)
                task.spawn(function()
                    deleteBasicToggle:Set(loadedConfig['eggs']['autoDelete']['autoDeleteBasic']) 
                end)
                task.spawn(function()
                    deleteRareToggle:Set(loadedConfig['eggs']['autoDelete']['autoDeleteRare']) 
                end)
                task.spawn(function()
                    deleteEpicToggle:Set(loadedConfig['eggs']['autoDelete']['autoDeleteEpic']) 
                end)
                task.spawn(function()
                    deleteLegendaryToggle:Set(loadedConfig['eggs']['autoDelete']['autoDeleteLegendary']) 
                end)
                task.spawn(function()
                    deleteMythicalToggle:Set(loadedConfig['eggs']['autoDelete']['autoDeleteMythical']) 
                end)
                task.spawn(function()
                    deleteSecretToggle:Set(loadedConfig['eggs']['autoDelete']['autoDeleteSecret']) 
                end)
                task.spawn(function()
                    autoDeleteBelowStrengthTextText:Set("Auto Deleted Below Strength Currently Set To: "..tostring(strengthDeleteUnder))
                end)
                task.spawn(function()
                    autoClaimFreeRewardsToggle:Set(loadedConfig['misc']['autoClaimFreeRewards']) 
                end)
                task.spawn(function()
                    autoClaimVIPRewardsToggle:Set(loadedConfig['misc']['autoClaimVIPRewards']) 
                end)
                task.spawn(function()
                    autoFarmToggle:Set(loadedConfig['farming']['autoFarm']) 
                end)
                task.spawn(function()
                    selectedAreaDropdown:Set(loadedConfig['farming']['selectedArea'])
                end)
                task.spawn(function()
                    sendAllPetsToggle:Set(loadedConfig['farming']['sendAllPets']) 
                end)
                task.spawn(function()
                    farmingTimeSlider:Set(loadedConfig['farming']['farmingTime']) 
                end)
                task.spawn(function()
                    autoCollectOrbsToggle:Set(loadedConfig['farming']['autoCollectOrbs']) 
                end)
                task.spawn(function()
                    autoCollectLootbagsToggle:Set(loadedConfig['farming']['autoCollectLootbags']) 
                end)
                task.spawn(function()
                    autoFuseToggle:Set(loadedConfig['pets']['fuse']['autoFuse']) 
                end)
                task.spawn(function()
                    fuseAmountSlider:Set(loadedConfig['pets']['fuse']['fuseAmount']) 
                end)



            end
        end
    end
end

function saveConfiguration()
    if syn then

        local saveConfig = {
            farming = {
                autoFarm = Rayfield.Flags.AutoFarm.CurrentValue,
                selectedArea = Rayfield.Flags.SelectedArea.CurrentOption,
                sendAllPets = Rayfield.Flags.SendAllPets.CurrentValue,
                farmingTime = Rayfield.Flags.FarmingTime.CurrentValue,
                autoCollectOrbs = Rayfield.Flags.AutoCollectOrbs.CurrentValue,
                autoCollectLootbags = Rayfield.Flags.AutoCollectLootbags.CurrentValue

            },
            eggs = {
                hatching = {
                    autoHatch = Rayfield.Flags.AutoHatch.CurrentValue,
                    selectedEgg = Rayfield.Flags.SelectedEgg.CurrentOption,
                    teleportToEgg = Rayfield.Flags.TeleportToEgg.CurrentValue,

                },
                autoDelete = {
                    autoDelete = Rayfield.Flags.AutoDelete.CurrentValue,
                    autoDeleteBelowStrength = Rayfield.Flags.AutoDeleteBelowStrength.CurrentValue,
                    autoDeleteBelowStrengthAmount = strengthDeleteUnder,
                    autoDeleteBasic = Rayfield.Flags.AutoDeleteBasic.CurrentValue,
                    autoDeleteRare = Rayfield.Flags.AutoDeleteRare.CurrentValue,
                    autoDeleteEpic = Rayfield.Flags.AutoDeleteEpic.CurrentValue,
                    autoDeleteLegendary = Rayfield.Flags.AutoDeleteLegendary.CurrentValue,
                    autoDeleteMythical = Rayfield.Flags.AutoDeleteMythical.CurrentValue,
                    autoDeleteSecret = Rayfield.Flags.AutoDeleteSecret.CurrentValue
                }
            },
            misc = {
                autoClaimFreeRewards = Rayfield.Flags.AutoClaimFreeRewards.CurrentValue,
                autoClaimVIPRewards = Rayfield.Flags.AutoClaimVIPRewards.CurrentValue

            },
            pets = {
                autoFuse = Rayfield.Flags.AutoFuse.CurrentValue,
                fuseAmount = Rayfield.Flags.fuseAmount.CurrentValue,
            }
        }

        if not isfolder("Axion Hub") then
            makefolder("Axion Hub") 
        end

        writefile("Axion Hub/config.json", game:GetService('HttpService'):JSONEncode(saveConfig))
        print("🛰️ Axion | Config Saved")

    end
end

local saveConfigButton = configTab:CreateButton({
    Name = "Save Config",
    Interact = 'Save',
    Callback = function()
        saveConfiguration()
    end,
})

local loadConfigButton = configTab:CreateButton({
    Name = "Load Config",
    Interact = 'Load',
    Callback = function()
        loadConfiguration()
    end,
})

loadConfiguration()

