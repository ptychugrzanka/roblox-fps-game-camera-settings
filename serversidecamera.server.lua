local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UpdateHeadMovement = ReplicatedStorage.remote:WaitForChild("UpdateHeadMovement")

UpdateHeadMovement.OnServerEvent:Connect(function(player, newC0)
	local character = player.Character
	if character and character:FindFirstChild("HumanoidRootPart") then
		local neck = character:FindFirstChild("Neck", true)
		if neck then
			neck.C0 = newC0
		end
	end
end)

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid")
		if humanoid.RigType == Enum.HumanoidRigType.R15 or humanoid.RigType == Enum.HumanoidRigType.R6 then
			local neck = character:WaitForChild("Neck", true)
			if neck then
				neck:GetPropertyChangedSignal("C0"):Connect(function()
					UpdateHeadMovement:FireAllClients(player, neck.C0)
				end)
			end
		end
	end)
end)
