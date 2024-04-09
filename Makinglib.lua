

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HttpService = game:GetService("HttpService")

local AstroLib = {
	Elements = {},
	ThemeObjects = {},
	Connections = {},
	Flags = {},
	Themes = {
		Default = {
			Main = Color3.fromRGB(25, 25, 25),
			Second = Color3.fromRGB(32, 32, 32),
			Stroke = Color3.fromRGB(60, 60, 60),
			Divider = Color3.fromRGB(60, 60, 60),
			Text = Color3.fromRGB(240, 240, 240),
			TextDark = Color3.fromRGB(150, 150, 150)
		}
	},
	SelectedTheme = "Default",
	Folder = nil,
	SaveCfg = false
  }

--Feather Icons https://github.com/evoincorp/lucideblox/tree/master/src/modules/util - Created by 7kayoh
local Icons = {}

local Succsess, Response = pcall(function()
	Icons = HttpService:JSONDecode(game:HttpGetAsync("https://raw.githubusercontent.com/evoincorp/lucideblox/master/src/modules/util/icons.json")).icons
end)

if not Success then
	warn("\nOrion Library - Failed to load Feather Icons. Error code: " .. Response .. "\n")
end

local function GetIcon(IconName)
	if Icons[IconName] ~= nil then
		return Icons[IconName]
	else
		return nil
	end
end   

local Astro = Instance.new("ScreenGui")
Astro.Name = "Astro"
if syn then
  syn.protect_gui(Astro)
  Astro.Parent = game.CoreGui
else
  Astro.Parent = gethui() or game.CoreGui
end

if gethui then
	for _, Interface in ipairs(gethui():GetChildren()) do
		if Interface.Name == Astro.Name and Interface ~= Astro then
      Interface:Destroy()
		end
end
else
	for _, Interface in ipairs(gethui():GetChildren()) do
    if Interface.Name == Astro.Name and Interface ~= Astro then
      Interface:Destroy()
    end
  end
end

function AstroLib:IsRunning()
  if gethui then
    return Astro.Parent == gethui()
  else
    return Astro.Parent == game:GetService("CoreGui")
  end

end

local function AddConnection(Signal, Function)
  if (not AstroLib:IsRunning()) then
    return
  end
	local SignalConnect = Signal:Connect(Function)
  table.Insert(AstroLib.Connections, SignalConnect)
  return SignalConnect
end

task.spawn(function()
  while (AstroLib:IsRunning()) do
    wait()
end

  for _, Connection in next, AstroLib.Connections do
    Connection:Disconnect()
  end
end)

local function MakeDraggable(DragPoint, Main)
	pcall(function()
		local Dragging, DragInput, MousePos, FramePos = false
		AddConnection(DragPoint.InputBegan, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				MousePos = Input.Position
				FramePos = Main.Position

				Input.Changed:Connect(function()
					if Input.UserInputState == Enum.UserInputState.End then
						Dragging = false
					end
				end)
			end
		end)
		AddConnection(DragPoint.InputChanged, function(Input)
			if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
				DragInput = Input
			end
		end)
		AddConnection(UserInputService.InputChanged, function(Input)
			if Input == DragInput and Dragging then
				local Delta = Input.Position - MousePos
				TweenService:Create(Main, TweenInfo.new(0.05, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position  = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)}):Play()
				Main.Position  = UDim2.new(FramePos.X.Scale,FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
			end
		end)
	end)
end    

local function Create(Name, Properties, Children)
	local Object = Instance.new(Name)
	for i, v in next, Properties or {} do
		Object[i] = v
	end
	for i, v in next, Children or {} do
		v.Parent = Object
	end
	return Object
    end

local function CreateElement(ElementName, ElementFunction)
  AstroLib.Elements[ElementName] = function(...)
    return ElementFunction(...)
  end
end

local function MakeElement(ElementName, ...)
  local NewElement = AstroLib.Elements[ElementName](...)
  return NewElement
end

local function SetProps(Element, Props)
  table.foreach(Props, function(Property, Value)
    Element[Property] = Value
  end)
  return Element
end

