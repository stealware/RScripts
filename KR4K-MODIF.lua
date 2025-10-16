-- quick note, ronaldo is the goat.
local Lib = {}

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")

function Lib:Drag(frame, parent)
	parent = parent or frame
	local dragging, dragStart, startPos
	local dragSpeed = 0.25

	local function updateInput(input)
		local delta = input.Position - dragStart
		local newPos = UDim2.new(
			startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y
		)
		TweenService:Create(parent, TweenInfo.new(dragSpeed), {Position = newPos}):Play()
	end

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = parent.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and dragging then
			updateInput(input)
		end
	end)
end

function Lib.Window(Title)
	Title = Title or "UI Library"

	local UiLib = Instance.new("ScreenGui")
	UiLib.Name = "UiLib"
	UiLib.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
	UiLib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local Main = Instance.new("Frame")
	Main.Name = "Main"
	Main.Parent = UiLib
	Main.BackgroundColor3 = Color3.fromRGB(31, 25, 44)
	Main.Position = UDim2.new(0.3, 0, 0.29, 0)
	Main.Size = UDim2.new(0, 454, 0, 333)
	Main.BorderSizePixel = 0
	local MainCorner = Instance.new("UICorner", Main)
	MainCorner.CornerRadius = UDim.new(0, 15)

	local TopBar = Instance.new("Frame")
	TopBar.Name = "TopBar"
	TopBar.Parent = Main
	TopBar.BackgroundColor3 = Color3.fromRGB(18, 15, 24)
	TopBar.Size = UDim2.new(0, 454, 0, 45)
	TopBar.BorderSizePixel = 0
	Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 15)

	local LibraryTitle = Instance.new("TextLabel")
	LibraryTitle.Parent = TopBar
	LibraryTitle.BackgroundTransparency = 1
	LibraryTitle.Size = UDim2.new(0, 300, 0, 39)
	LibraryTitle.Position = UDim2.new(0.02, 2, 0.17, -4)
	LibraryTitle.Text = Title
	LibraryTitle.TextColor3 = Color3.fromRGB(227, 227, 227)
	LibraryTitle.TextScaled = true
	LibraryTitle.TextXAlignment = Enum.TextXAlignment.Left
	LibraryTitle.Font = Enum.Font.Nunito
	LibraryTitle.TextWrapped = true

	local Extension = Instance.new("Frame", TopBar)
	Extension.Name = "Extension"
	Extension.BackgroundColor3 = Color3.fromRGB(18, 15, 24)
	Extension.Position = UDim2.new(0, 0, 0.99, 0)
	Extension.Size = UDim2.new(0, 454, 0, -23)
	Instance.new("UICorner", Extension).CornerRadius = UDim.new(0, 7)

	local TabFrame = Instance.new("Frame")
	TabFrame.Name = "TabFrame"
	TabFrame.Parent = Main
	TabFrame.BackgroundColor3 = Color3.fromRGB(18, 15, 24)
	TabFrame.Position = UDim2.new(0.02, 0, 0.15, 0)
	TabFrame.Size = UDim2.new(0, 134, 0, 275)
	Instance.new("UICorner", TabFrame).CornerRadius = UDim.new(0, 7)

	local TabNavigator = Instance.new("ScrollingFrame", TabFrame)
	TabNavigator.Name = "TabNavigator"
	TabNavigator.Size = UDim2.new(0, 132, 0, 275)
	TabNavigator.Position = UDim2.new(0, 0, 0, 0)
	TabNavigator.BackgroundTransparency = 1
	TabNavigator.Active = true
	TabNavigator.BorderSizePixel = 0
	TabNavigator.CanvasSize = UDim2.new(0, 0, 0, 0)
	local UIListLayout = Instance.new("UIListLayout", TabNavigator)
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 19)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	Instance.new("UIPadding", TabNavigator).PaddingTop = UDim.new(0, 12)

	local ContentHolder = Instance.new("Folder", Main)
	ContentHolder.Name = "ContentHolder"

	Lib:Drag(TopBar, Main)

	local TabSys = {}
	local firstTab = true

	function TabSys.CreateTab(TabTitle)
		TabTitle = TabTitle or "Home"

		local TabContent = Instance.new("ScrollingFrame", ContentHolder)
		TabContent.Name = TabTitle .. "'s Content"
		TabContent.Active = true
		TabContent.BackgroundTransparency = 1
		TabContent.Position = UDim2.new(0.33, 0, 0.15, 0)
		TabContent.Size = UDim2.new(0, 295, 0, 275)
		TabContent.ClipsDescendants = true
		TabContent.Visible = firstTab
		firstTab = false

		local ContentPadding = Instance.new("UIPadding", TabContent)
		ContentPadding.PaddingTop = UDim.new(0, 12)
		local ContentLayout = Instance.new("UIListLayout", TabContent)
		ContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
		ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ContentLayout.Padding = UDim.new(0, 12)

		local TabSwitcher = Instance.new("TextButton", TabNavigator)
		TabSwitcher.Name = "TabSwitcher"
		TabSwitcher.Text = TabTitle
		TabSwitcher.BackgroundColor3 = Color3.fromRGB(53, 50, 74)
		TabSwitcher.Size = UDim2.new(0, 114, 0, 25)
		TabSwitcher.Font = Enum.Font.Nunito
		TabSwitcher.TextSize = 24
		TabSwitcher.TextColor3 = Color3.fromRGB(199, 199, 199)
		Instance.new("UICorner", TabSwitcher)

		if TabContent.Visible then
			TabSwitcher.BackgroundTransparency = 0.7
			TabSwitcher.TextColor3 = Color3.fromRGB(255, 255, 255)
		else
			TabSwitcher.BackgroundTransparency = 0.89
		end

		TabSwitcher.MouseButton1Click:Connect(function()
			for _, v in next, ContentHolder:GetChildren() do
				v.Visible = false
			end
			TabContent.Visible = true

			for _, btn in next, TabNavigator:GetChildren() do
				if btn:IsA("TextButton") then
					TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.89, TextColor3 = Color3.fromRGB(199, 199, 199)}):Play()
				end
			end
			TweenService:Create(TabSwitcher, TweenInfo.new(0.2), {BackgroundTransparency = 0.7, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		end)

		local Content = {}

		function Content.CreateButton(BtnTitle, callback)
			BtnTitle = BtnTitle or "Button"
			callback = callback or function() end

			local ButtonFrame = Instance.new("Frame", TabContent)
			ButtonFrame.Size = UDim2.new(0, 237, 0, 32)
			ButtonFrame.BackgroundColor3 = Color3.fromRGB(53, 50, 74)
			ButtonFrame.ClipsDescendants = true
			Instance.new("UICorner", ButtonFrame)

			local ButtonTrigger = Instance.new("TextButton", ButtonFrame)
			ButtonTrigger.BackgroundTransparency = 1
			ButtonTrigger.Size = UDim2.new(1, 0, 1, 0)
			ButtonTrigger.Text = ""

			local TextLabel = Instance.new("TextLabel", ButtonFrame)
			TextLabel.BackgroundTransparency = 1
			TextLabel.Text = BtnTitle
			TextLabel.TextColor3 = Color3.fromRGB(227, 227, 227)
			TextLabel.TextSize = 26
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.Font = Enum.Font.Nunito

			ButtonTrigger.MouseButton1Click:Connect(function()
				callback()
			end)
		end

		-- Sliders
		function Content.CreateSlider(Name, Min, Max, default, callback)
			Name = Name or "Slider"
			Min = Min or 0
			Max = Max or 100
			default = default or Min
			callback = callback or function() end

			local SliderFrame = Instance.new("Frame", TabContent)
			SliderFrame.Size = UDim2.new(0, 237, 0, 32)
			SliderFrame.BackgroundColor3 = Color3.fromRGB(53, 50, 74)
			Instance.new("UICorner", SliderFrame)

			local SliderLabel = Instance.new("TextLabel", SliderFrame)
			SliderLabel.BackgroundTransparency = 1
			SliderLabel.Text = Name
			SliderLabel.TextColor3 = Color3.fromRGB(227, 227, 227)
			SliderLabel.TextSize = 26
			SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
			SliderLabel.Font = Enum.Font.Nunito

			local Slider = Instance.new("Frame", SliderFrame)
			Slider.Size = UDim2.new(0, 0, 1, 0)
			Slider.Position = UDim2.new(0, 0, 0, 0)
			Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Instance.new("UICorner", Slider)

			local dragging = false
			SliderFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
				end
			end)

			SliderFrame.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)

			UIS.InputChanged:Connect(function(input)
				if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
					local relative = math.clamp(input.Position.X - SliderFrame.AbsolutePosition.X, 0, SliderFrame.AbsoluteSize.X)
					local value = math.floor((relative / SliderFrame.AbsoluteSize.X) * (Max - Min) + Min)
					Slider.Size = UDim2.new(relative / SliderFrame.AbsoluteSize.X, 0, 1, 0)
					callback(value)
				end
			end)
		end

		return Content
	end

	return TabSys
end

return Lib
