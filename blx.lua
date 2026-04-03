-- =========================================================
-- PHATHUB PRO -4/3/2026 (Cleaned)
-- =========================================================

-- SERVICES
local v1 = game:GetService("Players")
local v2 = game:GetService("RunService")
local v3 = game:GetService("UserInputService")
local v4 = game:GetService("StarterGui")
local v5 = game:GetService("TweenService")

local v6 = v1.LocalPlayer
local v7 = workspace.CurrentCamera

-- BONES SETUP
local v8={{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},{"LowerTorso","HumanoidRootPart"},{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},{"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},{"HumanoidRootPart","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},{"HumanoidRootPart","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"}}
local v9={{"Head","Torso"},{"Torso","HumanoidRootPart"},{"Torso","Left Arm"},{"Torso","Right Arm"},{"HumanoidRootPart","Left Leg"},{"HumanoidRootPart","Right Leg"}}

-- HIGHLIGHT CONTAINER
local v10 = Instance.new("Folder")
v10.Name = "PhatHub_Highlight_Container"
pcall(function() v10.Parent = game:GetService("CoreGui") end)

-- SETTINGS
local v11 = 50 
local v12 = 3 
local v13 = "Head" 
local v14 = "Hold" 

local v15 = false
local v16 = true
local v17 = nil 

-- NEW TOGGLE SETTINGS
local v18 = true
local v19 = true
local v20 = true
local v21 = false 
local v22 = true
local v23 = true 
local v24 = false
local v25 = true 

-- MEMORY SETTINGS
local v26 = false

local v27 = {}

-- MEMORY FUNCTION
local function v28()
    collectgarbage("collect")
    pcall(function()
        v4:SetCore("SendNotification", {
            Title = "PhatHub",
            Text = "Memory have been clear!",
            Duration = 3
        })
    end)
end

-- AUTO CLEAR MEMORY ON RESPAWN
v6.CharacterAdded:Connect(function()
    if v26 then
        task.wait(1)
        v28()
    end
end)

-- TEAM CHECK FUNCTION
local function v29(v82)
    if v82 == v6 then return false end
    if v82.Team and v6.Team then return v82.Team ~= v6.Team end
    local v83 = v6.Character
    local v84 = v82.Character
    if not v83 or not v84 or not v83.Parent or not v84.Parent then return false end
    return v83.Parent.Name ~= v84.Parent.Name
end

-- TARGET VALIDATION
local function v30(v85)
    if not v85 or not v85.Parent then return false end
    local v86 = v85.Parent:FindFirstChildOfClass("Humanoid")
    if not v86 or v86.Health <= 0 then return false end
    
    if v19 then
        local v82 = v1:GetPlayerFromCharacter(v85.Parent)
        if v82 and not v29(v82) then return false end
    end
    return true
end

-- FOV CIRCLE
local v31 = Drawing.new("Circle")
v31.Radius = v11
v31.Thickness = 2
v31.Color = Color3.fromRGB(255, 0, 0)
v31.Filled = false
v31.Visible = true

-- ==========================================
-- GUI SETUP
-- ==========================================
local v32 = Instance.new("ScreenGui", game.CoreGui)
v32.Name = "PhatHub_Pro_UI"

local v33 = Instance.new("Frame", v32)
v33.Size = UDim2.new(0, 450, 0, 260)
v33.Position = UDim2.new(0.5, -225, 0.5, -130)
v33.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
v33.BorderSizePixel = 2
v33.BorderColor3 = Color3.fromRGB(0, 255, 255)
v33.Active = true
v33.Draggable = true

local v34 = Instance.new("TextLabel", v33)
v34.Size = UDim2.new(1, -30, 0, 30)
v34.Text = " PhatHub Instructions / Hướng dẫn"
v34.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
v34.TextColor3 = Color3.new(1, 1, 1)
v34.Font = Enum.Font.GothamBold
v34.TextSize = 14
v34.TextXAlignment = Enum.TextXAlignment.Left

local v35 = Instance.new("TextButton", v33)
v35.Size = UDim2.new(0, 30, 0, 30)
v35.Position = UDim2.new(1, -30, 0, 0)
v35.Text = "X"
v35.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
v35.TextColor3 = Color3.new(1, 1, 1)
v35.Font = Enum.Font.GothamBold
v35.TextSize = 14

local v36 = Instance.new("TextLabel", v33)
v36.Size = UDim2.new(1, -20, 1, -40)
v36.Position = UDim2.new(0, 10, 0, 35)
v36.BackgroundTransparency = 1
v36.TextColor3 = Color3.new(1, 1, 1)
v36.TextWrapped = true
v36.Font = Enum.Font.Gotham
v36.TextSize = 13
v36.TextXAlignment = Enum.TextXAlignment.Left
v36.TextYAlignment = Enum.TextYAlignment.Top
v36.Text = "Welcome to PhatHub!\n- Aiming: Choose Hold or Toggle mode in the menu, then press 'E' (or Right Click if enabled) to aim/lock target.\n- Aim Part: Press 'Alt' to quickly switch aiming between Head and Body.\n- ESP: Press 'F1' to reset ESP if it glitches.\n(This guide will auto-close in 60 seconds)\n\n--------------------------------------------------------------\n\nChào mừng đến với PhatHub!\n- Ngắm bắn (Aim): Chọn chế độ Hold/Toggle, nhấn 'E' (hoặc Chuột Phải nếu đã bật) để ngắm.\n- Vị trí ngắm: Nhấn phím 'Alt' để chuyển đổi nhanh giữa Đầu và Thân.\n- ESP: Nhấn phím 'F1' để làm mới ESP nếu bị lỗi.\n(Bảng hướng dẫn này sẽ tự đóng sau 60 giây)"

