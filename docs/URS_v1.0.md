# USER REQUIREMENTS SPECIFICATION (URS)
## PERSONAL AI LANGUAGE COACH
### Ứng dụng học tiếng Anh – tiếng Nhật – tiếng Trung với trợ lý AI cá nhân

**Phiên bản:** 1.0  
**Trạng thái:** Initial Draft – Bản yêu cầu ban đầu  
**Nền tảng ưu tiên:** Android  
**Ngôn ngữ giao diện:** Tiếng Việt  
**Đối tượng sử dụng:** Người học ngoại ngữ cá nhân  
**Mô hình học tập:** AI Personal Language Coach

---

# 1. GIỚI THIỆU (INTRODUCTION)

## 1.1. Mục đích tài liệu (Purpose)

Tài liệu này xác định các yêu cầu của người dùng đối với ứng dụng Personal AI Language Coach.

Ứng dụng được xây dựng nhằm hỗ trợ một người học đồng thời ba ngoại ngữ:
- Tiếng Anh (English).
- Tiếng Nhật (Japanese).
- Tiếng Trung phổ thông (Mandarin Chinese).

Ứng dụng sử dụng trí tuệ nhân tạo (AI) để xây dựng chương trình học, hướng dẫn, kiểm tra, đánh giá và cá nhân hóa nội dung học tập.

Tài liệu URS được sử dụng làm cơ sở để:
1. Thiết kế kiến trúc phần mềm.
2. Xây dựng cơ sở dữ liệu.
3. Thiết kế giao diện người dùng.
4. Phát triển các chức năng trên Flutter.
5. Tích hợp các dịch vụ AI và xử lý âm thanh.
6. Kiểm thử và nghiệm thu ứng dụng.

## 1.2. Mục tiêu của ứng dụng (Application Objectives)

Ứng dụng phải đáp ứng các mục tiêu sau:

**Mục tiêu 1: Học đồng thời ba ngôn ngữ**
Người dùng có thể quản lý và học ba ngoại ngữ trên cùng một ứng dụng mà không bị nhầm lẫn giữa hệ thống từ vựng, ngữ pháp và chương trình học.

**Mục tiêu 2: Phát triển khả năng giao tiếp**
Ưu tiên khả năng nghe hiểu và phản xạ giao tiếp thông qua các bài luyện nghe và hội thoại hai chiều với AI.

**Mục tiêu 3: Phát triển đồng đều bốn kỹ năng**
Tích hợp Listening, Speaking, Reading và Writing trong cùng một chương trình học.

**Mục tiêu 4: Cá nhân hóa việc học**
AI có khả năng nhận diện điểm mạnh, điểm yếu, lỗi thường gặp và tự điều chỉnh nội dung học.

**Mục tiêu 5: Đạt các mục tiêu trình độ cụ thể**

| Ngôn ngữ | Mục tiêu giai đoạn 1 | Hệ thống tham chiếu |
|---|---|---|
| Tiếng Anh | TOEIC 600 | TOEIC Listening & Reading |
| Tiếng Nhật | JLPT N3 | Japanese-Language Proficiency Test |
| Tiếng Trung | HSK 3 | HSK – Chinese Proficiency Test |

Các cấp độ trên là mục tiêu đầu ra, không phải điều kiện bắt buộc khi bắt đầu sử dụng ứng dụng.

---

# 2. PHẠM VI ỨNG DỤNG (SCOPE)

## 2.1. Phạm vi chức năng

Ứng dụng bao gồm các nhóm chức năng chính:
1. User Profile – Quản lý hồ sơ người học.
2. Learning Path – Quản lý lộ trình học.
3. AI Language Teacher – Giáo viên AI.
4. Listening Practice – Luyện nghe.
5. Speaking Practice – Luyện nói.
6. Reading Practice – Luyện đọc.
7. Writing Practice – Luyện viết.
8. Vocabulary Management – Quản lý từ vựng.
9. Grammar Learning – Học ngữ pháp.
10. Review System – Ôn tập thông minh.
11. Progress Tracking – Theo dõi tiến độ.
12. Driving Mode – Chế độ học bằng âm thanh khi di chuyển.
13. Learning Materials – Quản lý tài liệu học tập.

## 2.2. Phạm vi không bao gồm trong phiên bản đầu tiên

