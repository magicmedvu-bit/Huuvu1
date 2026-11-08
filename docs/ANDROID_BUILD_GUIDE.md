# HƯỚNG DẪN CÀI ĐẶT & XUẤT BẢN APP ANDROID (APK / AAB)
## PERSONAL AI LANGUAGE COACH

Tài liệu này hướng dẫn chi tiết cách chạy thử nghiệm và đóng gói ứng dụng **Personal AI Language Coach** thành file cài đặt APK / AAB chạy trên mọi điện thoại Android (Samsung, Xiaomi, Oppo, Vivo, Google Pixel...).

---

## 1. YÊU CẦU MÔI TRƯỜNG TRÊN MÁY TÍNH

1. **Flutter SDK**: Phiên bản `>= 3.16.0` (Khuyên dùng Flutter 3.24 trở lên).
2. **Android Studio & Android SDK**:
   - Android SDK Platform 34 (Android 14).
   - Android SDK Build-Tools 34.0.0.
   - Android SDK Command-line Tools.
3. **Java Development Kit (JDK)**: JDK 17 hoặc JBR đi kèm Android Studio.

---

## 2. KẾT NỐI ĐIỆN THOẠI ANDROID ĐỂ CHẠY TRỰC TIẾP

### Bước 1: Mở chế độ Nhà phát triển (Developer Options) trên điện thoại
1. Mở ứng dụng **Cài đặt (Settings)** trên điện thoại.
2. Chọn **Thông tin điện thoại (About phone)**.
3. Chạm liên tục **7 lần** vào dòng **Số hiệu bản dựng (Build number)** cho đến khi màn hình báo *"Bạn đã là nhà phát triển"*.
4. Quay lại **Cài đặt** $\rightarrow$ **Cài đặt bổ sung (hoặc Hệ thống)** $\rightarrow$ **Tùy chọn nhà phát triển (Developer options)**.
5. Bật công tắc **Gỡ lỗi USB (USB Debugging)**.

### Bước 2: Cắm cáp USB nối điện thoại vào máy tính
1. Khi cắm cáp, màn hình điện thoại sẽ hiện bảng hỏi *"Cho phép gỡ lỗi USB từ máy tính này?"*.
2. Đánh dấu tích vào ô *"Luôn cho phép từ máy tính này"* rồi nhấn **Cho phép (OK)**.

### Bước 3: Chạy ứng dụng từ Terminal / Command Line
Mở PowerShell tại thư mục dự án (`E:\antigravity\học tiếng`):
```powershell
# 1. Cài đặt các gói thư viện
flutter pub get

# 2. Kiểm tra xem điện thoại đã nhận diện chưa
flutter devices

# 3. Chạy ứng dụng trực tiếp lên điện thoại
flutter run
```

---

## 3. XUẤT FILE CÀI ĐẶT APK ĐỂ CHIA SẺ HOẶC CÀI THỦ CÔNG

Nếu bạn muốn tạo file APK để gửi qua Zalo, Google Drive hoặc chép vào điện thoại cài đặt mà không cần cắm cáp:

```powershell
# Xuất file APK Release tối ưu cho mọi dòng máy Android
flutter build apk --release
```

Sau khi chạy xong, file APK sẽ được tạo tại đường dẫn:
```
E:\antigravity\học tiếng\build\app\outputs\flutter-apk\app-release.apk
```

**Cách cài file APK lên điện thoại:**
1. Chép file `app-release.apk` vào điện thoại (hoặc gửi qua Telegram/Zalo/Drive).
2. Nhấn vào file APK trên điện thoại để cài đặt.
3. Nếu điện thoại cảnh báo *"Cài đặt ứng dụng không rõ nguồn gốc"*, hãy chọn **Cho phép từ nguồn này** và nhấn **Cài đặt**.

---

## 4. CẤU HÌNH API KEY (GEMINI & OPENAI)

Trong ứng dụng, tầng AI Service ([ai_service.dart](file:///e:/antigravity/học%20tiếng/lib/core/ai/ai_service.dart)) đã được tích hợp sẵn cơ chế xử lý ngoại tuyến (Offline Mock Engine).

Để kích hoạt trí tuệ nhân tạo thời gian thực từ Google Gemini:
1. Lấy API Key miễn phí tại: [Google AI Studio](https://aistudio.google.com/).
2. Trong hàm `main.dart` hoặc màn hình Cài đặt, gọi:
   ```dart
   AiService.instance.configureKeys(
     geminiKey: "AIzaSy...",
   );
   ```
3. Ứng dụng sẽ tự động phân tích câu nói, chấm điểm phát âm và sinh nội dung học động từ mô hình Gemini 1.5 Flash.

---

## 5. CƠ SỞ DỮ LIỆU SUPABASE

Để kết nối với Database Supabase trên đám mây:
1. Tạo một dự án miễn phí tại [Supabase.com](https://supabase.com).
2. Vào mục **SQL Editor** trên Dashboard của Supabase.
3. Mở file [01_initial_schema.sql](file:///e:/antigravity/học%20tiếng/database/01_initial_schema.sql) trong thư mục dự án, copy toàn bộ nội dung và bấm **Run**. Toàn bộ 23 bảng, khóa quan hệ và dữ liệu mẫu sẽ được tạo ngay lập tức.
4. Lấy `Project URL` và `Anon Public Key` điền vào cấu hình khởi tạo của ứng dụng.