v35.MouseButton1Click:Connect(function()
    v33:Destroy()
end)

task.delay(60, function()
    if v33 and v33.Parent then
        v33:Destroy()
    end
end)

local v37 = Instance.new("Frame", v32)
v37.Size = UDim2.new(0, 450, 0, 280) 
v37.Position = UDim2.new(0, 50, 0, 50)
v37.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
v37.Active = true
v37.Draggable = true
v37.ClipsDescendants = true 

local v38 = Instance.new("TextLabel", v37)
v38.Size = UDim2.new(1, -60, 0, 30)
v38.Text = " PhatHub (Pro) - Press 'P' to Minimize/Expand"
v38.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
v38.TextColor3 = Color3.new(1, 1, 1)
v38.Font = Enum.Font.GothamBold
v38.TextSize = 14
v38.TextXAlignment = Enum.TextXAlignment.Left

local v39 = Instance.new("TextButton", v37)
v39.Size = UDim2.new(0, 30, 0, 30)
v39.Position = UDim2.new(1, -30, 0, 0)
v39.Text = "X"
v39.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
v39.TextColor3 = Color3.new(1, 1, 1)
v39.Font = Enum.Font.GothamBold
v39.TextSize = 14

local v40 = Instance.new("TextButton", v37)
v40.Size = UDim2.new(0, 30, 0, 30)
v40.Position = UDim2.new(1, -60, 0, 0)
v40.Text = "-"
v40.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
v40.TextColor3 = Color3.new(1, 1, 1)
v40.Font = Enum.Font.GothamBold
v40.TextSize = 18

local v41 = Instance.new("Frame", v37)
v41.Size = UDim2.new(1, 0, 0, 35)
v41.Position = UDim2.new(0, 0, 0, 30)
v41.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

local v42 = Instance.new("TextButton", v41)
v42.Size = UDim2.new(0.5, 0, 1, 0)
v42.Text = "COMBAT"
v42.Font = Enum.Font.GothamBold
v42.TextSize = 15
v42.BackgroundColor3 = Color3.fromRGB(60, 150, 60)
v42.TextColor3 = Color3.new(1, 1, 1)

local v43 = Instance.new("TextButton", v41)
v43.Size = UDim2.new(0.5, 0, 1, 0)
v43.Position = UDim2.new(0.5, 0, 0, 0)
v43.Text = "VISUAL"
v43.Font = Enum.Font.GothamBold
v43.TextSize = 15
v43.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
v43.TextColor3 = Color3.new(1, 1, 1)

local v44 = Instance.new("Frame", v37)
v44.Size = UDim2.new(1, -20, 1, -75)
v44.Position = UDim2.new(0, 10, 0, 70)
v44.BackgroundTransparency = 1
v44.Visible = true

local v45 = Instance.new("Frame", v37)
v45.Size = UDim2.new(1, -20, 1, -75)
v45.Position = UDim2.new(0, 10, 0, 70)
v45.BackgroundTransparency = 1
v45.Visible = false

local function v46(v105)
    local v106 = Instance.new("UIGridLayout", v105)
    v106.CellSize = UDim2.new(0.5, -5, 0, 32)
    v106.CellPadding = UDim2.new(0, 10, 0, 8)
    v106.SortOrder = Enum.SortOrder.LayoutOrder
end
v46(v44)
v46(v45)

v42.MouseButton1Click:Connect(function()
    v44.Visible = true
    v45.Visible = false
    v42.BackgroundColor3 = Color3.fromRGB(60, 150, 60)
    v43.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
end)

v43.MouseButton1Click:Connect(function()
    v44.Visible = false
    v45.Visible = true
    v42.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    v43.BackgroundColor3 = Color3.fromRGB(60, 150, 60)
end)

local v47 = Instance.new("TextLabel", v44)
v47.BackgroundTransparency = 1
v47.TextColor3 = Color3.new(1, 1, 1)
v47.Font = Enum.Font.GothamBold
v47.TextSize = 22 
v47.Text = "AIM : OFF"
v47.LayoutOrder = 1

local v48 = Instance.new("TextBox", v44)
v48.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
v48.TextColor3 = Color3.new(1, 1, 1)
v48.Font = Enum.Font.GothamBold
v48.TextSize = 15
v48.Text = "FOV: " .. v11
v48.ClearTextOnFocus = true
v48.LayoutOrder = 2

local v49 = Instance.new("TextBox", v44)
v49.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
v49.TextColor3 = Color3.fromRGB(255, 255, 0)
v49.Font = Enum.Font.GothamBold
v49.TextSize = 15
v49.Text = "Smooth: " .. v12
v49.ClearTextOnFocus = true
v49.LayoutOrder = 3

local v50 = Instance.new("TextButton", v44)
v50.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
v50.TextColor3 = Color3.fromRGB(0, 255, 255)
v50.Text = "Aim Part: HEAD"
v50.Font = Enum.Font.GothamBold
v50.TextSize = 15
v50.LayoutOrder = 4

local v51 = Instance.new("TextButton", v44)
v51.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
v51.TextColor3 = Color3.fromRGB(255, 170, 0)
v51.Text = "Aim Mode: HOLD"
v51.Font = Enum.Font.GothamBold
v51.TextSize = 15
v51.LayoutOrder = 5

