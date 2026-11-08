import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

class MaterialsScreen extends StatefulWidget {
  const MaterialsScreen({super.key});

  @override
  State<MaterialsScreen> createState() => _MaterialsScreenState();
}

class _MaterialsScreenState extends State<MaterialsScreen> {
  final TextEditingController _textController = TextEditingController();
  bool _isProcessing = false;
  Map<String, dynamic>? _extractedLesson;

  void _analyzeMaterial() {
    final text = _textController.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng nhập văn bản hoặc tải tài liệu lên.')),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    // Simulate AI extraction of Vocabulary, Grammar & Flashcards from user uploaded document
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isProcessing = false;
        _extractedLesson = {
          'detected_lang': 'English (Tiếng Anh)',
          'summary': 'Tài liệu thảo luận về công nghệ sản xuất và kiểm định dược phẩm theo chuẩn quốc tế.',
          'vocab_extracted': [
            {'word': 'Evaluation', 'meaning': 'Sự đánh giá, thẩm định tiêu chuẩn'},
            {'word': 'Compliance', 'meaning': 'Sự tuân thủ các quy định'},
            {'word': 'Sterilization', 'meaning': 'Quá trình tiệt trùng y tế'},
          ],
          'ai_questions': [
            'Câu 1: What are the main requirements for compliance?',
            'Câu 2: How often is sterilization monitored?'
          ]
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài liệu cá nhân (Document Import)'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Import Options: Paste Text, PDF, OCR Camera
            Row(
              children: [
                _buildImportOption(
                  icon: Icons.edit_note,
                  label: 'Dán văn bản',
                  color: Colors.blue,
                  onTap: () {},
                ),
                const SizedBox(width: 10),
                _buildImportOption(
                  icon: Icons.picture_as_pdf,
                  label: 'Tải file PDF',
                  color: Colors.red,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đang chọn file PDF từ bộ nhớ máy...')),
                    );
                  },
                ),
                const SizedBox(width: 10),
                _buildImportOption(
                  icon: Icons.document_scanner,
                  label: 'Chụp ảnh OCR',
                  color: Colors.teal,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đang khởi động Camera OCR nhận diện chữ...')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Text Input Box
            const Text(
              'Nội dung tài liệu (UR-MAT-001):',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _textController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Dán đoạn văn bản tài liệu công việc, bài báo hoặc email cần AI tạo bài học...',
                filled: true,
                fillColor: theme.cardColor,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 14),

            // Action Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _isProcessing ? null : _analyzeMaterial,
                icon: _isProcessing
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.auto_awesome),
                label: Text(_isProcessing ? 'AI đang bóc tách kiến thức...' : 'Tạo bài học cá nhân từ tài liệu (UR-MAT-002)'),
              ),
            ),
            const SizedBox(height: 24),

            // AI Extracted Content Card
            if (_extractedLesson != null) ...[
              _buildExtractedLessonCard(theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildImportOption({
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
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 26),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExtractedLessonCard(ThemeData theme) {
    final vocab = (_extractedLesson?['vocab_extracted'] as List?) ?? [];
    final questions = (_extractedLesson?['ai_questions'] as List?) ?? [];

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  'Bài học AI tạo từ tài liệu (${_extractedLesson?['detected_lang']})',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Tóm tắt nội dung: ${_extractedLesson?['summary']}',
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const Divider(height: 24),
            const Text(
              'Từ vựng trọng tâm được trích xuất (Tự động thêm vào Flashcard):',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 8),
            ...vocab.map((v) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  const Icon(Icons.bookmark, size: 16, color: Colors.blue),
                  const SizedBox(width: 6),
                  Text('${v['word']}: ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  Expanded(child: Text(v['meaning'], style: const TextStyle(fontSize: 13))),
                ],
              ),
            )),
            const SizedBox(height: 14),
            const Text(
              'Câu hỏi trắc nghiệm tự động sinh từ văn bản:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 6),
            ...questions.map((q) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(q, style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
            )),
          ],
        ),
      ),
    );
  }
}
