import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/fsrs/fsrs_engine.dart';

class VocabItem {
  final String word;
  final String meaningVi;
  final String phonetic;
  final String example;
  final String language;
  final String status; // 'new', 'learning', 'review', 'known'

  const VocabItem({
    required this.word,
    required this.meaningVi,
    required this.phonetic,
    required this.example,
    required this.language,
    required this.status,
  });
}

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  String _currentLang = AppConstants.langEn;
  bool _isFlashcardFlipped = false;
  int _activeCardIndex = 0;

  final List<VocabItem> _sampleVocab = [
    const VocabItem(
      word: 'Pharmaceutical',
      meaningVi: 'Thuộc về dược phẩm, ngành dược',
      phonetic: '/ˌfɑːrməˈsuːtɪkl/',
      example: 'The pharmaceutical industry is growing rapidly.',
      language: 'en',
      status: 'learning',
    ),
    const VocabItem(
      word: 'Collaborate',
      meaningVi: 'Hợp tác, cộng tác trong công việc',
      phonetic: '/kəˈlæbəreɪt/',
      example: 'We need to collaborate closely with the research team.',
      language: 'en',
      status: 'review',
    ),
    const VocabItem(
      word: '会社 [かいしゃ]',
      meaningVi: 'Công ty, nơi làm việc',
      phonetic: 'kaisha',
      example: '毎日会社に行きます。(Mỗi ngày tôi đều đến công ty)',
      language: 'ja',
      status: 'learning',
    ),
    const VocabItem(
      word: '工作 [gōngzuò]',
      meaningVi: 'Công việc, làm việc',
      phonetic: 'gōngzuò',
      example: '你最近工作忙吗？(Dạo này bạn làm việc có bận không?)',
      language: 'zh',
      status: 'review',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filtered = _sampleVocab.where((v) => v.language == _currentLang).toList();
    final activeItem = filtered.isNotEmpty ? filtered[_activeCardIndex % filtered.length] : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Kho từ vựng & Flashcard'),
        actions: [
          PopupMenuButton<String>(
            initialValue: _currentLang,
            onSelected: (code) => setState(() {
              _currentLang = code;
              _isFlashcardFlipped = false;
              _activeCardIndex = 0;
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
            // Status Counters (New, Learning, Review, Known)
            _buildStatusCounters(),
            const SizedBox(height: 20),

            // Flashcard Interactive Box
            if (activeItem != null) ...[
              const Text(
                'Thẻ ôn tập FSRS (Chạm để lật mặt sau)',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              _buildFlashcard(theme, activeItem),
              const SizedBox(height: 20),

              // 4 FSRS Rating Buttons (Again, Hard, Good, Easy)
              if (_isFlashcardFlipped) ...[
                _buildFsrsButtons(theme),
              ],
            ] else ...[
              const Center(child: Text('Chưa có từ vựng nào trong danh mục này.')),
            ],
            const SizedBox(height: 30),

            // Vocabulary List in Current Language
            const Text(
              'Danh sách từ vựng gần đây',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...filtered.map((item) => _buildVocabListItem(theme, item)),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCounters() {
    return Row(
      children: [
        _buildCounterBadge('Mới', '45', Colors.blue),
        const SizedBox(width: 8),
        _buildCounterBadge('Đang học', '82', Colors.orange),
        const SizedBox(width: 8),
        _buildCounterBadge('Cần ôn', '18', Colors.red),
        const SizedBox(width: 8),
        _buildCounterBadge('Đã thuộc', '210', Colors.green),
      ],
    );
  }

  Widget _buildCounterBadge(String label, String count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Text(count, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: color)),
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 11, color: color)),
          ],
        ),
      ),
    );
  }

  Widget _buildFlashcard(ThemeData theme, VocabItem item) {
    return GestureDetector(
      onTap: () => setState(() => _isFlashcardFlipped = !_isFlashcardFlipped),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: double.infinity,
        height: 240,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: theme.primaryColor.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_isFlashcardFlipped) ...[
              Text(
                item.word,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                item.phonetic,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.touch_app, size: 16, color: theme.primaryColor),
                  const SizedBox(width: 6),
                  Text('Chạm để xem nghĩa', style: TextStyle(fontSize: 12, color: theme.primaryColor)),
                ],
              ),
            ] else ...[
              Text(
                item.meaningVi,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme.primaryColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 14),
              Text(
                'Ví dụ: ${item.example}',
                style: const TextStyle(fontSize: 13, fontStyle: FontStyle.italic, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFsrsButtons(ThemeData theme) {
    return Column(
      children: [
        const Text(
          'Đánh giá mức độ ghi nhớ (FSRS Algorithm):',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildFsrsBtn('Quên (10p)', Colors.red, FSRSRating.again),
            const SizedBox(width: 8),
            _buildFsrsBtn('Khó (1 ngày)', Colors.orange, FSRSRating.hard),
            const SizedBox(width: 8),
            _buildFsrsBtn('Tốt (3 ngày)', Colors.blue, FSRSRating.good),
            const SizedBox(width: 8),
            _buildFsrsBtn('Dễ (7 ngày)', Colors.green, FSRSRating.easy),
          ],
        ),
      ],
    );
  }

  Widget _buildFsrsBtn(String text, Color color, FSRSRating rating) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: () {
          setState(() {
            _isFlashcardFlipped = false;
            _activeCardIndex++;
          });
        },
        child: Text(text, style: const TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildVocabListItem(ThemeData theme, VocabItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(item.word, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        subtitle: Text('${item.phonetic} • ${item.meaningVi}'),
        trailing: IconButton(
          icon: const Icon(Icons.volume_up, color: Colors.grey),
          onPressed: () {},
        ),
      ),
    );
  }
}