local v52 = Instance.new("TextButton", v44)
v52.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
v52.TextColor3 = Color3.new(1, 1, 1)
v52.Text = "Team Check: ON"
v52.Font = Enum.Font.GothamBold
v52.TextSize = 15
v52.LayoutOrder = 6

local v53 = Instance.new("TextButton", v44)
v53.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
v53.TextColor3 = Color3.fromRGB(0, 255, 0)
v53.Text = "Aim Right Click: ON" 
v53.Font = Enum.Font.GothamBold
v53.TextSize = 15
v53.LayoutOrder = 7

local v54 = Instance.new("TextButton", v45)
v54.Text = "ESP : ON (F1: Reset)"
v54.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
v54.TextColor3 = Color3.new(1, 1, 1)
v54.Font = Enum.Font.GothamBold
v54.TextSize = 15
v54.LayoutOrder = 1

local v55 = Instance.new("TextButton", v45)
v55.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
v55.TextColor3 = Color3.new(1, 1, 1)
v55.Text = "Highlight: " .. (v23 and "ON" or "OFF")
v55.Font = Enum.Font.GothamBold
v55.TextSize = 15
v55.LayoutOrder = 2

local v56 = Instance.new("TextButton", v45)
v56.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
v56.TextColor3 = Color3.new(1, 1, 1)
v56.Text = "Box ESP: ON"
v56.Font = Enum.Font.GothamBold
v56.TextSize = 15
v56.LayoutOrder = 3

local v57 = Instance.new("TextButton", v45)
v57.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
v57.TextColor3 = Color3.new(1, 1, 1)
v57.Text = "Skeleton ESP: " .. (v21 and "ON" or "OFF")
v57.Font = Enum.Font.GothamBold
v57.TextSize = 15
v57.LayoutOrder = 4

local v58 = Instance.new("TextButton", v45)
v58.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
v58.TextColor3 = Color3.new(1, 1, 1)
v58.Text = "Health Bar: ON"
v58.Font = Enum.Font.GothamBold
v58.TextSize = 15
v58.LayoutOrder = 5

local v59 = Instance.new("TextButton", v45)
v59.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
v59.TextColor3 = Color3.new(1, 1, 1)
v59.Text = "Tracer: OFF"
v59.Font = Enum.Font.GothamBold
v59.TextSize = 15
v59.LayoutOrder = 6

local v60 = Instance.new("TextButton", v45)
v60.BackgroundColor3 = Color3.fromRGB(150, 60, 60)
v60.TextColor3 = Color3.new(1, 1, 1)
v60.Text = "Clear Memory"
v60.Font = Enum.Font.GothamBold
v60.TextSize = 15
v60.LayoutOrder = 7

local v61 = Instance.new("TextButton", v45)
v61.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
v61.TextColor3 = Color3.fromRGB(255, 100, 100)
v61.Text = "Auto Clear: OFF"
v61.Font = Enum.Font.GothamBold
v61.TextSize = 15
v61.LayoutOrder = 8

local v62 = Instance.new("Frame", v32)
v62.Size = UDim2.new(0, 150, 0, 75) 
v62.Position = UDim2.new(0.5, 100, 0.5, -30)
v62.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
v62.BorderSizePixel = 2
v62.BorderColor3 = Color3.fromRGB(255, 0, 0)
v62.Active = true
v62.Draggable = true
v62.Visible = false

local v63 = Instance.new("TextLabel", v62)
v63.Size = UDim2.new(1, 0, 0.4, 0)
v63.BackgroundTransparency = 1
v63.TextColor3 = Color3.new(1, 1, 1)
v63.Font = Enum.Font.GothamBold
v63.TextSize = 14
v63.Text = "Name"

local v64 = Instance.new("TextLabel", v62)
v64.Size = UDim2.new(1, 0, 0.4, 0)
v64.Position = UDim2.new(0, 0, 0.4, 0)
v64.BackgroundTransparency = 1
v64.TextColor3 = Color3.fromRGB(0, 255, 0)
v64.Font = Enum.Font.GothamBold
v64.TextSize = 14
v64.Text = "HP: 100/100"

local v65 = Instance.new("TextLabel", v62)
v65.Size = UDim2.new(1, 0, 0.2, 0)
v65.Position = UDim2.new(0, 0, 0.8, 0)
v65.BackgroundTransparency = 1
v65.TextColor3 = Color3.fromRGB(200, 200, 200)
v65.Font = Enum.Font.Gotham
v65.TextSize = 12
v65.Text = "Aim Assist: HEAD"

