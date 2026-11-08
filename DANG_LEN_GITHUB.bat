@echo off
chcp 65001 > nul
title Đăng mã nguồn lên GitHub để tự động lấy file APK
color 0B

echo ==============================================================================
echo       TỰ ĐỘNG KẾT NỐI VÀ ĐẨY CODE LÊN GITHUB ĐỂ XUẤT FILE APK
echo ==============================================================================
echo.
echo Bước 1: Mở trình duyệt vào https://github.com/new
echo Bước 2: Đặt tên kho lưu trữ (ví dụ: ai-language-coach) rồi bấm "Create repository"
echo Bước 3: Copy đường link GitHub của bạn (ví dụ: https://github.com/ten-ban/ai-language-coach.git)
echo.
set /p REPO_URL="Dán đường link GitHub của bạn vào đây rồi bấm Enter: "

if "%REPO_URL%"=="" (
    echo.
    echo Bạn chưa nhập đường link! Vui lòng chạy lại file này khi đã có link.
    pause
    exit /b
)

echo.
echo Đang kết nối với GitHub...
E:\git\cmd\git.exe remote remove origin 2>nul
E:\git\cmd\git.exe remote add origin %REPO_URL%
E:\git\cmd\git.exe push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo ==============================================================================
    echo [THÀNH CÔNG] Toàn bộ mã nguồn đã được tải lên GitHub!
    echo.
    echo BÂY GIỜ BẠN LÀM THEO 3 BƯỚC NÀY ĐỂ TẢI FILE APK:
    echo 1. Mở lại trang GitHub trên trình duyệt.
    echo 2. Bấm vào tab "Actions" ở trên cùng.
    echo 3. Chờ 3 phút, bạn sẽ thấy mục "AI-Language-Coach-Release-APK" sẵn sàng tải về!
    echo ==============================================================================
) else (
    echo.
    echo [LƯU Ý] Nếu GitHub yêu cầu đăng nhập, hãy làm theo hướng dẫn trên màn hình.
)

pause
