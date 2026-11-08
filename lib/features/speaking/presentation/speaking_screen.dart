import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

class SpeakingScreen extends StatefulWidget {
  const SpeakingScreen({super.key});

  @override
  State<SpeakingScreen> createState() => _SpeakingScreenState();
}

class _SpeakingScreenState extends State<SpeakingScreen> {
  String _currentLang = AppConstants.langEn;
  bool _isRecording = false;
  bool _hasResult = true; // Show evaluation radar for demonstration

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final langInfo = AppConstants.languages[_currentLang]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Luyện nói & Phát âm'),
        actions: [
          PopupMenuButton<String>(
            initialValue: _currentLang,
            onSelected: (code) => setState(() => _currentLang = code),
            itemBuilder: (context) => [
              const PopupMenuItem(value: AppConstants.langEn, child: Text('🇬🇧 English')),
              const PopupMenuItem(value: AppConstants.langJa, child: Text('🇯🇵 Japanese')),
              const PopupMenuItem(value: AppConstants.langZh, child: Text('🇨🇳 Chinese')),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Situational Scenario Prompt (UR-SPK-003)
            _buildScenarioCard(theme, langInfo),
            const SizedBox(height: 24),

            // Recording Controller Area
            _buildRecordingArea(theme),
            const SizedBox(height: 24),

            // Evaluation Scores Card (UR-SPK-004: 6 Criteria)
            if (_hasResult) ...[
              _buildEvaluationReportCard(theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildScenarioCard(ThemeData theme, Map<String, dynamic> langInfo) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'TÌNH HUỐNG THỰC TẾ',
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: theme.primaryColor),
                  ),
                ),
                const Spacer(),
                const Text('Chủ đề: Công sở', style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 12),
            const Text(
              'Tình huống: Giới thiệu bản thân và kinh nghiệm làm việc',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Gợi ý: Hãy giới thiệu tên, số năm kinh nghiệm trong ngành dược hoặc chuyên môn của bạn, và lý do bạn muốn cải thiện ngoại ngữ.',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecordingArea(ThemeData theme) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isRecording = !_isRecording;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isRecording ? Colors.red : theme.primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: (_isRecording ? Colors.red : theme.primaryColor).withOpacity(0.4),
                    blurRadius: _isRecording ? 20 : 10,
                    spreadRadius: _isRecording ? 4 : 1,
                  ),
                ],
              ),
              child: Icon(
                _isRecording ? Icons.stop : Icons.mic,
                color: Colors.white,
                size: 42,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _isRecording ? 'Đang lắng nghe... (Nhấn dừng khi nói xong)' : 'Chạm vào mic để bắt đầu nói',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: _isRecording ? Colors.red : Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEvaluationReportCard(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Đánh giá buổi nói (UR-SPK-004)',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Tổng: 82 / 100',
                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),

            // 6 Detailed Criteria Bars
            _buildScoreRow('Fluency (Độ trôi chảy)', 85, Colors.blue),
            _buildScoreRow('Grammar (Ngữ pháp)', 78, Colors.orange),
            _buildScoreRow('Vocabulary (Từ vựng)', 80, Colors.teal),
            _buildScoreRow('Pronunciation (Phát âm / Thanh điệu)', 84, Colors.purple),
            _buildScoreRow('Comprehension (Hiểu tình huống)', 90, Colors.green),
            _buildScoreRow('Response (Phản xạ câu trả lời)', 75, Colors.indigo),

            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.06),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    '💡 Lời khuyên cải thiện từ AI:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Phát âm rõ ràng, nhịp điệu tự nhiên. Chú ý nối âm đuôi "-ed" và trọng âm của từ "pharmaceutical" (/ˌfɑːrməˈsuːtɪkl/).',
                    style: TextStyle(fontSize: 12, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreRow(String label, int score, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              Text('$score%', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: score / 100,
              minHeight: 6,
              backgroundColor: color.withOpacity(0.15),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
