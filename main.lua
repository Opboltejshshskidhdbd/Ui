-- Importing libraries
local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")

-- Creating GUI
local gui = Instance.new("ScreenGui")
gui.Name = "MyGUI"
gui.ResetOnSpawn = true
gui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 200)
frame.BackgroundTransparency = 0.5
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BorderColor3 = Color3.fromRGB(255,0,0)
frame.BorderSizePixel = 1
frame.Parent = gui
frame.Active = true
frame.Draggable = true

local label = Instance.new("TextLabel")
label.Size = UDim2.new(0, 200, 0, 50)
label.Text = "Made by ༒ TWO PARTY GAMER ༒#4587"
label.BackgroundTransparency = 1
label.Position = UDim2.new(0.2, 0, 0.6, 0)
label.TextColor3 = Color3.new(255, 0, 0)
label.TextSize = 6
label.Parent = frame

local guiok = Instance.new("ScreenGui")
guiok.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
-- Create the close button inside the existing frame
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 90, 0, 38)
closeButton.Position = UDim2.new(1, -110, 0, 10)  -- Adjust position as needed (here, it's positioned 10 pixels from the top-right corner)
closeButton.Parent = frame
closeButton.Text = "Close"
closeButton.TextSize = 18
closeButton.TextColor3 = Color3.fromRGB(255,0,0)
closeButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
closeButton.BorderColor3 = Color3.fromRGB(255,0,0)
closeButton.BorderSizePixel = 1
closeButton.AutoButtonColor = false
closeButton.ClipsDescendants = true

-- Create the open button anywhere on the screen
local openButton = Instance.new("TextButton")
openButton.Size = UDim2.new(0, 90, 0, 38)
openButton.Position = UDim2.new(0.1, 0, 0.1, 0)  -- Adjust position as needed
openButton.Parent = guiok
openButton.Text = "Open"
openButton.TextSize = 18
openButton.TextColor3 = Color3.fromRGB(255,0,0)
openButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
openButton.BorderColor3 = Color3.fromRGB(255,0,0)
openButton.BorderSizePixel = 1
openButton.AutoButtonColor = false
openButton.ClipsDescendants = true
openButton.Visible = false
openButton.Draggable = true

-- Function to handle open button click
openButton.MouseButton1Click:Connect(function()
    gui.Enabled = true
    openButton.Visible = false
end)

-- Function to handle close button click
closeButton.MouseButton1Click:Connect(function()
    gui.Enabled = false
    openButton.Visible = true
end)
-- creating tabs at the left side of frame
local tab1 = Instance.new("Frame")
tab1.Size = UDim2.new(0, 60, 0, 200)
tab1.Position = UDim2.new(1, -360, 0, 0)
tab1.BackgroundTransparency = 0.5
tab1.BackgroundColor3 = Color3.fromRGB(0,0,0)
tab1.BorderColor3 = Color3.fromRGB(255,0,0)
tab1.BorderSizePixel = 1
tab1.Parent = frame