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

-- GUI Variables
local ScreenGui = Instance.new("ScreenGui")
local StartButton = Instance.new("TextButton")
local StopButton = Instance.new("TextButton")
local IncreaseSpeedButton = Instance.new("TextButton")
local DecreaseSpeedButton = Instance.new("TextButton")

-- Compatibility for Executors
local function createInstance(instanceType, properties)
    local success, instance = pcall(function()
        local obj = Instance.new(instanceType)
        for prop, value in pairs(properties) do
            obj[prop] = value
        end
        return obj
    end)
    if success then
        return instance
    else
        warn("Failed to create instance: " .. tostring(instanceType))
        return nil
    end
end

-- Start Flying Function
local function startFlying()
    if flying then return end
    flying = true

    bodyVelocity = createInstance("BodyVelocity", {
        MaxForce = Vector3.new(1e6, 1e6, 1e6),
        P = 1e5,
        Velocity = Vector3.zero,
        Parent = humanoidRootPart
    })

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

        bodyVelocity.Velocity = moveDirection.Magnitude > 0 and moveDirection.Unit * speed or Vector3.zero
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

-- GUI Setup
ScreenGui.Parent = game.CoreGui

StartButton.Parent = ScreenGui
StartButton.Size = UDim2.new(0, 100, 0, 50)
StartButton.Position = UDim2.new(0.1, 0, 0.1, 0)
StartButton.Text = "Start"
StartButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
StartButton.MouseButton1Click:Connect(function()
    startFlying()
end)

StopButton.Parent = ScreenGui
StopButton.Size = UDim2.new(0, 100, 0, 50)
StopButton.Position = UDim2.new(0.1, 0, 0.2, 0)
StopButton.Text = "Stop"
StopButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
StopButton.MouseButton1Click:Connect(function()
    stopFlying()
end)

IncreaseSpeedButton.Parent = ScreenGui
IncreaseSpeedButton.Size = UDim2.new(0, 100, 0, 50)
IncreaseSpeedButton.Position = UDim2.new(0.1, 0, 0.3, 0)
IncreaseSpeedButton.Text = "Speed +"
IncreaseSpeedButton.BackgroundColor3 = Color3.fromRGB(0, 0, 255)
IncreaseSpeedButton.MouseButton1Click:Connect(function()
    if speed < 200 then
        speed = speed + 10
        print("Speed increased to " .. speed)
    end
end)

DecreaseSpeedButton.Parent = ScreenGui
DecreaseSpeedButton.Size = UDim2.new(0, 100, 0, 50)
DecreaseSpeedButton.Position = UDim2.new(0.1, 0, 0.4, 0)
DecreaseSpeedButton.Text = "Speed -"
DecreaseSpeedButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
DecreaseSpeedButton.MouseButton1Click:Connect(function()
    if speed > 1 then
        speed = speed - 10
        print("Speed decreased to " .. speed)
    end
end)

print("Kenon Fly loaded! Use the GUI to start, stop, or adjust speed.")
