import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../ai_teacher/presentation/ai_teacher_screen.dart';
import '../../listening/presentation/listening_screen.dart';
import '../../speaking/presentation/speaking_screen.dart';
import '../../driving_mode/presentation/driving_mode_screen.dart';
import '../../reading/presentation/reading_screen.dart';
import '../../writing/presentation/writing_screen.dart';
import '../../grammar/presentation/grammar_screen.dart';
import '../../mock_test/presentation/mock_test_screen.dart';
import '../../materials/presentation/materials_screen.dart';
import '../../onboarding/presentation/onboarding_screen.dart';

class DashboardScreen extends StatelessWidget {
  final Function(int)? onNavigateTab;

  const DashboardScreen({super.key, this.onNavigateTab});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.school, color: theme.primaryColor, size: 24),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Chào bạn,',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
                ),
                Text(
                  'Personal AI Coach',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: theme.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file_outlined),
            tooltip: 'Tài liệu cá nhân (OCR/PDF)',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const MaterialsScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.tune_outlined),
            tooltip: 'Điều chỉnh mục tiêu & đánh giá',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OnboardingScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Daily Streak & Study Time Banner
            _buildDailyStatusBanner(context),
            const SizedBox(height: 20),

            // Quick Access Actions (AI Coach, Listening, Speaking, Driving Mode)
            const Text(
              'Truy cập nhanh',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildQuickActionsRow(context),
            const SizedBox(height: 16),
            _buildSecondaryActionsRow(context),
            const SizedBox(height: 24),

            // 3 Languages Overview (English, Japanese, Chinese)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '3 Ngôn ngữ đang học',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () => onNavigateTab?.call(1),
                  child: const Text('Xem lộ trình'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildLanguageCard(
              context: context,
              langCode: AppConstants.langEn,
              title: 'Tiếng Anh (English)',
              flag: '🇬🇧',
              benchmark: 'TOEIC 600',
              progressPercent: 0.35,
              wordsCount: 420,
              nextLesson: 'Business Communication & Listening Part 3',
              color: const Color(0xFF2563EB),
            ),
            const SizedBox(height: 12),
            _buildLanguageCard(
              context: context,
              langCode: AppConstants.langJa,
              title: 'Tiếng Nhật (日本語)',
              flag: '🇯🇵',
              benchmark: 'JLPT N3',
              progressPercent: 0.20,
              wordsCount: 280,
              nextLesson: 'Kanji N4 & Phân biệt trợ từ は vs が',
              color: const Color(0xFFDC2626),
            ),
            const SizedBox(height: 12),
            _buildLanguageCard(
              context: context,
              langCode: AppConstants.langZh,
              title: 'Tiếng Trung (普通话)',
              flag: '🇨🇳',
              benchmark: 'HSK 3',
              progressPercent: 0.15,
              wordsCount: 195,
              nextLesson: 'HSK 2 Vocab & Luyện thanh điệu 2 và 3',
              color: const Color(0xFFD97706),
            ),
            const SizedBox(height: 24),

            // Spaced Repetition Due Card
            _buildReviewReminderCard(context),
            const SizedBox(height: 24),

            // Today's Learning Checklist
            _buildTodayPlanCard(context),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDailyStatusBanner(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.primaryColor, const Color(0xFF1D4ED8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: const [
              Text('🔥 7 ngày', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('Chuỗi học tập', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
          Container(width: 1, height: 40, color: Colors.white24),
          Column(
            children: const [
              Text('⏱️ 22 / 30p', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('Thời gian hôm nay', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
          Container(width: 1, height: 40, color: Colors.white24),
          Column(
            children: const [
              Text('📚 18 từ', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('Cần ôn tập FSRS', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsRow(BuildContext context) {
    return Row(
      children: [
        _buildActionItem(
          context: context,
          icon: Icons.record_voice_over,
          label: 'AI Teacher',
          color: const Color(0xFF8B5CF6),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AiTeacherScreen()),
            );
          },
        ),
        const SizedBox(width: 12),
        _buildActionItem(
          context: context,
          icon: Icons.headphones,
          label: 'Luyện nghe',
          color: const Color(0xFF06B6D4),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ListeningScreen()),
            );
          },
        ),
        const SizedBox(width: 12),
        _buildActionItem(
          context: context,
          icon: Icons.mic,
          label: 'Luyện nói',
          color: const Color(0xFF10B981),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SpeakingScreen()),
            );
          },
        ),
        const SizedBox(width: 12),
        _buildActionItem(
          context: context,
          icon: Icons.directions_car,
          label: 'Lái xe',
          color: const Color(0xFFF59E0B),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DrivingModeScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildActionItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.parseBorder(Border.all(color: color.withOpacity(0.2))),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 26),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryActionsRow(BuildContext context) {
    return Row(
      children: [
        _buildActionItem(
          context: context,
          icon: Icons.auto_stories,
          label: 'Luyện đọc',
          color: const Color(0xFF3B82F6),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ReadingScreen()),
            );
          },
        ),
        const SizedBox(width: 12),
        _buildActionItem(
          context: context,
          icon: Icons.edit_note,
          label: 'Luyện viết',
          color: const Color(0xFFEC4899),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WritingScreen()),
            );
          },
        ),
        const SizedBox(width: 12),
        _buildActionItem(
          context: context,
          icon: Icons.menu_book,
          label: 'Ngữ pháp',
          color: const Color(0xFF6366F1),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GrammarScreen()),
            );
          },
        ),
        const SizedBox(width: 12),
        _buildActionItem(
          context: context,
          icon: Icons.quiz,
          label: 'Thi thử',
          color: const Color(0xFF14B8A6),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MockTestScreen()),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLanguageCard({
    required BuildContext context,
    required String langCode,
    required String title,
    required String flag,
    required String benchmark,
    required double progressPercent,
    required int wordsCount,
    required String nextLesson,
    required Color color,
  }) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(flag, style: const TextStyle(fontSize: 24)),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Mục tiêu: $benchmark',
                          style: TextStyle(
                            fontSize: 12,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${(progressPercent * 100).toInt()}%',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progressPercent,
                minHeight: 8,
                backgroundColor: color.withOpacity(0.15),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '📖 $wordsCount từ vựng',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  'Bài tiếp: $nextLesson',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReviewReminderCard(BuildContext context) {
    return Card(
      color: const Color(0xFFFFFBEB), // Gentle Warm Amber
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.alarm, color: Color(0xFFD97706), size: 28),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Hôm nay có 18 từ đến lịch ôn FSRS',
                    style: TextStyle(
                      color: Color(0xFF92400E),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Ôn tập ngắt quãng giúp chống quên 90% kiến thức',
                    style: TextStyle(color: Color(0xFFB45309), fontSize: 12),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => onNavigateTab?.call(3),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD97706),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              ),
              child: const Text('Ôn ngay', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayPlanCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Kế hoạch học hôm nay do AI cá nhân hóa',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildPlanItem(
              title: 'Nghe hội thoại Part 3 TOEIC (English)',
              duration: '10 phút',
              isDone: true,
            ),
            const Divider(height: 16),
            _buildPlanItem(
              title: 'Luyện phát âm thanh điệu 2 & 3 (Chinese)',
              duration: '8 phút',
              isDone: true,
            ),
            const Divider(height: 16),
            _buildPlanItem(
              title: 'Hội thoại với Sensei AI về chủ đề công việc (Japanese)',
              duration: '12 phút',
              isDone: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanItem({
    required String title,
    required String duration,
    required bool isDone,
  }) {
    return Row(
      children: [
        Icon(
          isDone ? Icons.check_circle : Icons.radio_button_unchecked,
          color: isDone ? Colors.green : Colors.grey,
          size: 20,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              decoration: isDone ? TextDecoration.lineThrough : null,
              color: isDone ? Colors.grey : null,
            ),
          ),
        ),
        Text(
          duration,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