Các chức năng sau chưa phải yêu cầu bắt buộc:
- Học trực tiếp với giáo viên con người.
- Mạng xã hội học ngoại ngữ.
- Thi đấu hoặc xếp hạng giữa nhiều người dùng.
- Hệ thống cấp chứng chỉ chính thức.
- Thanh toán và bán khóa học.
- Quản lý lớp học hoặc trung tâm ngoại ngữ.

Kiến trúc cần cho phép mở rộng các chức năng này trong tương lai.

---

# 3. ĐỐI TƯỢNG SỬ DỤNG (USER PROFILE)

## 3.1. Đặc điểm người dùng

Ứng dụng hướng đến người trưởng thành đã đi làm, muốn cải thiện năng lực ngoại ngữ phục vụ giao tiếp và công việc.

Đặc điểm:
- Không có nhiều thời gian học liên tục.
- Có thể học vào buổi sáng, giờ nghỉ và buổi tối.
- Có thể tận dụng thời gian di chuyển để luyện nghe.
- Muốn học theo lộ trình rõ ràng.
- Cần được giải thích kiến thức bằng tiếng Việt.
- Muốn thực hành giao tiếp với AI thay vì chỉ học lý thuyết.

## 3.2. Ngôn ngữ sử dụng

Người dùng có thể lựa chọn một trong ba ngôn ngữ học tập.

| Thuộc tính | English | Japanese | Chinese |
|---|---|---|---|
| Mã ngôn ngữ | en | ja | zh |
| Ngôn ngữ giải thích | vi | vi | vi |
| Hệ chữ | Latin | Kanji, Hiragana, Katakana | Simplified Chinese |
| Phiên âm | IPA | Romaji | Pinyin |
| Âm thanh | TTS | TTS | TTS có thanh điệu |

Đối với tiếng Nhật, hệ thống phải hỗ trợ Furigana để giúp người học đọc Kanji.
Đối với tiếng Trung, phải hỗ trợ Pinyin có dấu thanh điệu.

---

# 4. YÊU CẦU VỀ HỒ SƠ NGƯỜI HỌC (USER PROFILE)

### UR-PRO-001: Tạo hồ sơ học tập
Ứng dụng phải cho phép người dùng tạo hồ sơ cá nhân.
Thông tin bao gồm:
- Tên người dùng.
- Ngôn ngữ mẹ đẻ.
- Ngôn ngữ muốn học.
- Trình độ hiện tại của từng ngôn ngữ.
- Mục tiêu học tập.
- Thời gian có thể dành cho việc học mỗi ngày.
- Thời gian học ưu tiên.

### UR-PRO-002: Quản lý mục tiêu riêng biệt
Người dùng có thể đặt mục tiêu khác nhau cho từng ngôn ngữ.

### UR-PRO-003: Điều chỉnh mục tiêu
Người dùng có thể thay đổi mục tiêu, thời gian học và mức độ ưu tiên bất cứ lúc nào.

### UR-PRO-004: Đánh giá đầu vào
Khi bắt đầu học, ứng dụng phải cung cấp bài kiểm tra đầu vào phân biệt bốn kỹ năng: Listening, Speaking, Reading, Writing.

---

# 5. YÊU CẦU VỀ GIAO DIỆN (USER INTERFACE)

## 5.1. Dashboard – Trang chủ
Dashboard phải hiển thị:
1. Tổng quan tiến độ học.
2. Ba ngôn ngữ đang theo học.
3. Mục tiêu của từng ngôn ngữ.
4. Kế hoạch học hôm nay.
5. Thời gian đã học.
6. Số từ vựng cần ôn tập.
7. Nút truy cập nhanh AI Teacher.
8. Nút truy cập nhanh Listening và Speaking.

## 5.2. Navigation Menu
5 menu chính: Home, Learning, AI Teacher, Vocabulary, Progress.

## 5.3. Yêu cầu thiết kế
- Giao diện đơn giản, dễ sử dụng.
- Hỗ trợ tiếng Việt.
- Thiết kế responsive, chế độ sáng/tối.
- Chức năng nghe & nói dễ truy cập.

---

# 6. YÊU CẦU VỀ AI LANGUAGE TEACHER (UR-AI)

