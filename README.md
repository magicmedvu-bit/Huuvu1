# PERSONAL AI LANGUAGE COACH
### Ứng dụng học Tiếng Anh – Tiếng Nhật – Tiếng Trung với Trợ lý AI Cá nhân trên Android

**Phiên bản:** 1.0 (Bản hoàn thiện đầy đủ tính năng - Final Release)  
**Nền tảng:** Android (Flutter & Dart) • Material 3  
**Kiến trúc:** Clean Architecture + Feature-First Pattern  
**Quản lý trạng thái:** Flutter Riverpod  
**Backend & Database:** Supabase (PostgreSQL 23 Tables) & Local Storage  
**Mô hình học tập:** AI Personal Language Coach (LEARN → PRACTICE → EVALUATE → IMPROVE)  

---

## 🎯 1. Mục tiêu đào tạo Phase 1
- **Tiếng Anh (English):** Mục tiêu đầu ra **TOEIC 600** (TOEIC Listening & Reading + Giao tiếp công sở).
- **Tiếng Nhật (Japanese):** Mục tiêu đầu ra **JLPT N3** (Kanji có Furigana, trợ từ, kính ngữ, phản xạ).
- **Tiếng Trung (Mandarin Chinese):** Mục tiêu đầu ra **HSK 3** (Ngữ âm Pinyin chuẩn thanh điệu, nhận diện chữ Hán, ngữ pháp).

---

## 🚀 2. Tính năng hoàn thiện theo 5 Giai đoạn của URS

### 🌟 Giai đoạn 1 – Nền tảng (Foundation)
- **Hồ sơ học viên (User Profile):** Thiết lập mục tiêu độc lập cho từng ngôn ngữ, thời lượng học linh hoạt (15, 30, 45, 60 phút/ngày).
- **Đánh giá đầu vào 4 kỹ năng:** Phân loại độc lập Listening, Speaking, Reading, Writing (không mặc định cùng một trình độ).
- **Dashboard trang chủ:** Theo dõi tiến độ 3 ngôn ngữ song song, chuỗi học tập (Streak), kế hoạch cá nhân hóa hôm nay, và lời nhắc từ vựng FSRS.
- **Thanh điều hướng 5 Menu:** Trang chủ, Lộ trình, AI Teacher, Từ vựng, Tiến độ.

### 📚 Giai đoạn 2 – Hệ thống học tập cốt lõi (Learning Core)
- **Lộ trình học chi tiết (Learning Path):**
  - Tiếng Anh: 6 Phase từ Fundamentals đến TOEIC 600 Mock Test.
  - Tiếng Nhật: 5 Phase từ Hiragana/Katakana đến JLPT N3 Mock Test.
  - Tiếng Trung: 5 Phase từ Pinyin đến HSK 3 Mock Test.
- **Kho từ vựng & Flashcard:** 4 trạng thái (New, Learning, Review, Known) cùng thuật toán lặp lại ngắt quãng **FSRS**.
- **Ngữ pháp chuyên sâu (Grammar Hub):** Cấu trúc công thức, giải thích tiếng Việt, ví dụ mẫu, lỗi thường gặp và bài tập áp dụng.
- **Luyện đọc (Reading):** Chế độ song ngữ, chạm 1 lần vào từ để tra nghĩa và lưu ngay vào kho Flashcard, câu hỏi đọc hiểu trắc nghiệm.
- **Luyện nghe (Listening):** Bộ điều chỉnh tốc độ chuẩn 5 mức (**0.5x, 0.75x, 1.0x, 1.25x, 1.5x**), bật/tắt phụ đề song ngữ, chế độ chép chính tả (**Dictation**) và nhại lại (**Shadowing**).
- **Luyện viết (Writing):** Thực hành viết theo tình huống công việc (Email, Báo cáo, Nhật ký), nộp bài cho AI sửa lỗi và nhận phản hồi chi tiết.

### 🤖 Giai đoạn 3 – Tích hợp Giáo viên AI (AI Integration)
- **Trợ lý AI riêng cho từng ngôn ngữ:** English Coach AI, Japanese Sensei AI, Chinese Laoshi AI.
- **Hội thoại 2 chiều:** Tương tác bằng giọng nói hoặc văn bản, duy trì ngữ cảnh đàm thoại.
- **Thẻ sửa lỗi thông minh (Smart Error Correction):** Hiển thị câu gốc, câu sửa, phân loại lỗi (Grammar, Vocab, Word Order, Expression), giải thích tiếng Việt và gợi ý cách nói tự nhiên.
- **Chấm điểm phát âm 6 tiêu chí:** Fluency (Trôi chảy), Grammar (Ngữ pháp), Vocabulary (Từ vựng), Pronunciation (Phát âm/Thanh điệu), Comprehension (Hiểu bài), Response (Phản xạ).

