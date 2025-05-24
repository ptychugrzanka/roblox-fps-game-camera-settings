local player = game.Players.LocalPlayer
local char = player.Character
local RunService = game:GetService("RunService")

char.Humanoid.CameraOffset = Vector3.new(0, 0, -0.8)

for i, v in pairs(char:GetChildren()) do
	if v:IsA("BasePart") and v.Name ~= "Head" then

		v:GetPropertyChangedSignal("LocalTransparencyModifier"):Connect(function()
			v.LocalTransparencyModifier = v.Transparency
		end)

		v.LocalTransparencyModifier = v.Transparency

	end
end