- **UR-AI-001:** Giáo viên AI riêng cho từng ngôn ngữ (English, Japanese, Chinese), giải thích bằng tiếng Việt.
- **UR-AI-002:** Phân tích từ vựng, ngữ pháp, cấu trúc câu, ví dụ theo ngữ cảnh.
- **UR-AI-003:** Hội thoại hai chiều (giọng nói/văn bản), duy trì ngữ cảnh.
- **UR-AI-004:** Sửa lỗi thông minh (Grammar, Vocabulary, Pronunciation, Word Order, Expression, Listening).
- **UR-AI-005:** Điều chỉnh độ khó thích ứng.
- **UR-AI-006:** Lưu và quản lý lịch sử hội thoại.

---

# 7 - 10. BỐN KỸ NĂNG: LISTENING, SPEAKING, READING, WRITING

- **Listening:** Thư viện bài nghe phân cấp, chỉnh tốc độ (0.5x - 1.5x), nghe không phụ đề, có phụ đề tra từ vựng, Dictation (nghe chép chính tả), Shadowing (nghe nhại lại).
- **Speaking:** Nhận diện giọng nói STT 3 ngôn ngữ, đánh giá phát âm (IPA/âm tiết, thanh điệu pinyin, trường âm/âm ngắt tiếng Nhật, fluency), luyện nói theo tình huống, chấm điểm 6 tiêu chí (Fluency, Grammar, Vocabulary, Pronunciation, Comprehension, Response).
- **Reading:** Thư viện bài đọc phân cấp, tra từ trực tiếp một chạm, đọc hiểu trắc nghiệm, song ngữ song song, bật/tắt Furigana & Pinyin.
- **Writing:** Luyện viết theo chủ đề/tình huống công việc thực tế, AI phát hiện và chữa lỗi ngữ pháp/cách dùng từ, lưu bài viết và lịch sử sửa đổi.

---

# 11 - 18. CÁC PHÂN HỆ BỔ TRỢ

- **Vocabulary:** Quản lý theo ngôn ngữ, IPA/Furigana/Pinyin, Flashcard đa chế độ, FSRS/Spaced Repetition (New, Learning, Review, Known).
- **Grammar:** Giải thích bằng tiếng Việt, cấu trúc, ví dụ, lỗi thường gặp, bài tập.
- **Learning Path:** Lộ trình chi tiết TOEIC 600, JLPT N3, HSK 3 kèm Mock Tests.
- **Review System:** Thuật toán ngắt quãng FSRS, tự động lên lịch theo kết quả và độ khó.
- **AI Personalization:** Nhận diện điểm yếu, tự tạo bài tập bù đắp, tổng kết hàng tuần.
- **Driving Mode:** Chế độ âm thanh 100% rảnh tay, an toàn khi di chuyển, tạm dừng một chạm.
- **Learning Materials:** Trích xuất và học từ tài liệu tải lên (Text, PDF, Ảnh OCR).
- **Progress Tracking:** Báo cáo chi tiết theo ngôn ngữ, kỹ năng và mức độ sẵn sàng chứng chỉ.

---

# 19 - 22. KIẾN TRÚC, CƠ SỞ DỮ LIỆU & AI PROMPT MANAGEMENT

- **Frontend:** Flutter (Dart), Clean Architecture + Riverpod.
- **Backend & Database:** Supabase (PostgreSQL, Auth, Storage).
- **AI Integration:** OpenAI / Gemini API, Whisper / STT, Google Cloud TTS.
- **Database Schema:** 23 bảng theo mô hình quan hệ chuẩn hóa.
- **AI Prompt Management:** Quản lý Prompt tập trung từ AI-001 đến AI-012 với structured JSON output.

---

# 24 - 28. KẾ HOẠCH PHÁT TRIỂN & TIÊU CHÍ NGHIỆM THU

- **Phase 1 – Foundation:** Nền tảng ứng dụng, Database, Profile, Dashboard, Navigation.
- **Phase 2 – Learning Core:** Vocabulary, Grammar, Flashcard, Listening & Reading Library, FSRS Review.
- **Phase 3 – AI Integration:** AI Teacher, STT, TTS, Speaking & Listening AI.
- **Phase 4 – Personalization:** Error Analysis, Weekly Report, Adaptive Plan.
- **Phase 5 – Advanced Features:** Driving Mode, Document Import OCR, Offline & Sync, Mock Tests.