### 🎯 Giai đoạn 4 – Cá nhân hóa (Personalization)
- **Nhận diện điểm yếu tích lũy (Error Patterns):** Tự động phát hiện lỗi hay mắc (thì quá khứ tiếng Anh, trợ từ は/が tiếng Nhật, thanh điệu 2/3 tiếng Trung).
- **Báo cáo học tập tuần:** Tổng hợp giờ học, tỷ lệ tiến bộ và khuyến nghị kế hoạch tuần mới.

### ⚡ Giai đoạn 5 – Tính năng nâng cao (Advanced Features)
- **Chế độ Lái xe (Driving Mode):** Thiết kế 100% âm thanh rảnh tay, không đòi hỏi nhìn màn hình, nút bấm khẩn cấp cực lớn để dừng/phát chỉ bằng một chạm.
- **Nhập tài liệu cá nhân (Document Import):** Tải file PDF, chụp ảnh OCR hoặc dán văn bản để AI tự động trích xuất bài học, từ vựng và câu hỏi trắc nghiệm.
- **Thi thử mô phỏng (Mock Test):** Đồng hồ đếm ngược, giao diện làm bài thi trắc nghiệm chuẩn kỳ thi và ước tính điểm số.
- **Hỗ trợ Ngoại tuyến (Offline Mode):** Tự động lưu cache bài học và từ vựng, tự đồng bộ khi có kết nối mạng.

---

## 📂 3. Cấu trúc thư mục mã nguồn

```
e:\antigravity\học tiếng\
├── android/                   # Cấu hình Android Native (Manifest, Gradle, Kotlin)
├── database/
│   └── 01_initial_schema.sql  # DDL 23 Bảng Supabase PostgreSQL + Seed Data
├── docs/
│   ├── URS_v1.0.md            # Bản đặc tả yêu cầu người dùng
│   ├── TECHNICAL_ARCHITECTURE.md # Kiến trúc kỹ thuật & Đặc tả hệ thống
│   └── ANDROID_BUILD_GUIDE.md # Cẩm nang build APK và chạy trên điện thoại Android
├── prompts/
│   └── prompt_registry.json   # 12 AI Prompts chuẩn hóa (AI-001 -> AI-012)
├── lib/
│   ├── main.dart              # Điểm khởi chạy Flutter App
│   ├── core/
│   │   ├── ai/                # AI Gateway & Gemini/OpenAI integration
│   │   ├── constants/         # AppConstants, mã ngôn ngữ, benchmark
│   │   ├── database/          # DatabaseService (Offline cache & Sync)
│   │   ├── fsrs/              # Free Spaced Repetition Scheduler Algorithm
│   │   ├── linguistic/        # Furigana parser, Pinyin tones, IPA helper
│   │   └── theme/             # Material 3 Theme (Light & Dark)
│   └── features/
│       ├── ai_teacher/        # Màn hình Giáo viên AI hội thoại & sửa lỗi
│       ├── dashboard/         # Màn hình Trang chủ Dashboard
│       ├── driving_mode/      # Màn hình Chế độ Lái xe (Audio-only)
│       ├── grammar/           # Màn hình Học ngữ pháp
│       ├── learning_path/     # Màn hình Lộ trình học 3 ngôn ngữ
│       ├── listening/         # Màn hình Luyện nghe (Tốc độ, Subtitle, Dictation, Shadowing)
│       ├── materials/         # Màn hình Nhập tài liệu (Text, PDF, OCR)
│       ├── mock_test/         # Màn hình Thi thử mô phỏng tính giờ
│       ├── navigation/        # MainNavigationScaffold (5 Tabs đáy màn hình)
│       ├── onboarding/        # Màn hình Thiết lập mục tiêu & Đánh giá 4 kỹ năng
│       ├── progress/          # Màn hình Báo cáo tiến độ & Điểm ước tính
│       ├── speaking/          # Màn hình Luyện nói & Chấm điểm 6 tiêu chí
│       ├── vocabulary/        # Màn hình Từ vựng & Flashcard FSRS
│       └── writing/           # Màn hình Luyện viết & Sửa lỗi văn bản
├── pubspec.yaml               # Cấu hình dependencies Flutter
└── analysis_options.yaml      # Cấu hình chuẩn code Dart
```

---

## 🛠️ 4. Hướng dẫn chạy & Xuất APK cho điện thoại Android

```powershell
# 1. Cài đặt thư viện
flutter pub get

# 2. Chạy ứng dụng trực tiếp lên điện thoại Android (cắm cáp USB)
flutter run

# 3. Xuất file APK hoàn chỉnh để cài đặt trực tiếp
flutter build apk --release
```
File APK sẽ xuất hiện tại: `build/app/outputs/flutter-apk/app-release.apk`.
Chép file này vào bất kỳ điện thoại Android nào để cài đặt và sử dụng ngay lập tức!