local function v66()
    local v67 = {
        Main = Color3.fromRGB(22, 24, 32),
        Panel = Color3.fromRGB(30, 34, 46),
        Panel2 = Color3.fromRGB(40, 45, 60),
        Accent = Color3.fromRGB(0, 200, 255),
        Accent2 = Color3.fromRGB(120, 90, 255),
        Text = Color3.fromRGB(240, 240, 245),
        Sub = Color3.fromRGB(180, 185, 200),
        Danger = Color3.fromRGB(255, 85, 85),
        Success = Color3.fromRGB(0, 255, 140),
        Warn = Color3.fromRGB(255, 180, 0),
        Btn = Color3.fromRGB(45, 50, 68),
        BtnHover = Color3.fromRGB(58, 64, 88),
        Stroke = Color3.fromRGB(90, 120, 255)
    }

    local function v68(v107, v108)
        if not v107:FindFirstChildOfClass("UICorner") then
            local v109 = Instance.new("UICorner")
            v109.CornerRadius = UDim.new(0, v108 or 10)
            v109.Parent = v107
        end
    end

    local function v69(v110, v111, v112, v113)
        local v114 = v110:FindFirstChildOfClass("UIStroke") or Instance.new("UIStroke")
        v114.Color = v111 or v67.Stroke
        v114.Thickness = v112 or 1.2
        v114.Transparency = v113 or 0.15
        v114.Parent = v110
    end

    local function v70(v115, v116, v117, v118)
        local v119 = v115:FindFirstChildOfClass("UIGradient") or Instance.new("UIGradient")
        v119.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, v116),
            ColorSequenceKeypoint.new(1, v117)
        })
        v119.Rotation = v118 or 90
        v119.Parent = v115
    end

    local function v71(v120, v121)
        v120.AutoButtonColor = false
        v120.BackgroundColor3 = v67.Btn
        v120.TextColor3 = v67.Text
        v120.Font = Enum.Font.GothamBold
        v120.TextSize = v120.TextSize > 0 and v120.TextSize or 14
        v120.BorderSizePixel = 0
        v68(v120, 10)
        v69(v120, v121 or Color3.fromRGB(95, 105, 140), 1.1, 0.2)

        local v122 = v5:Create(v120, TweenInfo.new(0.14), {BackgroundColor3 = v67.BtnHover})
        local v123 = v5:Create(v120, TweenInfo.new(0.14), {BackgroundColor3 = v67.Btn})

        v120.MouseEnter:Connect(function() v122:Play() end)
        v120.MouseLeave:Connect(function() v123:Play() end)
    end

    local function v72(v124)
        v124.BackgroundColor3 = v67.Btn
        v124.TextColor3 = v67.Text
        v124.PlaceholderColor3 = v67.Sub
        v124.Font = Enum.Font.GothamBold
        v124.TextSize = v124.TextSize > 0 and v124.TextSize or 14
        v124.BorderSizePixel = 0
        v68(v124, 10)
        v69(v124, Color3.fromRGB(100, 110, 145), 1.1, 0.22)
    end

    local function v73(v125, v126, v127, v128)
        v125.TextColor3 = v126 or v67.Text
        v125.Font = v128 and Enum.Font.GothamBold or Enum.Font.Gotham
        if v127 then v125.TextSize = v127 end
        if v125.BackgroundTransparency ~= 1 then
            v125.BorderSizePixel = 0
        end
    end

    if v32 then
        v32.IgnoreGuiInset = true
        v32.ResetOnSpawn = false
    end

    if v37 then
        v37.BackgroundColor3 = v67.Main
        v37.BorderSizePixel = 0
        v68(v37, 14)
        v69(v37, v67.Accent, 1.4, 0.08)
        v70(v37, Color3.fromRGB(34, 38, 54), Color3.fromRGB(18, 20, 28), 90)
    end

    if v38 then
        v38.BackgroundColor3 = v67.Panel2
        v38.BorderSizePixel = 0
        v73(v38, v67.Text, 15, true)
        v68(v38, 14)
    end

    if v39 then
        v39.BackgroundColor3 = v67.Danger
        v39.TextColor3 = Color3.new(1,1,1)
        v39.BorderSizePixel = 0
        v68(v39, 10)
    end

    if v40 then
        v40.BackgroundColor3 = v67.Btn
        v40.TextColor3 = v67.Text
        v40.BorderSizePixel = 0
        v68(v40, 10)
        v69(v40, Color3.fromRGB(120, 125, 155), 1, 0.2)
    end

    if v33 and v33.Parent then
        v33.BackgroundColor3 = v67.Main
        v33.BorderSizePixel = 0
        v68(v33, 14)
        v69(v33, v67.Accent, 1.4, 0.08)
        v70(v33, Color3.fromRGB(36, 40, 58), Color3.fromRGB(20, 22, 30), 90)
    end

    if v34 then
        v34.BackgroundColor3 = v67.Panel2
        v34.BorderSizePixel = 0
        v73(v34, v67.Text, 15, true)
        v68(v34, 14)
    end

    if v35 then
        v35.BackgroundColor3 = v67.Danger
        v35.TextColor3 = Color3.new(1,1,1)
        v35.BorderSizePixel = 0
        v68(v35, 10)
    end

    if v36 then
        v73(v36, v67.Text, 13, false)
    end

    if v41 then
        v41.BackgroundColor3 = v67.Panel
        v41.BorderSizePixel = 0
        v68(v41, 12)
    end

    if v42 then
        v42.BackgroundColor3 = v67.Accent2
        v42.TextColor3 = Color3.new(1,1,1)
        v42.BorderSizePixel = 0
        v42.Font = Enum.Font.GothamBold
        v68(v42, 10)
    end

    if v43 then
        v43.BackgroundColor3 = v67.Btn
        v43.TextColor3 = v67.Text
        v43.BorderSizePixel = 0
        v43.Font = Enum.Font.GothamBold
        v68(v43, 10)
    end

    if v47 then v73(v47, Color3.fromRGB(255,90,90), 22, true) end
    if v48 then v72(v48) end
    if v49 then v72(v49) end
    if v50 then v71(v50, v67.Accent) v50.TextColor3 = Color3.fromRGB(120,255,255) end
    if v51 then v71(v51, v67.Warn) v51.TextColor3 = Color3.fromRGB(255,200,80) end
    if v52 then v71(v52) end
    if v53 then v71(v53, Color3.fromRGB(0, 255, 0)) v53.TextColor3 = Color3.fromRGB(0, 255, 0) end 

    if v54 then v71(v54, v67.Accent) end
    if v55 then v71(v55) end
    if v56 then v71(v56) end
    if v57 then v71(v57) end
    if v58 then v71(v58) end
    if v59 then v71(v59) end
    if v60 then v71(v60, v67.Danger) v60.BackgroundColor3 = Color3.fromRGB(130,55,55) end
    if v61 then v71(v61, Color3.fromRGB(255,120,120)) v61.TextColor3 = Color3.fromRGB(255,120,120) end

    if v62 then
        v62.BackgroundColor3 = v67.Panel
        v62.BorderSizePixel = 0
        v68(v62, 12)
        v69(v62, Color3.fromRGB(255,0,0), 1.4, 0.06)
        v70(v62, Color3.fromRGB(44, 48, 66), Color3.fromRGB(24, 26, 36), 90)
    end
    if v63 then v73(v63, v67.Text, 14, true) end
    if v64 then v73(v64, v67.Success, 14, true) end
    if v65 then v73(v65, v67.Sub, 12, false) end
