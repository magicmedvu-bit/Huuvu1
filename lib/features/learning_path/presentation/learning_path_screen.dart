import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

class PhaseItem {
  final int phaseNumber;
  final String title;
  final String description;
  final int totalLessons;
  final int completedLessons;
  final bool isUnlocked;

  const PhaseItem({
    required this.phaseNumber,
    required this.title,
    required this.description,
    required this.totalLessons,
    required this.completedLessons,
    required this.isUnlocked,
  });

  double get progress => totalLessons > 0 ? completedLessons / totalLessons : 0.0;
}

class LearningPathScreen extends StatefulWidget {
  const LearningPathScreen({super.key});

  @override
  State<LearningPathScreen> createState() => _LearningPathScreenState();
}

class _LearningPathScreenState extends State<LearningPathScreen> {
  String _currentLang = AppConstants.langEn;

  final Map<String, List<PhaseItem>> _paths = {
    AppConstants.langEn: [
      const PhaseItem(
        phaseNumber: 1,
        title: "Phase 1: English Fundamentals",
        description: "Ngữ âm IPA chuẩn quốc tế, 500 từ vựng cốt lõi và các thì căn bản.",
        totalLessons: 15,
        completedLessons: 15,
        isUnlocked: true,
      ),
      const PhaseItem(
        phaseNumber: 2,
        title: "Phase 2: Basic Listening & Speaking",
        description: "Phản xạ giao tiếp hằng ngày, phát âm nối âm và nghe hiểu cơ bản.",
        totalLessons: 20,
        completedLessons: 14,
        isUnlocked: true,
      ),
      const PhaseItem(
        phaseNumber: 3,
        title: "Phase 3: Intermediate Grammar & Vocabulary",
        description: "Mệnh đề quan hệ, câu điều kiện, bị động và từ vựng mở rộng.",
        totalLessons: 25,
        completedLessons: 5,
        isUnlocked: true,
      ),
      const PhaseItem(
        phaseNumber: 4,
        title: "Phase 4: Business English",
        description: "Tiếng Anh công sở, viết email, thuyết trình và tham gia họp.",
        totalLessons: 20,
        completedLessons: 0,
        isUnlocked: false,
      ),
      const PhaseItem(
        phaseNumber: 5,
        title: "Phase 5: TOEIC Listening & Reading",
        description: "Chiến thuật làm bài Part 1-7, xử lý bẫy đề thi và quản lý thời gian.",
        totalLessons: 30,
        completedLessons: 0,
        isUnlocked: false,
      ),
      const PhaseItem(
        phaseNumber: 6,
        title: "Phase 6: TOEIC Mock Test Simulation",
        description: "Luyện đề thi thử chuẩn format TOEIC 600 kèm giải thích chi tiết.",
        totalLessons: 10,
        completedLessons: 0,
        isUnlocked: false,
      ),
    ],
    AppConstants.langJa: [
      const PhaseItem(
        phaseNumber: 1,
        title: "Phase 1: Hiragana, Katakana & Chữ Hán nhập môn",
        description: "2 bảng chữ cái, quy tắc biến âm, trường âm, âm ngắt và 50 chữ Kanji đầu tiên.",
        totalLessons: 12,
        completedLessons: 12,
        isUnlocked: true,
      ),
      const PhaseItem(
        phaseNumber: 2,
        title: "Phase 2: JLPT N5 Foundation",
        description: "Trợ từ cơ bản (は, が, を, に, で), chia thể từ (て, た, ない) và 800 từ vựng N5.",
        totalLessons: 25,
        completedLessons: 18,
        isUnlocked: true,
      ),
      const PhaseItem(
        phaseNumber: 3,
        title: "Phase 3: JLPT N4 Intermediate",
        description: "Thể khả năng, ý định, bị động, sai khiến và 1500 từ vựng N4.",
        totalLessons: 30,
        completedLessons: 4,
        isUnlocked: true,
      ),
      const PhaseItem(
        phaseNumber: 4,
        title: "Phase 4: JLPT N3 Advanced",
        description: "Kính ngữ (Sonkeigo/Kenjougo), đọc hiểu trung cấp và nghe hội thoại công sở.",
        totalLessons: 35,
        completedLessons: 0,
        isUnlocked: false,
      ),
      const PhaseItem(
        phaseNumber: 5,
        title: "Phase 5: JLPT N3 Mock Test",
        description: "Thi thử N3 tính giờ thực tế: Từ vựng/Chữ Hán, Ngữ pháp/Đọc hiểu, Nghe hiểu.",
        totalLessons: 8,
        completedLessons: 0,
        isUnlocked: false,
      ),
    ],
    AppConstants.langZh: [
      const PhaseItem(
        phaseNumber: 1,
        title: "Phase 1: Pinyin & 4 Thanh điệu căn bản",
        description: "Làm chủ ngữ âm Pinyin, quy tắc biến điệu và các nét bút thuận chữ Hán.",
        totalLessons: 10,
        completedLessons: 10,
        isUnlocked: true,
      ),
      const PhaseItem(
        phaseNumber: 2,
        title: "Phase 2: HSK 1 - 150 Từ vựng & Mẫu câu",
        description: "Chào hỏi, đếm số, chỉ vị trí, mua sắm cơ bản và ngữ pháp HSK 1.",
        totalLessons: 18,
        completedLessons: 15,
        isUnlocked: true,
      ),
      const PhaseItem(
        phaseNumber: 3,
        title: "Phase 3: HSK 2 - 300 Từ vựng & Giao tiếp",
        description: "Mô tả sinh hoạt hằng ngày, đi lại, thời tiết và so sánh hơn kém.",
        totalLessons: 22,
        completedLessons: 6,
        isUnlocked: true,
      ),
      const PhaseItem(
        phaseNumber: 4,
        title: "Phase 4: HSK 3 - 600 Từ vựng & Ngữ pháp sâu",
        description: "Câu chữ 把, câu chữ 被, bổ ngữ kết quả, bổ ngữ trạng thái và giao tiếp công việc.",
        totalLessons: 30,
        completedLessons: 0,
        isUnlocked: false,
      ),
      const PhaseItem(
        phaseNumber: 5,
        title: "Phase 5: HSK 3 Mock Test",
        description: "Mô phỏng bài thi HSK 3 chuẩn: Nghe hiểu, Đọc hiểu và Viết câu.",
        totalLessons: 8,
        completedLessons: 0,
        isUnlocked: false,
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final langInfo = AppConstants.languages[_currentLang]!;
    final phases = _paths[_currentLang] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('Lộ trình ${langInfo['name']}'),
        actions: [
          PopupMenuButton<String>(
            initialValue: _currentLang,
            onSelected: (code) => setState(() => _currentLang = code),
            itemBuilder: (context) => [
              const PopupMenuItem(value: AppConstants.langEn, child: Text('🇬🇧 Tiếng Anh (TOEIC 600)')),
              const PopupMenuItem(value: AppConstants.langJa, child: Text('🇯🇵 Tiếng Nhật (JLPT N3)')),
              const PopupMenuItem(value: AppConstants.langZh, child: Text('🇨🇳 Tiếng Trung (HSK 3)')),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(langInfo['icon'], style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: phases.length,
        itemBuilder: (context, index) {
          final phase = phases[index];
          return _buildPhaseCard(theme, phase, langInfo['color'] as Color);
        },
      ),
    );
  }

  Widget _buildPhaseCard(ThemeData theme, PhaseItem phase, Color langColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: phase.isUnlocked ? 2 : 0,
      color: phase.isUnlocked ? theme.cardColor : theme.cardColor.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: phase.isUnlocked ? langColor.withOpacity(0.3) : Colors.grey.withOpacity(0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: phase.isUnlocked ? langColor : Colors.grey[400],
                  child: Text(
                    '${phase.phaseNumber}',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        phase.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: phase.isUnlocked ? null : Colors.grey,
                        ),
                      ),
                      Text(
                        'Đã hoàn thành ${phase.completedLessons}/${phase.totalLessons} bài',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Icon(
                  phase.isUnlocked ? Icons.lock_open_rounded : Icons.lock_rounded,
                  color: phase.isUnlocked ? langColor : Colors.grey,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              phase.description,
              style: TextStyle(
                fontSize: 13,
                color: phase.isUnlocked ? Colors.black87 : Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: phase.progress,
                minHeight: 6,
                backgroundColor: langColor.withOpacity(0.12),
                valueColor: AlwaysStoppedAnimation<Color>(langColor),
              ),
            ),
            if (phase.isUnlocked) ...[
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: langColor,
                    side: BorderSide(color: langColor),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Bắt đầu bài học: ${phase.title}')),
                    );
                  },
                  child: const Text('Tiếp tục học giai đoạn này'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
