local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PetsFolder = ReplicatedStorage:WaitForChild("Pets")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI Elements
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
local frame = Instance.new("Frame", screenGui)
frame.Size = UDim2.new(0, 300, 0, 200)
frame.Position = UDim2.new(0.5, -150, 0.5, -100)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0

local title = Instance.new("TextLabel", frame)
title.Text = "Pet Spawner"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextScaled = true

local petName = Instance.new("TextBox", frame)
petName.PlaceholderText = "Shadow Dragon"
petName.Text = ""
petName.Position = UDim2.new(0.1, 0, 0.2, 0)
petName.Size = UDim2.new(0.8, 0, 0, 30)
petName.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
petName.TextColor3 = Color3.new(1, 1, 1)

local selectedType = "NFR"

local function createTypeButton(name, color, posX)
	local button = Instance.new("TextButton", frame)
	button.Text = name
	button.BackgroundColor3 = color
	button.Position = UDim2.new(posX, 0, 0.4, 0)
	button.Size = UDim2.new(0.25, -5, 0, 30)
	button.MouseButton1Click:Connect(function()
		selectedType = name
		selectedLabel.Text = "Selected: " .. name
	end)
	return button
end

createTypeButton("MFR", Color3.fromRGB(255, 100, 100), 0.05)
createTypeButton("NFR", Color3.fromRGB(100, 255, 100), 0.375)
createTypeButton("FR", Color3.fromRGB(100, 100, 255), 0.7)

local spawnButton = Instance.new("TextButton", frame)
spawnButton.Text = "Spawn Pet"
spawnButton.Position = UDim2.new(0.1, 0, 0.65, 0)
spawnButton.Size = UDim2.new(0.8, 0, 0, 35)
spawnButton.BackgroundColor3 = Color3.fromRGB(80, 150, 255)

local selectedLabel = Instance.new("TextLabel", frame)
selectedLabel.Text = "Selected: NFR"
selectedLabel.Position = UDim2.new(0.1, 0, 0.85, 0)
selectedLabel.Size = UDim2.new(0.8, 0, 0, 20)
selectedLabel.BackgroundTransparency = 1
selectedLabel.TextColor3 = Color3.fromRGB(255, 255, 100)

-- Equip Pet Logic
local function equipPet(petNameText)
	local petModel = PetsFolder:FindFirstChild(petNameText)
	if petModel then
		local petClone = petModel:Clone()
		petClone.Name = petNameText .. "_" .. selectedType
		petClone:SetPrimaryPartCFrame(player.Character.HumanoidRootPart.CFrame * CFrame.new(2, 0, 2))
		petClone.Parent = workspace

		local weld = Instance.new("WeldConstraint")
		weld.Part0 = player.Character.HumanoidRootPart
		weld.Part1 = petClone.PrimaryPart
		weld.Parent = petClone.PrimaryPart
	else
		warn("Pet not found: " .. petNameText)
	end
end

spawnButton.MouseButton1Click:Connect(function()
	if petName.Text ~= "" then
		equipPet(petName.Text)
	end
end)
