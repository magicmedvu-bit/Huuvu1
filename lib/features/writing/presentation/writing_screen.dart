import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/ai/ai_service.dart';

class WritingScreen extends StatefulWidget {
  const WritingScreen({super.key});

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  String _currentLang = AppConstants.langEn;
  final TextEditingController _textController = TextEditingController();
  bool _isEvaluating = false;
  Map<String, dynamic>? _feedbackResult;

  final Map<String, List<String>> _topics = {
    AppConstants.langEn: [
      "Writing a Business Email: Requesting the quarterly sales report from a colleague.",
      "Reporting an Issue: Describing a shipping delay to an international supplier.",
      "Workplace Communication: Sharing minutes of meeting with the team.",
    ],
    AppConstants.langJa: [
      "メール (Viết email): Cảm ơn đối tác sau buổi gặp mặt đàm phán hợp đồng.",
      "仕事の報告 (Báo cáo công việc): Báo cáo tiến độ dự án tuần này với cấp trên.",
      "日記 (Nhật ký): Ghi lại những bài học mới trong công việc ngày hôm nay.",
    ],
    AppConstants.langZh: [
      "自我介绍 (Giới thiệu bản thân): Viết đoạn văn ứng tuyển vào vị trí chuyên viên đối ngoại.",
      "我的工作 (Công việc của tôi): Giới thiệu về quy trình sản xuất và kiểm nghiệm tại công ty.",
      "业务邮件 (Email kinh doanh): Xác nhận thời gian họp trực tuyến với đối tác Trung Quốc.",
    ],
  };

  int _selectedTopicIndex = 0;

  void _submitForCorrection() async {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập nội dung bài viết trước khi nộp.')),
      );
      return;
    }

    setState(() {
      _isEvaluating = true;
    });

    final res = await AiService.instance.invokePrompt(
      promptId: 'AI-007',
      variables: {
        'user_text': text,
        'language': _currentLang,
        'topic': _topics[_currentLang]![_selectedTopicIndex],
      },
    );

    setState(() {
      _isEvaluating = false;
      _feedbackResult = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final topics = _topics[_currentLang]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Luyện viết (Writing)'),
        actions: [
          PopupMenuButton<String>(
            initialValue: _currentLang,
            onSelected: (code) => setState(() {
              _currentLang = code;
              _selectedTopicIndex = 0;
              _feedbackResult = null;
            }),
            itemBuilder: (context) => [
              const PopupMenuItem(value: AppConstants.langEn, child: Text('🇬🇧 English')),
              const PopupMenuItem(value: AppConstants.langJa, child: Text('🇯🇵 Japanese')),
              const PopupMenuItem(value: AppConstants.langZh, child: Text('🇨🇳 Chinese')),
            ],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(AppConstants.languages[_currentLang]!['icon'], style: const TextStyle(fontSize: 18)),
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
            // Topic Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'CHỦ ĐỀ VIẾT THỰC TẾ (UR-WRI-004)',
                          style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey),
                        ),
                        PopupMenuButton<int>(
                          icon: const Icon(Icons.swap_horiz, size: 20),
                          tooltip: 'Đổi chủ đề',
                          onSelected: (idx) => setState(() => _selectedTopicIndex = idx),
                          itemBuilder: (context) => List.generate(
                            topics.length,
                            (idx) => PopupMenuItem(value: idx, child: Text(topics[idx])),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      topics[_selectedTopicIndex],
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Text Input Field
            TextField(
              controller: _textController,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: 'Nhập bài viết bằng ${_currentLang.toUpperCase()} tại đây...\nVí dụ: Dear Mr. Tanaka, I am writing to submit...',
                filled: true,
                fillColor: theme.cardColor,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 14),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _isEvaluating ? null : _submitForCorrection,
                icon: _isEvaluating
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.auto_awesome),
                label: Text(
                  _isEvaluating ? 'AI đang phân tích & chữa bài...' : 'Nộp bài để AI sửa lỗi (UR-WRI-002)',
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // AI Feedback Card
            if (_feedbackResult != null) ...[
              _buildFeedbackCard(theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackCard(ThemeData theme) {
    final score = _feedbackResult?['score_100'] ?? 85;
    final correctedText = _feedbackResult?['corrected_text'] ?? "";
    final corrections = (_feedbackResult?['corrections'] as List?) ?? [];
    final evalVi = _feedbackResult?['overall_evaluation_vi'] ?? "";

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Kết quả sửa lỗi từ AI Teacher',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Điểm: $score/100',
                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            const Text(
              'Bản sửa chuẩn tự nhiên:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.blue),
            ),
            const SizedBox(height: 6),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.06),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.withOpacity(0.2)),
              ),
              child: Text(
                correctedText,
                style: const TextStyle(fontSize: 14, height: 1.4),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Chi tiết các lỗi được sửa:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 8),
            ...corrections.map((c) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_right, color: Colors.red),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 13, color: Colors.black87),
                              children: [
                                TextSpan(
                                  text: "${c['segment_original']} ",
                                  style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.red),
                                ),
                                const TextSpan(text: " ➔ "),
                                TextSpan(
                                  text: "${c['segment_corrected']}",
                                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            c['reason_vi'] ?? "",
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 10),
            Text(
              'Đánh giá chung: $evalVi',
              style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}
