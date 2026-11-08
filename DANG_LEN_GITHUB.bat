@echo off
chcp 65001 > nul
title Đẩy mã nguồn lên GitHub: magicmedvu-bit/Huuvu1
color 0A

echo ==============================================================================
echo       ĐẨY CODE LÊN KHO GITHUB CỦA BẠN: magicmedvu-bit/Huuvu1
echo ==============================================================================
echo.
echo GitHub không dùng mật khẩu thường mà dùng mã khóa "Token" (bắt đầu bằng ghp_...).
echo.
echo Để lấy mã Token (chỉ mất 30 giây):
echo 1. Mở link: https://github.com/settings/tokens/new
echo 2. Đặt tên: apk
echo 3. Tích chọn ô vuông [x] repo  và  [x] workflow
echo 4. Cuộn xuống cuối bấm nút xanh "Generate token"
echo 5. Copy đoạn mã ghp_...
echo.
set /p TOKEN="Dán đoạn mã Token (ghp_...) vào đây rồi bấm Enter: "

if "%TOKEN%"=="" (
    echo Bạn chưa nhập Token!
    pause
    exit /b
)

echo.
echo Đang tải 38 tệp tin của ứng dụng lên GitHub...
E:\git\cmd\git.exe push https://%TOKEN%@github.com/magicmedvu-bit/Huuvu1.git main --force

if %errorlevel% equ 0 (
    echo.
    echo ==============================================================================
    echo [THÀNH CÔNG RỰC RỠ] Code đã được đẩy lên GitHub thành công!
    echo.
    echo BÂY GIỜ BẠN LÀM THEO 2 BƯỚC NÀY ĐỂ LẤY FILE APK:
    echo 1. Mở lại trang: https://github.com/magicmedvu-bit/Huuvu1/actions
    echo 2. Bạn sẽ thấy biểu tượng xoay tròn "Build Android APK" đang chạy!
    echo    Sau 2-3 phút, khi có dấu tích xanh, bấm vào đó để tải file APK về điện thoại!
    echo ==============================================================================
) else (
    echo.
    echo [LỖI] Mã Token chưa đúng hoặc bị thiếu quyền repo. Vui lòng thử lại.
)

pause
