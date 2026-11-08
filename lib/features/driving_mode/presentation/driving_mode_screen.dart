import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

class DrivingModeScreen extends StatefulWidget {
  const DrivingModeScreen({super.key});

  @override
  State<DrivingModeScreen> createState() => _DrivingModeScreenState();
}

class _DrivingModeScreenState extends State<DrivingModeScreen> {
  bool _isPlaying = true;
  String _currentLang = AppConstants.langEn;
  String _currentTopic = "Vocabulary & Listening Q&A";

  @override
  Widget build(BuildContext context) {
    // High contrast, distraction-free dark theme for driving safety
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A), // Dark slate
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text('Chế độ Lái xe (Driving Mode)', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, size: 28),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Safety Warning Banner (UR-DRV-004)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.withOpacity(0.4)),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 22),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Chế độ 100% âm thanh rảnh tay. Vui lòng tập trung lái xe an toàn!',
                        style: TextStyle(color: Colors.amber, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),

              // Active AI Voice Interaction Indicator
              Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isPlaying ? const Color(0xFF10B981).withOpacity(0.2) : Colors.grey.withOpacity(0.1),
                      border: Border.all(
                        color: _isPlaying ? const Color(0xFF10B981) : Colors.grey,
                        width: 3,
                      ),
                    ),
                    child: Icon(
                      _isPlaying ? Icons.record_voice_over : Icons.voice_over_off,
                      size: 60,
                      color: _isPlaying ? const Color(0xFF10B981) : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _isPlaying ? 'AI đang nói...' : 'Đã tạm dừng',
                    style: TextStyle(
                      color: _isPlaying ? const Color(0xFF10B981) : Colors.grey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Chủ đề: $_currentTopic',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ngôn ngữ: ${AppConstants.languages[_currentLang]!['name']}',
                    style: const TextStyle(color: Colors.white60, fontSize: 13),
                  ),
                ],
              ),

              // Huge Single-Tap Control Buttons for Driver Hand Reach
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 75,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isPlaying ? const Color(0xFFEF4444) : const Color(0xFF10B981),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                      onPressed: () {
                        setState(() {
                          _isPlaying = !_isPlaying;
                        });
                      },
                      icon: Icon(_isPlaying ? Icons.pause_circle : Icons.play_circle, size: 36),
                      label: Text(
                        _isPlaying ? 'CHẠM ĐỂ TẠM DỪNG' : 'CHẠM ĐỂ TIẾP TỤC',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white30),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.replay_10),
                          label: const Text('Nghe lại câu'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white30),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () {},
                          icon: const Icon(Icons.skip_next),
                          label: const Text('Bỏ qua câu'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