end

v66()

local v74 = false

local function v75()
    v74 = not v74
    if v74 then
        v40.Text = "+"
        v41.Visible = false
        v44.Visible = false
        v45.Visible = false
        v37.Size = UDim2.new(0, 250, 0, 30)
    else
        v40.Text = "-"
        v41.Visible = true
        if v42.BackgroundColor3 == Color3.fromRGB(60, 150, 60) then
            v44.Visible = true
        else
            v45.Visible = true
        end
        v37.Size = UDim2.new(0, 450, 0, 280)
    end
end

v40.MouseButton1Click:Connect(v75)

v39.MouseButton1Click:Connect(function()
    v16 = false
    for _, v89 in pairs(v27) do
        if v89.Box then v89.Box:Remove() end
        if v89.HpBg then v89.HpBg:Remove() end
        if v89.Hp then v89.Hp:Remove() end
        if v89.Tracer then v89.Tracer:Remove() end
        for _, v129 in pairs(v89.Skeleton) do v129:Remove() end
        if v89.HL then v89.HL:Destroy() end
    end
    v31:Remove()
    v10:Destroy()
    v32:Destroy()
end)

v54.MouseButton1Click:Connect(function()
    v18 = not v18
    v54.Text = "ESP : " .. (v18 and "ON (F1: Reset)" or "OFF")
end)

v48.FocusLost:Connect(function()
    local v87 = tonumber(v48.Text)
    if v87 and v87 > 0 then
        v11 = v87;
        v31.Radius = v11; v48.Text = "FOV: " .. v11
    else
        v48.Text = "FOV: " .. v11
    end
end)

v49.FocusLost:Connect(function()
    local v87 = tonumber(v49.Text)
    if v87 then
        if v87 < 3 then v87 = 3 end
        v12 = v87
        v49.Text = "Smooth: " .. v12
    else
        v49.Text = "Smooth: " .. v12
    end
end)

local function v76()
    if v13 == "Head" then
        v13 = "HumanoidRootPart"
        v50.Text = "Aim Part: BODY"
        v65.Text = "Aim Assist: BODY"
    else
        v13 = "Head"
        v50.Text = "Aim Part: HEAD"
        v65.Text = "Aim Assist: HEAD"
    end
end

v50.MouseButton1Click:Connect(v76)

v51.MouseButton1Click:Connect(function()
    if v14 == "Hold" then
        v14 = "Toggle"; v51.Text = "Aim Mode: TOGGLE"
    else
        v14 = "Hold"; v51.Text = "Aim Mode: HOLD"
        v15 = false
        v17 = nil 
    end
end)

v52.MouseButton1Click:Connect(function()
    v19 = not v19
    v52.Text = "Team Check: " .. (v19 and "ON" or "OFF")
end)

v56.MouseButton1Click:Connect(function()
    v20 = not v20
    v56.Text = "Box ESP: " .. (v20 and "ON" or "OFF")
end)

v57.MouseButton1Click:Connect(function()
    v21 = not v21
    v57.Text = "Skeleton ESP: " .. (v21 and "ON" or "OFF")
    if v21 and v23 then
        v23 = false
        v55.Text = "Highlight: OFF"
    end
end)

v58.MouseButton1Click:Connect(function()
    v22 = not v22
    v58.Text = "Health Bar: " .. (v22 and "ON" or "OFF")
end)

v55.MouseButton1Click:Connect(function()
    v23 = not v23
    v55.Text = "Highlight: " .. (v23 and "ON" or "OFF")
    if v23 and v21 then
        v21 = false
        v57.Text = "Skeleton ESP: OFF"
    end
end)

v59.MouseButton1Click:Connect(function()
    v24 = not v24
    v59.Text = "Tracer: " .. (v24 and "ON" or "OFF")
end)

