-- Adopt Me Style Pet GUI with Equipping Feature
-- Open Source GUI script for Roblox

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local petsFolder = ReplicatedStorage:WaitForChild("Pets") -- Folder containing pet models

-- UI Setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "PetSpawnerGUI"

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 250)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Visible = true

-- Dropdown/Buttons for Pet Types
local petTypes = {"MFR", "NFR", "FR"}
local selectedPetType = "MFR"

for i, petType in ipairs(petTypes) do
    local button = Instance.new("TextButton", mainFrame)
    button.Size = UDim2.new(0, 80, 0, 40)
    button.Position = UDim2.new(0, 10 + (i-1)*90, 0, 10)
    button.Text = petType
    button.Name = petType

    button.MouseButton1Click:Connect(function()
        selectedPetType = petType
    end)
end

-- Spawn Button
local spawnButton = Instance.new("TextButton", mainFrame)
spawnButton.Size = UDim2.new(0, 260, 0, 40)
spawnButton.Position = UDim2.new(0, 20, 0, 70)
spawnButton.Text = "Spawn Pet"
spawnButton.Name = "SpawnButton"

-- Function to spawn and equip pet
local function spawnPet()
    local petModel = petsFolder:FindFirstChild(selectedPetType)
    if petModel then
        local clone = petModel:Clone()
        clone.Name = selectedPetType .. "_Pet"
        clone.Parent = workspace

        -- Position near player
        clone:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame * CFrame.new(2, 0, 2))

        -- Weld pet to follow player
        local weld = Instance.new("WeldConstraint")
        weld.Part0 = clone.PrimaryPart
        weld.Part1 = player.Character:FindFirstChild("HumanoidRootPart")
        weld.Parent = clone.PrimaryPart
    end
end

spawnButton.MouseButton1Click:Connect(spawnPet)

-- Tip: Add pet models to ReplicatedStorage > Pets folder with names "MFR", "NFR", "FR"
-- Each model should have a PrimaryPart set to allow proper attachment.
