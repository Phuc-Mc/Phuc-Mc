local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "TinyCooldownUI"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame nhỏ gọn
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 100, 0, 30)
frame.Position = UDim2.new(0, 20, 0, 200)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = screenGui

-- Nút bật/tắt
local toggle = Instance.new("TextButton")
toggle.Size = UDim2.new(1, 0, 1, 0)
toggle.Text = "OFF"
toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.Font = Enum.Font.SourceSansBold
toggle.TextSize = 14
toggle.Parent = frame

-- Cooldown logic
local success, C = pcall(function()
	return require(game:GetService("ReplicatedStorage"):WaitForChild("Controllers"):WaitForChild("AbilityController"))
end)

if success and C and C.AbilityCooldown then
	local originalCooldown = C.AbilityCooldown
	local isOn = false

	toggle.MouseButton1Click:Connect(function()
		isOn = not isOn
		if isOn then
			C.AbilityCooldown = function(s, n, ...) return originalCooldown(s, n, 0, ...) end
			toggle.Text = "ON"
			toggle.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
		else
			C.AbilityCooldown = originalCooldown
			toggle.Text = "OFF"
			toggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
		end
	end)
else
	toggle.Text = "ERR"
	toggle.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
end
