import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

class ListeningScreen extends StatefulWidget {
  final bool isEmbedded;
  const ListeningScreen({super.key, this.isEmbedded = false});

  @override
  State<ListeningScreen> createState() => _ListeningScreenState();
}

class _ListeningScreenState extends State<ListeningScreen> {
  bool _isPlaying = false;
  double _currentSpeed = 1.0;
  bool _showSubtitles = true;
  bool _showFuriganaOrPinyin = true;
  double _progress = 0.35; // 35% audio played
  int _practiceMode = 0; // 0: Normal Listen, 1: Dictation, 2: Shadowing

  final TextEditingController _dictationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !widget.isEmbedded,
        title: const Text('Luyện nghe (Listening)'),
        actions: [
          IconButton(
            icon: Icon(_showSubtitles ? Icons.subtitles : Icons.subtitles_off),
            tooltip: 'Bật/Tắt phụ đề',
            onPressed: () {
              setState(() {
                _showSubtitles = !_showSubtitles;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mode Selector: Nghe hiểu / Dictation / Shadowing
            Container(
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Row(
                children: [
                  _buildTabButton('Nghe hiểu', 0),
                  _buildTabButton('Dictation (Chép)', 1),
                  _buildTabButton('Shadowing (Nhại)', 2),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Audio Player Card
            _buildAudioPlayerCard(theme),
            const SizedBox(height: 20),

            // Speed Control Selector (0.5x, 0.75x, 1.0x, 1.25x, 1.5x - UR-LIS-002)
            _buildSpeedSelector(theme),
            const SizedBox(height: 24),

            // Content Body based on selected practice mode
            if (_practiceMode == 0) ...[
              _buildListeningContent(theme),
            ] else if (_practiceMode == 1) ...[
              _buildDictationContent(theme),
            ] else ...[
              _buildShadowingContent(theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final isSelected = _practiceMode == index;
    final theme = Theme.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _practiceMode = index),
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

  Widget _buildAudioPlayerCard(ThemeData theme) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF06B6D4).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.graphic_eq, color: Color(0xFF06B6D4)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Workplace Conversation Part 3',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      Text(
                        'TOEIC 600 • Thời lượng: 01:45',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Slider & Timers
            Slider(
              value: _progress,
              onChanged: (val) => setState(() => _progress = val),
              activeColor: theme.primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('00:36', style: TextStyle(fontSize: 12, color: Colors.grey)),
                  Text('01:45', style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Playback Controls
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.replay_10),
                  iconSize: 28,
                  onPressed: () {},
                ),
                const SizedBox(width: 16),
                CircleAvatar(
                  radius: 28,
                  backgroundColor: theme.primaryColor,
                  child: IconButton(
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                    color: Colors.white,
                    iconSize: 32,
                    onPressed: () {
                      setState(() {
                        _isPlaying = !_isPlaying;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.forward_10),
                  iconSize: 28,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedSelector(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tốc độ nghe (UR-LIS-002)',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: AppConstants.audioSpeeds.map((speed) {
            final isSelected = _currentSpeed == speed;
            return ChoiceChip(
              label: Text('${speed}x'),
              selected: isSelected,
              selectedColor: theme.primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
              onSelected: (val) {
                if (val) setState(() => _currentSpeed = speed);
              },
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildListeningContent(ThemeData theme) {
    if (!_showSubtitles) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: const [
              Icon(Icons.visibility_off_outlined, size: 40, color: Colors.grey),
              SizedBox(height: 12),
              Text(
                'Đang ở chế độ nghe không phụ đề (UR-LIS-003)',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 6),
              Text(
                'Tập trung nghe phản xạ âm thanh trước khi bật phụ đề kiểm tra lại.',
                style: TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

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
                  'Phụ đề đồng bộ (Chạm vào từ để tra)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: _showFuriganaOrPinyin,
                  onChanged: (val) => setState(() => _showFuriganaOrPinyin = val),
                ),
              ],
            ),
            const Divider(),
            const SizedBox(height: 8),
            _buildSubtitleLine(
              speaker: "Manager",
              text: "Could you please send me the pharmaceutical sales report by noon?",
              translation: "Bạn có thể gửi cho tôi báo cáo doanh số dược phẩm trước buổi trưa được không?",
              isActive: true,
            ),
            const SizedBox(height: 16),
            _buildSubtitleLine(
              speaker: "You",
              text: "Certainly. I am finalizing the Q3 statistics right now.",
              translation: "Chắc chắn rồi. Tôi đang hoàn tất số liệu thống kê quý 3 ngay bây giờ.",
              isActive: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubtitleLine({
    required String speaker,
    required String text,
    required String translation,
    required bool isActive,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).primaryColor.withOpacity(0.08) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            speaker,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive ? Theme.of(context).primaryColor : null,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            translation,
            style: const TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildDictationContent(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dictation (Nghe và chép chính tả - UR-LIS-005)',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Hãy nghe câu nói và gõ lại chính xác nội dung bạn nghe được:',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _dictationController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Nhập câu nghe được tại đây...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Compare dictation text against master audio transcript
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('AI đang chấm độ chính xác câu chép của bạn!')),
                  );
                },
                icon: const Icon(Icons.check),
                label: const Text('Kiểm tra kết quả'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShadowingContent(ThemeData theme) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shadowing (Nghe và nhại lại - UR-LIS-006)',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Nghe từng câu và lặp lại theo đúng ngữ điệu của người bản xứ:',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 36,
                backgroundColor: Colors.red.withOpacity(0.12),
                child: IconButton(
                  icon: const Icon(Icons.mic, color: Colors.red, size: 36),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đang ghi âm và phân tích ngữ điệu Shadowing...')),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'Nhấn mic để bắt đầu nhại theo câu',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