v53.MouseButton1Click:Connect(function()
    v25 = not v25
    v53.Text = "Aim Right Click: " .. (v25 and "ON" or "OFF")
    if v25 then
        v53.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        v53.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

v60.MouseButton1Click:Connect(function()
    v28()
end)

v61.MouseButton1Click:Connect(function()
    v26 = not v26
    v61.Text = "Auto Clear: " .. (v26 and "ON" or "OFF")
    if v26 then
        v61.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        v61.TextColor3 = Color3.fromRGB(255, 100, 100)
    end
end)

local function v77(v88)
    if v88 == v6 then return end
    v27[v88] = {
        Box = Drawing.new("Square"),
        HpBg = Drawing.new("Line"),
        Hp = Drawing.new("Line"),
        Tracer = Drawing.new("Line"),
        Skeleton = {},
        HL = Instance.new("Highlight")
    }
    
    v27[v88].Box.Thickness = 2
    v27[v88].Box.Color = Color3.fromRGB(255, 0, 0)
    v27[v88].Box.Filled = false
    v27[v88].Box.Visible = false

    v27[v88].HpBg.Thickness = 3
    v27[v88].HpBg.Color = Color3.new(0, 0, 0)
    v27[v88].HpBg.Visible = false

    v27[v88].Hp.Thickness = 2
    v27[v88].Hp.Color = Color3.new(0, 1, 0)
    v27[v88].Hp.Visible = false
    
    v27[v88].Tracer.Thickness = 1.5
    v27[v88].Tracer.Color = Color3.new(1, 1, 1)
    v27[v88].Tracer.Visible = false

    for v130 = 1, 15 do
        local v131 = Drawing.new("Line")
        v131.Thickness = 1.5
        v131.Color = Color3.new(1, 1, 1)
        v131.Visible = false
        v27[v88].Skeleton[v130] = v131
    end
    
    v27[v88].HL.FillColor = Color3.fromRGB(255, 0, 0)
    v27[v88].HL.OutlineColor = Color3.fromRGB(255, 255, 255)
    v27[v88].HL.FillTransparency = 0.5
    v27[v88].HL.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    v27[v88].HL.Enabled = false
    v27[v88].HL.Parent = v10
end

local function v78(v88)
    if v27[v88] then
        if v27[v88].Box then v27[v88].Box:Remove() end
        if v27[v88].HpBg then v27[v88].HpBg:Remove() end
        if v27[v88].Hp then v27[v88].Hp:Remove() end
        if v27[v88].Tracer then v27[v88].Tracer:Remove() end
        for _, v132 in pairs(v27[v88].Skeleton) do v132:Remove() end
        if v27[v88].HL then v27[v88].HL:Destroy() end
        v27[v88] = nil
    end
end

local function v79()
    for v88, _ in pairs(v27) do v78(v88) end
    v27 = {} 
    for _, v133 in pairs(v1:GetPlayers()) do v77(v133) end
end

for _, v134 in pairs(v1:GetPlayers()) do v77(v134) end
v1.PlayerAdded:Connect(v77)
v1.PlayerRemoving:Connect(v78)

local function v80()
    local v104 = nil
    local v103 = v11 
    local v102 = Vector2.new(v7.ViewportSize.X / 2, v7.ViewportSize.Y / 2)

    for _, v88 in pairs(v1:GetPlayers()) do
        if v88 ~= v6 then
            if v19 and not v29(v88) then continue end
            local v90 = v88.Character
            if v90 and v90.Parent and v90:IsDescendantOf(workspace) then
                local v86 = v90:FindFirstChildOfClass("Humanoid")
                local v85 = v90:FindFirstChild(v13)
                if v86 and v85 and v86.Health > 0 then
                    local v100, v101 = v7:WorldToViewportPoint(v85.Position)
                    if v101 then
                        local v135 = (Vector2.new(v100.X, v100.Y) - v102).Magnitude
                        if v135 < v103 then
                            v103 = v135
                            v104 = v85
                        end
                    end
                end
            end
        end
    end
    return v104
end

v3.InputBegan:Connect(function(v136, v137)
    if v137 and v3:GetFocusedTextBox() then return end
    
    if v136.KeyCode == Enum.KeyCode.P then
        v75()
        return
    end

    local v138 = (v136.KeyCode == Enum.KeyCode.E) or (v25 and v136.UserInputType == Enum.UserInputType.MouseButton2)

    if v138 then
        if v14 == "Hold" then
            v15 = true
        elseif v14 == "Toggle" then
            v15 = not v15
            if not v15 then v17 = nil end
        end
    elseif v136.KeyCode == Enum.KeyCode.F1 then
        v79()
        v47.Text = "ESP RESET OK!"
        v47.TextColor3 = Color3.fromRGB(0, 255, 255)
    elseif v136.KeyCode == Enum.KeyCode.LeftAlt or v136.KeyCode == Enum.KeyCode.RightAlt then
        v76()
    end
end)

v3.InputEnded:Connect(function(v139)
    local v140 = (v139.KeyCode == Enum.KeyCode.E) or (v25 and v139.UserInputType == Enum.UserInputType.MouseButton2)
    
    if v140 then
        if v14 == "Hold" then
            v15 = false
            v17 = nil 
        end
    end
end)

v2.RenderStepped:Connect(function()
    if not v16 then return end

    local v102 = Vector2.new(v7.ViewportSize.X / 2, v7.ViewportSize.Y / 2)
    local v141 = Vector2.new(v7.ViewportSize.X / 2, v7.ViewportSize.Y) 
    v31.Position = v102

    local v81 = nil

    if v15 then
        if not v17 or not v30(v17) then
            v17 = v80()
        end

        if v17 then
            v81 = v1:GetPlayerFromCharacter(v17.Parent)
            local v93, v94 = v7:WorldToViewportPoint(v17.Position)
            
            if v94 then
                local v95 = (v93.X - v102.X) / v12
                local v96 = (v93.Y - v102.Y) / v12
                if mousemoverel then mousemoverel(v95, v96) end
            end

            if v81 and v81.Character then
                local v86 = v81.Character:FindFirstChildOfClass("Humanoid")
                if v86 then
                    v63.Text = v81.DisplayName
                    local v97 = math.floor(v86.Health)
                    local v98 = math.floor(v86.MaxHealth)
                    v64.Text = "HP: " .. v97 .. " / " .. v98
                    
                    local v99 = v97 / v98
                    if v99 > 0.6 then
                        v64.TextColor3 = Color3.fromRGB(0, 255, 0)
                    elseif v99 > 0.3 then
                        v64.TextColor3 = Color3.fromRGB(255, 170, 0)
                    else
                        v64.TextColor3 = Color3.fromRGB(255, 0, 0)
                    end
                    
                    v62.BorderColor3 = Color3.fromRGB(0, 255, 0)
                    v62.Visible = true
                end
            end

            v47.Text = "AIM : LOCKED"
            v47.TextColor3 = Color3.fromRGB(0, 255, 0)
            v31.Color = Color3.fromRGB(0, 255, 0)
        else
            v47.Text = "AIM : NO TARGET"
            v47.TextColor3 = Color3.fromRGB(255, 170, 0)
            v31.Color = Color3.fromRGB(255, 0, 0)
            v62.Visible = false
        end
    else
        v17 = nil 
        if v47.Text ~= "ESP RESET OK!" then
            v47.Text = "AIM : OFF"
            v47.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
        v31.Color = Color3.fromRGB(255, 0, 0)
        v62.Visible = false
    end

    if v47.Text == "ESP RESET OK!" and not v15 then
        task.delay(0.8, function()
            if not v15 and v47.Text == "ESP RESET OK!" then
                v47.Text = "AIM : OFF"
                v47.TextColor3 = Color3.fromRGB(255, 0, 0)
            end
        end)
    end

    for v88, v89 in pairs(v27) do
        if v89 == nil then continue end 
        local v90 = v88.Character
        local v142 = v29(v88)
        local v143 = v18 and (not v19 or v142)
        
        if v143 and v90 and v90.Parent and v90:IsDescendantOf(workspace) then
            local v86 = v90:FindFirstChildOfClass("Humanoid")
            local v91 = v90:FindFirstChild("HumanoidRootPart")
            local v92 = v90:FindFirstChild("Head")

            if v86 and v91 and v92 and v86.Health > 0 then
                
                if v23 then
                    v89.HL.Adornee = v90
                    v89.HL.Enabled = true
                    if v88 == v81 then
                        v89.HL.FillColor = Color3.fromRGB(0, 255, 0)
                    else
                        v89.HL.FillColor = Color3.fromRGB(255, 0, 0)
                    end
                else
                    v89.HL.Enabled = false
                end

                local v144, v145 = v7:WorldToViewportPoint(v91.Position)
                local v146, v147 = v7:WorldToViewportPoint(v92.Position)

                if v145 and v147 then
                    local v148 = math.abs(v146.Y - v144.Y) * 1.8
                    local v149 = v148 / 2

                    v89.Box.Size = Vector2.new(v149, v148)
                    v89.Box.Position = Vector2.new(v144.X - v149 / 2, v146.Y - (v148 * 0.1))
            
                    if v20 then
                        v89.Box.Visible = true
                        if v88 == v81 then
                            v89.Box.Color = Color3.fromRGB(0, 255, 0)
                        else
                            v89.Box.Color = Color3.fromRGB(255, 0, 0)
                        end
                    else
                        v89.Box.Visible = false
                    end
               
                    if v24 then
                        v89.Tracer.From = v141
                        v89.Tracer.To = Vector2.new(v144.X, v144.Y)
                        if v88 == v81 then
                            v89.Tracer.Color = Color3.fromRGB(0, 255, 0) 
                        else
                            v89.Tracer.Color = Color3.fromRGB(255, 255, 255)
                        end
                        v89.Tracer.Visible = true
                    else
                        v89.Tracer.Visible = false
                    end

                    if v22 then
                        local v99 = math.clamp(v86.Health / v86.MaxHealth, 0, 1)
                        local v150 = v89.Box.Position.X - 6
                        local v151 = v89.Box.Position.Y
                        local v152 = v89.Box.Position.Y + v148
                        local v153 = v148 * v99

                        v89.HpBg.From = Vector2.new(v150, v152)
                        v89.HpBg.To = Vector2.new(v150, v151)
                        v89.HpBg.Visible = true

                        v89.Hp.From = Vector2.new(v150, v152)
                        v89.Hp.To = Vector2.new(v150, v152 - v153)
                        v89.Hp.Color = Color3.fromRGB(255, 0, 0):Lerp(Color3.fromRGB(0, 255, 0), v99)
                        v89.Hp.Visible = true
                    else
                        v89.HpBg.Visible = false
                        v89.Hp.Visible = false
                    end

                    if v21 then
                        local v154 = v90:FindFirstChild("UpperTorso") ~= nil
                        local v155 = v154 and v8 or v9

                        for v156 = 1, 15 do
                            local v157 = v89.Skeleton[v156]
                            local v158 = v155[v156]

                            if v158 then
                                local v159 = v90:FindFirstChild(v158[1])
                                local v160 = v90:FindFirstChild(v158[2])
                                if v159 and v160 then
                                    local v161, v162 = v7:WorldToViewportPoint(v159.Position)
                                    local v163, v164 = v7:WorldToViewportPoint(v160.Position)

                                    if v162 and v164 then
                                        v157.From = Vector2.new(v161.X, v161.Y)
                                        v157.To = Vector2.new(v163.X, v163.Y)
                                        v157.Visible = true
                                    else
                                        v157.Visible = false
                                    end
                                else
                                    v157.Visible = false
                                end
                            else
                                v157.Visible = false
                            end
                        end
                    else
                        for _, v165 in pairs(v89.Skeleton) do v165.Visible = false end
                    end
                else
                    v89.Box.Visible = false
                    v89.HpBg.Visible = false
                    v89.Hp.Visible = false
                    v89.Tracer.Visible = false
                    for _, v166 in pairs(v89.Skeleton) do v166.Visible = false end
                end
            else
                v89.Box.Visible = false
                v89.HpBg.Visible = false
                v89.Hp.Visible = false
                v89.HL.Enabled = false
                v89.Tracer.Visible = false
                for _, v167 in pairs(v89.Skeleton) do v167.Visible = false end
            end
        else
            v89.Box.Visible = false
            v89.HpBg.Visible = false
            v89.Hp.Visible = false
            v89.HL.Enabled = false
            v89.Tracer.Visible = false
            for _, v168 in pairs(v89.Skeleton) do v168.Visible = false end
        end
    end
end)
-- =========================================================
-- BẢNG TỪ ĐIỂN BIẾN (DICTIONARY) - PHATHUB PRO
-- (Cất tạm ở đây để sau này dễ dò lại code)
-- =========================================================

-- [1] CÁC DỊCH VỤ (SERVICES) & KHỞI TẠO
-- v1 = Players
-- v2 = RunService
-- v3 = UserInputService (UIS)
-- v4 = StarterGui
-- v5 = TweenService
-- v6 = LocalPlayer (Bản thân)
-- v7 = Camera
-- v8 = BONES_R15 (Xương R15)
-- v9 = BONES_R6 (Xương R6)
-- v10 = HighlightContainer (Thư mục chứa Highlight)

-- [2] CÀI ĐẶT (SETTINGS & TOGGLES)
-- v11 = FOV (Độ rộng vòng ngắm)
-- v12 = AimSmoothness (Độ mượt khi lia tâm)
-- v13 = AimPart (Bộ phận ngắm: Đầu/Thân)
-- v14 = AimMode (Chế độ ngắm: Hold/Toggle)
-- v15 = HoldingAim (Trạng thái đang giữ ngắm)
-- v16 = ScriptEnabled (Bật/tắt toàn bộ script)
-- v17 = LockedTargetPart (Mục tiêu đang bị khóa)
-- v18 = ESPEnabled (Bật ESP)
-- v19 = TeamCheckEnabled (Check đồng đội)
-- v20 = BoxEnabled (ESP Khung)
-- v21 = SkeletonEnabled (ESP Xương)
-- v22 = HealthBarEnabled (ESP Thanh máu)
-- v23 = HighlightEnabled (ESP Phát sáng)
-- v24 = TracerEnabled (ESP Tia kẻ)
-- v25 = AimRightClickEnabled (Ngắm bằng chuột phải)
-- v26 = AutoClearMemEnabled (Tự động xóa RAM)
-- v27 = ESP (Bảng lưu trữ data ESP của người chơi)

-- [3] HÀM HỆ THỐNG (FUNCTIONS)
-- v28 = ClearMemory() (Hàm dọn dẹp RAM)
-- v29 = is_enemy() (Hàm check kẻ thù)
-- v30 = IsValidTarget() (Hàm check mục tiêu có hợp lệ ko)
-- v46 = AddGrid() (Hàm chia lưới cho GUI)
-- v66 = BeautifyGUI() (Hàm làm đẹp GUI/Theme)
-- v74 = isMinimized (Biến check thu nhỏ menu)
-- v75 = ToggleMinimize() (Hàm thu nhỏ/phóng to menu)
-- v76 = SwitchAimPart() (Hàm đổi chỗ ngắm Head/Body)
-- v77 = CreateESP() (Hàm tạo ESP cho 1 người)
-- v78 = RemoveESP() (Hàm xóa ESP)
-- v79 = ResetESP() (Hàm làm mới toàn bộ ESP)
-- v80 = GetClosest() (Hàm tìm mục tiêu gần nhất)

-- [4] GIAO DIỆN (GUI ELEMENTS)
-- v31 = FOVCircle (Vòng tròn ngắm FOV)
-- v32 = Gui (Giao diện tổng)
-- v33 -> v36 = Nhóm HelpFrame (Bảng hướng dẫn)
-- v37 = Frame (Khung menu chính)
-- v38 = Title (Tiêu đề menu)
-- v39 = Close (Nút X tắt menu)
-- v40 = Minimize (Nút - thu nhỏ menu)
-- v41 = TabBar (Thanh chọn Tab)
-- v42 = CombatTabBtn (Nút Tab Combat)
-- v43 = VisualTabBtn (Nút Tab Visual)
-- v44 = CombatContainer (Nội dung Tab Combat)
-- v45 = VisualContainer (Nội dung Tab Visual)
-- v47 = AimStatus (Chữ báo trạng thái AIM)
-- v48 = FOVInput (Ô nhập FOV)
-- v49 = SmoothInput (Ô nhập Smooth)
-- v50 -> v53 = Các nút bấm trong tab Combat (Aim part, Mode, Team check...)
-- v54 -> v61 = Các nút bấm trong tab Visual (ESP, Box, Bone, Clear Mem...)
-- v62 = TargetHud (Khung hiển thị info mục tiêu bị khóa)
-- v63 = TargetName (Tên mục tiêu)
-- v64 = TargetHealth (Máu mục tiêu)
-- v65 = TargetAimAssist (Chữ báo đang ngắm vào đâu)


--đôi lời của dev:vẫn nhớ nyc tên dương quá 
