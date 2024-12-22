-- Kenon Fly Script
-- Author: khoitongdz

local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Fly Variables
local flying = false
local speed = 50
local bodyVelocity

-- Key Bind (change "F" to your preferred key)
local flyKey = Enum.KeyCode.F

-- Start Flying Function
local function startFlying()
    if flying then return end
    flying = true

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
    bodyVelocity.P = 1e5
    bodyVelocity.Velocity = Vector3.zero
    bodyVelocity.Parent = humanoidRootPart

    while flying do
        local moveDirection = Vector3.zero

        if UIS:IsKeyDown(Enum.KeyCode.W) then
            moveDirection += humanoidRootPart.CFrame.LookVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.S) then
            moveDirection -= humanoidRootPart.CFrame.LookVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.A) then
            moveDirection -= humanoidRootPart.CFrame.RightVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.D) then
            moveDirection += humanoidRootPart.CFrame.RightVector
        end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then
            moveDirection += Vector3.new(0, 1, 0)
        end
        if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveDirection -= Vector3.new(0, 1, 0)
        end

        bodyVelocity.Velocity = moveDirection.Unit * speed
        wait()
    end
end

-- Stop Flying Function
local function stopFlying()
    if not flying then return end
    flying = false
    if bodyVelocity then
        bodyVelocity:Destroy()
        bodyVelocity = nil
    end
end

-- Toggle Fly
UIS.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == flyKey then
        if flying then
            stopFlying()
        else
            startFlying()
        end
    end
end)

print("Kenon Fly loaded! Press F to toggle fly.")
