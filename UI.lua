local Library = {}
local TweenService = game:GetService("TweenService")

function Library:CreateWindow(name)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local CloseButton = Instance.new("TextButton")
    local MinimizeButton = Instance.new("TextButton")
    local TabButtons = Instance.new("ScrollingFrame")
    local TabListLayout = Instance.new("UIListLayout")
    local ContentHolder = Instance.new("Frame")
    
    -- ScreenGui
    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = name
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
    MainFrame.Size = UDim2.new(0, 500, 0, 350)
    MainFrame.ClipsDescendants = true
    
    -- Corner Radius
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame
    
    -- Stroke
    local UIStroke = Instance.new("UIStroke")
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    UIStroke.Color = Color3.fromRGB(255, 0, 0)
    UIStroke.Thickness = 1
    UIStroke.Parent = MainFrame
    
    -- Top Bar
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    
    local TopBarCorner = Instance.new("UICorner")
    TopBarCorner.CornerRadius = UDim.new(0, 8)
    TopBarCorner.Parent = TopBar
    
    -- Title
    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.0
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = name
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Close Button
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TopBar
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    CloseButton.BorderSizePixel = 0
    CloseButton.Position = UDim2.new(1, -30, 0, 5)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "X"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 12
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 4)
    CloseCorner.Parent = CloseButton
    
    -- Minimize Button
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = TopBar
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Position = UDim2.new(1, -55, 0, 5)
    MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "_"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 12
    
    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 4)
    MinimizeCorner.Parent = MinimizeButton
    
    -- Tab Buttons
    TabButtons.Name = "TabButtons"
    TabButtons.Parent = MainFrame
    TabButtons.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabButtons.BorderSizePixel = 0
    TabButtons.Position = UDim2.new(0, 0, 0, 30)
    TabButtons.Size = UDim2.new(0, 120, 0, 320)
    TabButtons.ScrollBarThickness = 3
    TabButtons.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
    
    TabListLayout.Parent = TabButtons
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)
    
    -- Content Holder
    ContentHolder.Name = "ContentHolder"
    ContentHolder.Parent = MainFrame
    ContentHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    ContentHolder.BorderSizePixel = 0
    ContentHolder.Position = UDim2.new(0, 120, 0, 30)
    ContentHolder.Size = UDim2.new(0, 380, 0, 320)
    
    -- Dragging
    local dragging = false
    local dragInput, dragStart, startPos
    
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    -- Button Functions
    CloseButton.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    
    local minimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        minimized = not minimized
        if minimized then
            MainFrame.Size = UDim2.new(0, 500, 0, 30)
        else
            MainFrame.Size = UDim2.new(0, 500, 0, 350)
        end
    end)
    
    local tabFunctions = {}
    
    function tabFunctions:CreateTab(tabName, icon)
        local TabButton = Instance.new("TextButton")
        local TabIcon = Instance.new("ImageLabel")
        local TabContent = Instance.new("ScrollingFrame")
        local ContentLayout = Instance.new("UIListLayout")
        
        -- Tab Button
        TabButton.Name = tabName
        TabButton.Parent = TabButtons
        TabButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TabButton.BorderSizePixel = 0
        TabButton.Size = UDim2.new(0, 110, 0, 30)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = "  " .. tabName
        TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        TabButton.TextSize = 12
        TabButton.TextXAlignment = Enum.TextXAlignment.Left
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabButton
        
        -- Tab Icon
        if icon then
            TabIcon.Name = "TabIcon"
            TabIcon.Parent = TabButton
            TabIcon.BackgroundTransparency = 1
            TabIcon.Position = UDim2.new(0, 8, 0, 5)
            TabIcon.Size = UDim2.new(0, 20, 0, 20)
            TabIcon.Image = icon
        end
        
        -- Tab Content
        TabContent.Name = tabName
        TabContent.Parent = ContentHolder
        TabContent.BackgroundTransparency = 1
        TabContent.BorderSizePixel = 0
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.ScrollBarThickness = 3
        TabContent.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
        TabContent.Visible = false
        
        ContentLayout.Parent = TabContent
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContentLayout.Padding = UDim.new(0, 5)
        
        -- Tab Selection
        TabButton.MouseButton1Click:Connect(function()
            for _, child in ipairs(ContentHolder:GetChildren()) do
                if child:IsA("ScrollingFrame") then
                    child.Visible = false
                end
            end
            TabContent.Visible = true
            
            -- Update tab buttons appearance
            for _, btn in ipairs(TabButtons:GetChildren()) do
                if btn:IsA("TextButton") then
                    btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
                end
            end
            TabButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        end)
        
        -- Select first tab
        if #TabButtons:GetChildren() == 1 then
            TabButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabContent.Visible = true
        end
        
        local contentFunctions = {}
        
        function contentFunctions:CreateSection(sectionName)
            local Section = Instance.new("Frame")
            local SectionTitle = Instance.new("TextLabel")
            local SectionContent = Instance.new("Frame")
            local SectionLayout = Instance.new("UIListLayout")
            
            Section.Name = sectionName
            Section.Parent = TabContent
            Section.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Section.BorderSizePixel = 0
            Section.Size = UDim2.new(0, 360, 0, 0)
            Section.LayoutOrder = #TabContent:GetChildren()
            
            local SectionCorner = Instance.new("UICorner")
            SectionCorner.CornerRadius = UDim.new(0, 6)
            SectionCorner.Parent = Section
            
            local SectionStroke = Instance.new("UIStroke")
            SectionStroke.Color = Color3.fromRGB(50, 50, 50)
            SectionStroke.Thickness = 1
            SectionStroke.Parent = Section
            
            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Section
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Position = UDim2.new(0, 10, 0, 5)
            SectionTitle.Size = UDim2.new(1, -20, 0, 20)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = sectionName
            SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SectionTitle.TextSize = 12
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            SectionContent.Name = "SectionContent"
            SectionContent.Parent = Section
            SectionContent.BackgroundTransparency = 1
            SectionContent.Position = UDim2.new(0, 0, 0, 30)
            SectionContent.Size = UDim2.new(1, 0, 0, 0)
            
            SectionLayout.Parent = SectionContent
            SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionLayout.Padding = UDim.new(0, 5)
            
            SectionLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionContent.Size = UDim2.new(1, 0, 0, SectionLayout.AbsoluteContentSize.Y)
                Section.Size = UDim2.new(0, 360, 0, SectionLayout.AbsoluteContentSize.Y + 35)
            end)
            
            local sectionFunctions = {}
            
            function sectionFunctions:CreateButton(buttonName, callback)
                local Button = Instance.new("TextButton")
                
                Button.Name = buttonName
                Button.Parent = SectionContent
                Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Button.BorderSizePixel = 0
                Button.Size = UDim2.new(0, 340, 0, 30)
                Button.Font = Enum.Font.Gotham
                Button.Text = buttonName
                Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                Button.TextSize = 12
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 4)
                ButtonCorner.Parent = Button
                
                local ButtonStroke = Instance.new("UIStroke")
                ButtonStroke.Color = Color3.fromRGB(255, 0, 0)
                ButtonStroke.Thickness = 1
                ButtonStroke.Parent = Button
                
                Button.MouseButton1Click:Connect(function()
                    callback()
                end)
                
                Button.MouseEnter:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}):Play()
                end)
                
                Button.MouseLeave:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}):Play()
                end)
            end
            
            function sectionFunctions:CreateToggle(toggleName, default, callback)
                local Toggle = Instance.new("Frame")
                local ToggleButton = Instance.new("TextButton")
                local ToggleLabel = Instance.new("TextLabel")
                local ToggleState = Instance.new("Frame")
                
                Toggle.Name = toggleName
                Toggle.Parent = SectionContent
                Toggle.BackgroundTransparency = 1
                Toggle.Size = UDim2.new(0, 340, 0, 25)
                
                ToggleLabel.Name = "ToggleLabel"
                ToggleLabel.Parent = Toggle
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Position = UDim2.new(0, 0, 0, 0)
                ToggleLabel.Size = UDim2.new(0, 250, 1, 0)
                ToggleLabel.Font = Enum.Font.Gotham
                ToggleLabel.Text = toggleName
                ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                ToggleLabel.TextSize = 12
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                ToggleButton.Name = "ToggleButton"
                ToggleButton.Parent = Toggle
                ToggleButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                ToggleButton.BorderSizePixel = 0
                ToggleButton.Position = UDim2.new(1, -40, 0, 2)
                ToggleButton.Size = UDim2.new(0, 36, 0, 21)
                ToggleButton.Text = ""
                
                local ToggleCorner = Instance.new("UICorner")
                ToggleCorner.CornerRadius = UDim.new(0, 10)
                ToggleCorner.Parent = ToggleButton
                
                local ToggleStroke = Instance.new("UIStroke")
                ToggleStroke.Color = Color3.fromRGB(255, 0, 0)
                ToggleStroke.Thickness = 1
                ToggleStroke.Parent = ToggleButton
                
                ToggleState.Name = "ToggleState"
                ToggleState.Parent = ToggleButton
                ToggleState.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                ToggleState.BorderSizePixel = 0
                ToggleState.Position = UDim2.new(0, 2, 0, 2)
                ToggleState.Size = UDim2.new(0, 17, 0, 17)
                
                local StateCorner = Instance.new("UICorner")
                StateCorner.CornerRadius = UDim.new(0, 8)
                StateCorner.Parent = ToggleState
                
                local state = default or false
                
                local function updateToggle()
                    if state then
                        TweenService:Create(ToggleState, TweenInfo.new(0.2), {Position = UDim2.new(0, 17, 0, 2)}):Play()
                        TweenService:Create(ToggleState, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 255, 0)}):Play()
                    else
                        TweenService:Create(ToggleState, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0, 2)}):Play()
                        TweenService:Create(ToggleState, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
                    end
                    callback(state)
                end
                
                ToggleButton.MouseButton1Click:Connect(function()
                    state = not state
                    updateToggle()
                end)
                
                updateToggle()
                
                local toggleFunctions = {}
                
                function toggleFunctions:Set(value)
                    state = value
                    updateToggle()
                end
                
                return toggleFunctions
            end
            
            function sectionFunctions:CreateSlider(sliderName, min, max, default, callback)
                local Slider = Instance.new("Frame")
                local SliderLabel = Instance.new("TextLabel")
                local SliderValue = Instance.new("TextLabel")
                local SliderTrack = Instance.new("Frame")
                local SliderFill = Instance.new("Frame")
                local SliderButton = Instance.new("TextButton")
                
                Slider.Name = sliderName
                Slider.Parent = SectionContent
                Slider.BackgroundTransparency = 1
                Slider.Size = UDim2.new(0, 340, 0, 40)
                
                SliderLabel.Name = "SliderLabel"
                SliderLabel.Parent = Slider
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Position = UDim2.new(0, 0, 0, 0)
                SliderLabel.Size = UDim2.new(0, 200, 0, 20)
                SliderLabel.Font = Enum.Font.Gotham
                SliderLabel.Text = sliderName
                SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderLabel.TextSize = 12
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                SliderValue.Name = "SliderValue"
                SliderValue.Parent = Slider
                SliderValue.BackgroundTransparency = 1
                SliderValue.Position = UDim2.new(1, -60, 0, 0)
                SliderValue.Size = UDim2.new(0, 60, 0, 20)
                SliderValue.Font = Enum.Font.Gotham
                SliderValue.Text = tostring(default or min)
                SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                SliderValue.TextSize = 12
                SliderValue.TextXAlignment = Enum.TextXAlignment.Right
                
                SliderTrack.Name = "SliderTrack"
                SliderTrack.Parent = Slider
                SliderTrack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                SliderTrack.BorderSizePixel = 0
                SliderTrack.Position = UDim2.new(0, 0, 0, 25)
                SliderTrack.Size = UDim2.new(1, 0, 0, 6)
                
                local TrackCorner = Instance.new("UICorner")
                TrackCorner.CornerRadius = UDim.new(0, 3)
                TrackCorner.Parent = SliderTrack
                
                SliderFill.Name = "SliderFill"
                SliderFill.Parent = SliderTrack
                SliderFill.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                SliderFill.BorderSizePixel = 0
                SliderFill.Size = UDim2.new(0, 0, 1, 0)
                
                local FillCorner = Instance.new("UICorner")
                FillCorner.CornerRadius = UDim.new(0, 3)
                FillCorner.Parent = SliderFill
                
                SliderButton.Name = "SliderButton"
                SliderButton.Parent = SliderTrack
                SliderButton.BackgroundTransparency = 1
                SliderButton.Size = UDim2.new(1, 0, 1, 0)
                SliderButton.Text = ""
                SliderButton.ZIndex = 2
                
                local value = default or min
                local sliding = false
                
                local function updateSlider(input)
                    local pos = UDim2.new(0, math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1), 0, 0)
                    local newValue = math.floor(min + (max - min) * pos.X.Scale)
                    
                    if newValue ~= value then
                        value = newValue
                        SliderValue.Text = tostring(value)
                        SliderFill.Size = UDim2.new(pos.X.Scale, 0, 1, 0)
                        callback(value)
                    end
                end
                
                SliderButton.MouseButton1Down:Connect(function()
                    sliding = true
                    updateSlider(game:GetService("UserInputService"):GetMouseLocation())
                end)
                
                game:GetService("UserInputService").InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        sliding = false
                    end
                end)
                
                game:GetService("UserInputService").InputChanged:Connect(function(input)
                    if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then
                        updateSlider(input)
                    end
                end)
                
                -- Set initial value
                local initialScale = (value - min) / (max - min)
                SliderFill.Size = UDim2.new(initialScale, 0, 1, 0)
                
                local sliderFunctions = {}
                
                function sliderFunctions:Set(newValue)
                    value = math.clamp(newValue, min, max)
                    SliderValue.Text = tostring(value)
                    local scale = (value - min) / (max - min)
                    SliderFill.Size = UDim2.new(scale, 0, 1, 0)
                    callback(value)
                end
                
                return sliderFunctions
            end
            
            function sectionFunctions:CreateDropdown(dropdownName, options, default, callback)
                local Dropdown = Instance.new("Frame")
                local DropdownButton = Instance.new("TextButton")
                local DropdownLabel = Instance.new("TextLabel")
                local DropdownValue = Instance.new("TextLabel")
                local DropdownArrow = Instance.new("ImageLabel")
                local DropdownList = Instance.new("ScrollingFrame")
                local ListLayout = Instance.new("UIListLayout")
                
                Dropdown.Name = dropdownName
                Dropdown.Parent = SectionContent
                Dropdown.BackgroundTransparency = 1
                Dropdown.Size = UDim2.new(0, 340, 0, 30)
                
                DropdownButton.Name = "DropdownButton"
                DropdownButton.Parent = Dropdown
                DropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                DropdownButton.BorderSizePixel = 0
                DropdownButton.Size = UDim2.new(1, 0, 0, 30)
                DropdownButton.Text = ""
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 4)
                ButtonCorner.Parent = DropdownButton
                
                local ButtonStroke = Instance.new("UIStroke")
                ButtonStroke.Color = Color3.fromRGB(255, 0, 0)
                ButtonStroke.Thickness = 1
                ButtonStroke.Parent = DropdownButton
                
                DropdownLabel.Name = "DropdownLabel"
                DropdownLabel.Parent = DropdownButton
                DropdownLabel.BackgroundTransparency = 1
                DropdownLabel.Position = UDim2.new(0, 10, 0, 0)
                DropdownLabel.Size = UDim2.new(0, 150, 1, 0)
                DropdownLabel.Font = Enum.Font.Gotham
                DropdownLabel.Text = dropdownName
                DropdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownLabel.TextSize = 12
                DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                
                DropdownValue.Name = "DropdownValue"
                DropdownValue.Parent = DropdownButton
                DropdownValue.BackgroundTransparency = 1
                DropdownValue.Position = UDim2.new(1, -60, 0, 0)
                DropdownValue.Size = UDim2.new(0, 40, 1, 0)
                DropdownValue.Font = Enum.Font.Gotham
                DropdownValue.Text = default or options[1] or ""
                DropdownValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                DropdownValue.TextSize = 12
                DropdownValue.TextXAlignment = Enum.TextXAlignment.Right
                
                DropdownArrow.Name = "DropdownArrow"
                DropdownArrow.Parent = DropdownButton
                DropdownArrow.BackgroundTransparency = 1
                DropdownArrow.Position = UDim2.new(1, -15, 0, 7)
                DropdownArrow.Size = UDim2.new(0, 16, 0, 16)
                DropdownArrow.Image = "rbxassetid://6031091004"
                DropdownArrow.ImageColor3 = Color3.fromRGB(255, 255, 255)
                
                DropdownList.Name = "DropdownList"
                DropdownList.Parent = Dropdown
                DropdownList.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                DropdownList.BorderSizePixel = 0
                DropdownList.Position = UDim2.new(0, 0, 1, 5)
                DropdownList.Size = UDim2.new(1, 0, 0, 0)
                DropdownList.ScrollBarThickness = 3
                DropdownList.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
                DropdownList.Visible = false
                DropdownList.ClipsDescendants = true
                
                local ListCorner = Instance.new("UICorner")
                ListCorner.CornerRadius = UDim.new(0, 4)
                ListCorner.Parent = DropdownList
                
                ListLayout.Parent = DropdownList
                ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                
                local open = false
                local selected = default or options[1]
                
                local function toggleDropdown()
                    open = not open
                    if open then
                        DropdownList.Visible = true
                        TweenService:Create(DropdownList, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, math.min(#options * 25, 100))}):Play()
                        TweenService:Create(DropdownArrow, TweenInfo.new(0.2), {Rotation = 180}):Play()
                    else
                        TweenService:Create(DropdownList, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 0)}):Play()
                        TweenService:Create(DropdownArrow, TweenInfo.new(0.2), {Rotation = 0}):Play()
                        wait(0.2)
                        DropdownList.Visible = false
                    end
                end
                
                DropdownButton.MouseButton1Click:Connect(toggleDropdown)
                
                -- Create option buttons
                for _, option in ipairs(options) do
                    local OptionButton = Instance.new("TextButton")
                    
                    OptionButton.Name = option
                    OptionButton.Parent = DropdownList
                    OptionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    OptionButton.BorderSizePixel = 0
                    OptionButton.Size = UDim2.new(1, 0, 0, 25)
                    OptionButton.Font = Enum.Font.Gotham
                    OptionButton.Text = option
                    OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    OptionButton.TextSize = 12
                    
                    OptionButton.MouseButton1Click:Connect(function()
                        selected = option
                        DropdownValue.Text = option
                        toggleDropdown()
                        callback(option)
                    end)
                end
                
                ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    DropdownList.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
                end)
                
                local dropdownFunctions = {}
                
                function dropdownFunctions:Set(value)
                    if table.find(options, value) then
                        selected = value
                        DropdownValue.Text = value
                        callback(value)
                    end
                end
                
                return dropdownFunctions
            end
            
            return sectionFunctions
        end
        
        return contentFunctions
    end
    
    return tabFunctions
end

return Library
