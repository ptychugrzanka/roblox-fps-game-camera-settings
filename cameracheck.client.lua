local Camera = workspace.CurrentCamera
local Player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpdateHeadMovement = ReplicatedStorage.remote:WaitForChild("UpdateHeadMovement")

local Character = Player.Character or Player.CharacterAdded:Wait()
local Root = Character:WaitForChild("HumanoidRootPart")
local Neck = Character.Head:FindFirstChild("Neck", true)
local YOffset = Neck.C0.Y

local CFNew, CFAng = CFrame.new, CFrame.Angles
local asin = math.asin

game:GetService("RunService").RenderStepped:Connect(function()
	local CameraDirection = Root.CFrame:toObjectSpace(Camera.CFrame).lookVector
	if Neck then
		local newC0
		if Player.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
			newC0 = CFNew(0, YOffset, 0) * CFAng(0, -asin(CameraDirection.x), 0) * CFAng(asin(CameraDirection.y), 0, 0)
		elseif Character.Humanoid.RigType == Enum.HumanoidRigType.R6 then
			newC0 = CFNew(0, YOffset, 0) * CFAng(3 * math.pi/2, 0, math.pi) * CFAng(0, 0, -asin(CameraDirection.x)) * CFAng(-asin(CameraDirection.y), 0, 0)
		end
		UpdateHeadMovement:FireServer(newC0)
	end
end)
