local player = game.Players.LocalPlayer
local virtualUser = game:GetService("VirtualUser")

-- 1. Tạo Giao diện (GUI) cơ bản
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ToggleBtn = Instance.new("TextButton")
local Title = Instance.new("TextLabel")

-- Thiết lập GUI ẩn vào CoreGui để an toàn hơn
ScreenGui.Name = "SimpleAntiAFK"
ScreenGui.Parent = game:GetService("CoreGui")

-- Khung chính (có thể kéo thả)
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Position = UDim2.new(0.5, -75, 0.2, 0)
Frame.Size = UDim2.new(0, 150, 0, 80)
Frame.Active = true
Frame.Draggable = true 

-- Tiêu đề
Title.Parent = Frame
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Font = Enum.Font.Code
Title.Text = "Anti-AFK GUI"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14

-- Nút Bật/Tắt
ToggleBtn.Parent = Frame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
ToggleBtn.Position = UDim2.new(0.1, 0, 0.45, 0)
ToggleBtn.Size = UDim2.new(0.8, 0, 0.4, 0)
ToggleBtn.Font = Enum.Font.Code
ToggleBtn.Text = "ĐANG TẮT"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 16

-- 2. Logic hoạt động
local getgenv = getgenv or function() return _G end
getgenv().AntiAFK = false

-- Đổi trạng thái khi bấm nút
ToggleBtn.MouseButton1Click:Connect(function()
    getgenv().AntiAFK = not getgenv().AntiAFK
    if getgenv().AntiAFK then
        ToggleBtn.Text = "ĐANG BẬT"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        ToggleBtn.Text = "ĐANG TẮT"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

-- Bắt sự kiện khi game chuẩn bị Kick vì treo máy (Idled)
player.Idled:Connect(function()
    if getgenv().AntiAFK then
        -- Giả lập một cú click chuột phải vô hình để đánh lừa game
        virtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        virtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        print("Đã chặn 1 lần Kick AFK!")
    end
end)
