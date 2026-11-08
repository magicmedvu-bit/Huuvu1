import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  String _selectedLang = AppConstants.langEn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final langInfo = AppConstants.languages[_selectedLang]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Báo cáo tiến độ & Mục tiêu'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language Segment Switcher (EN, JA, ZH)
            Container(
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  _buildLangTab(AppConstants.langEn, '🇬🇧 Tiếng Anh'),
                  _buildLangTab(AppConstants.langJa, '🇯🇵 Tiếng Nhật'),
                  _buildLangTab(AppConstants.langZh, '🇨🇳 Tiếng Trung'),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Estimated Benchmark Card (UR-PROG-004)
            _buildBenchmarkReadinessCard(theme, langInfo),
            const SizedBox(height: 20),

            // 4 Skills Breakdown (Listening, Speaking, Reading, Writing)
            _buildSkillsRadarCard(theme),
            const SizedBox(height: 20),

            // Weekly Summary & Error Pattern Trends (UR-PER-005)
            _buildWeeklyReportCard(theme),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildLangTab(String code, String label) {
    final isSelected = _selectedLang == code;
    final theme = Theme.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedLang = code),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? theme.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBenchmarkReadinessCard(ThemeData theme, Map<String, dynamic> langInfo) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Mức độ sẵn sàng kỳ thi', style: TextStyle(fontSize: 13, color: Colors.grey)),
                    const SizedBox(height: 4),
                    Text(
                      '${langInfo['name']} • ${langInfo['benchmark']}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(langInfo['icon'], style: const TextStyle(fontSize: 32)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Điểm ước tính: 485 / 600',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF2563EB)),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Cần +115 điểm nữa để đạt mục tiêu Giai đoạn 1',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2563EB).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    '81% Ready',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2563EB)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: const LinearProgressIndicator(
                value: 0.81,
                minHeight: 8,
                backgroundColor: Color(0xFFE2E8F0),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
              ),
            ),
            const SizedBox(height: 14),
            // Disclaimer footnote required by URS UR-PROG-004
            const Text(
              '* Lưu ý: Điểm ước tính được tính từ các bài kiểm tra nội bộ có cấu trúc tương đương và không phải kết quả thi chính thức.',
              style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillsRadarCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Đánh giá theo 4 kỹ năng (UR-PROG-003)',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            _buildSkillBar('Listening (Nghe hiểu)', 82, Colors.blue),
            _buildSkillBar('Speaking (Giao tiếp & Nói)', 68, Colors.green),
            _buildSkillBar('Reading (Đọc hiểu)', 79, Colors.amber[800]!),
            _buildSkillBar('Writing (Viết & Ngữ pháp)', 64, Colors.purple),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillBar(String skill, int percent, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(skill, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
              Text('$percent%', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent / 100,
              minHeight: 6,
              backgroundColor: color.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyReportCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Tổng kết tuần từ AI Coach (UR-PER-005)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.auto_awesome, color: Color(0xFF8B5CF6), size: 20),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              '• Tổng thời gian học: 4 giờ 20 phút (Đạt 95% mục tiêu tuần).\n'
              '• Từ vựng ghi nhớ mới: 45 từ qua thuật toán FSRS.\n'
              '• Điểm yếu cần chú ý: Trợ từ trong tiếng Nhật (は vs が) và phân biệt thì hiện tại hoàn thành trong tiếng Anh.\n'
              '• Kế hoạch tuần tới: Tăng cường 2 buổi hội thoại phản xạ công sở.',
              style: TextStyle(fontSize: 13, height: 1.5, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
