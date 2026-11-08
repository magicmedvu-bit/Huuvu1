@echo off
chcp 65001 > nul
title Tự động Build file APK - AI Language Coach
color 0A

echo ==============================================================================
echo       PERSONAL AI LANGUAGE COACH - CÔNG CỤ TỰ ĐỘNG XUẤT FILE APK
echo ==============================================================================
echo.

where flutter >nul 2>nul
if %errorlevel% neq 0 (
    echo [THÔNG BÁO] Máy tính của bạn hiện chưa cài đặt bộ công cụ Flutter SDK.
    echo.
    echo Để tạo file APK trên máy tính, cần có Flutter SDK và Android Build Tools.
    echo Bạn có 2 cách rất dễ dàng:
    echo.
    echo 1. Tải Flutter SDK trực tiếp về ổ E:\ (nơi có 400GB dung lượng trống):
    echo    Truy cập: https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.0-stable.zip
    echo    Giải nén vào: E:\flutter và thêm E:\flutter\bin vào biến môi trường Path.
    echo.
    echo 2. HOẶC DÙNG GITHUB (Không cần cài gì lên máy):
    echo    Đưa thư mục mã nguồn này lên GitHub của bạn.
    echo    File tự động build (.github/workflows/build_apk.yml) đã được tạo sẵn!
    echo    GitHub sẽ tự động dịch mã và tạo file app-release.apk để bạn tải về.
    echo.
    echo ==============================================================================
    pause
    exit /b
)

echo [1/3] Đang tải các thư viện ứng dụng (flutter pub get)...
call flutter pub get

echo.
echo [2/3] Đang tiến hành đóng gói file APK cho Android (flutter build apk --release)...
call flutter build apk --release

if %errorlevel% equ 0 (
    echo.
    echo ==============================================================================
    echo [THÀNH CÔNG] File APK đã được tạo thành công!
    echo Vị trí file: build\app\outputs\flutter-apk\app-release.apk
    echo ==============================================================================
    echo.
    echo Đang tự động mở thư mục chứa file APK để bạn chép vào điện thoại...
    explorer build\app\outputs\flutter-apk
) else (
    echo.
    echo [LỖI] Quá trình đóng gói gặp sự cố. Vui lòng kiểm tra lại cấu hình Android SDK.
)

pause
