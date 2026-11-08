import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../navigation/main_navigation_scaffold.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 0; // 0: Goals, 1: Daily Target, 2: 4-Skills Assessment

  String _selectedDailyMinutes = '30';
  String _preferredTime = 'Tối (19h - 22h)';

  // Input evaluation ratings across 4 skills (UR-PRO-004)
  double _listeningLevel = 2.0; // 1: Beginner, 2: Elementary, 3: Intermediate
  double _speakingLevel = 1.0;
  double _readingLevel = 2.0;
  double _writingLevel = 1.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thiết lập mục tiêu học tập'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Step Progress Indicator
              LinearProgressIndicator(
                value: (_step + 1) / 3,
                backgroundColor: theme.primaryColor.withOpacity(0.15),
                valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: SingleChildScrollView(
                  child: _step == 0
                      ? _buildStepGoals(theme)
                      : _step == 1
                          ? _buildStepSchedule(theme)
                          : _buildStepSkillsAssessment(theme),
                ),
              ),

              // Bottom Navigation Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_step < 2) {
                      setState(() => _step++);
                    } else {
                      // Complete onboarding and enter app
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const MainNavigationScaffold()),
                      );
                    }
                  },
                  child: Text(
                    _step < 2 ? 'Tiếp tục' : 'Bắt đầu hành trình cùng AI Coach',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepGoals(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '3 Ngôn ngữ & Mục tiêu đầu ra (UR-PRO-002)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Hệ thống AI Coach sẽ tối ưu hóa giáo trình để bạn học song song mà không bị nhầm lẫn:',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const SizedBox(height: 16),
        _buildGoalItem('Tiếng Anh (English)', '🇬🇧', 'Mục tiêu: TOEIC 600', 'Tập trung giao tiếp công sở và phản xạ nghe'),
        const SizedBox(height: 12),
        _buildGoalItem('Tiếng Nhật (日本語)', '🇯🇵', 'Mục tiêu: JLPT N3', 'Kanji có Furigana, trợ từ và giao tiếp hằng ngày'),
        const SizedBox(height: 12),
        _buildGoalItem('Tiếng Trung (普通话)', '🇨🇳', 'Mục tiêu: HSK 3', 'Pinyin chuẩn thanh điệu và ngữ pháp giao tiếp'),
      ],
    );
  }

  Widget _buildGoalItem(String title, String flag, String goal, String note) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Text(flag, style: const TextStyle(fontSize: 28)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(goal, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w600, fontSize: 13)),
            Text(note, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: const Icon(Icons.check_circle, color: Colors.green),
      ),
    );
  }

  Widget _buildStepSchedule(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Thời gian học mỗi ngày (UR-PRO-001)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'Phù hợp cho người đi làm bận rộn, chia nhỏ thời gian hiệu quả:',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: ['15 phút/ngày', '30 phút/ngày', '45 phút/ngày', '60 phút/ngày'].map((target) {
            final isSelected = _selectedDailyMinutes == target.split(' ')[0];
            return ChoiceChip(
              label: Text(target),
              selected: isSelected,
              selectedColor: theme.primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              onSelected: (_) => setState(() => _selectedDailyMinutes = target.split(' ')[0]),
            );
          }).toList(),
        ),
        const SizedBox(height: 30),
        const Text(
          'Khung giờ bạn ưu tiên học:',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: _preferredTime,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: const [
            DropdownMenuItem(value: 'Sáng sớm (6h - 8h)', child: Text('Sáng sớm (6h - 8h)')),
            DropdownMenuItem(value: 'Giờ nghỉ trưa (12h - 13h)', child: Text('Giờ nghỉ trưa (12h - 13h)')),
            DropdownMenuItem(value: 'Tối (19h - 22h)', child: Text('Tối (19h - 22h)')),
          ],
          onChanged: (val) => setState(() => _preferredTime = val!),
        ),
      ],
    );
  }

  Widget _buildStepSkillsAssessment(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Đánh giá trình độ 4 kỹ năng riêng biệt (UR-PRO-004)',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text(
          'AI không mặc định bạn có cùng trình độ ở cả 4 kỹ năng:',
          style: TextStyle(fontSize: 13, color: Colors.grey),
        ),
        const SizedBox(height: 20),
        _buildSkillSlider('Listening (Nghe hiểu)', _listeningLevel, (v) => setState(() => _listeningLevel = v)),
        _buildSkillSlider('Speaking (Nói & Phản xạ)', _speakingLevel, (v) => setState(() => _speakingLevel = v)),
        _buildSkillSlider('Reading (Đọc hiểu)', _readingLevel, (v) => setState(() => _readingLevel = v)),
        _buildSkillSlider('Writing (Viết & Ngữ pháp)', _writingLevel, (v) => setState(() => _writingLevel = v)),
      ],
    );
  }

  Widget _buildSkillSlider(String skill, double value, ValueChanged<double> onChanged) {
    final levels = ['Mới bắt đầu', 'Cơ bản', 'Trung cấp', 'Thành thạo'];
    final levelText = levels[(value.toInt() - 1).clamp(0, 3)];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(skill, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(levelText, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 13)),
            ],
          ),
          Slider(
            value: value,
            min: 1.0,
            max: 4.0,
            divisions: 3,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
