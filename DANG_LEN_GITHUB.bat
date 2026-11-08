@echo off
chcp 65001 > nul
title Đẩy mã nguồn lên GitHub: magicmedvu-bit/Huuvu1
color 0A

echo ==============================================================================
echo   ĐANG TỰ ĐỘNG KẾT NỐI VÀ ĐẨY CODE LÊN KHO GITHUB:
echo   https://github.com/magicmedvu-bit/Huuvu1
echo ==============================================================================
echo.
echo Đang tải 38 tệp tin của ứng dụng lên GitHub của bạn...
echo.

E:\git\cmd\git.exe remote remove origin 2>nul
E:\git\cmd\git.exe remote add origin https://github.com/magicmedvu-bit/Huuvu1.git
E:\git\cmd\git.exe branch -M main
E:\git\cmd\git.exe push -u origin main

if %errorlevel% equ 0 (
    echo.
    echo ==============================================================================
    echo [THÀNH CÔNG] Toàn bộ mã nguồn đã được đưa lên kho Huuvu1!
    echo.
    echo BÂY GIỜ BẠN LÀM THEO 2 BƯỚC NÀY ĐỂ LẤY FILE APK:
    echo 1. Quay lại trang GitHub trên trình duyệt của bạn (trang đang mở).
    echo 2. Bấm phím F5 (hoặc tải lại trang), bạn sẽ thấy quy trình "Build Android APK"
    echo    đang tự động chạy! Chờ 2-3 phút là có nút tải file APK về điện thoại!
    echo ==============================================================================
) else (
    echo.
    echo [LƯU Ý] Nếu màn hình có bật cửa sổ hỏi "Sign in with browser",
    echo bạn chỉ cần bấm nút màu xanh "Authorize" để đồng ý là xong!
)

echo.
pause
