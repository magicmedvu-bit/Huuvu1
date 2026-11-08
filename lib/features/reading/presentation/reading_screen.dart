import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

class ReadingScreen extends StatefulWidget {
  const ReadingScreen({super.key});

  @override
  State<ReadingScreen> createState() => _ReadingScreenState();
}

class _ReadingScreenState extends State<ReadingScreen> {
  String _currentLang = AppConstants.langEn;
  bool _showTranslation = true;
  bool _showFuriganaOrPinyin = true;

  final Map<String, Map<String, dynamic>> _articles = {
    AppConstants.langEn: {
      'title': "Advances in Modern Pharmaceutical Research",
      'level': "TOEIC 600 • Intermediate",
      'paragraphs': [
        {
          'en': "The global pharmaceutical industry has witnessed tremendous growth in clinical technology over the past decade.",
          'vi': "Ngành công nghiệp dược phẩm toàn cầu đã chứng kiến sự phát triển vượt bậc về công nghệ lâm sàng trong thập kỷ qua.",
        },
        {
          'en': "Researchers and healthcare professionals collaborate continuously to develop innovative treatments for complex diseases.",
          'vi': "Các nhà nghiên cứu và chuyên gia y tế liên tục hợp tác để phát triển những phương pháp điều trị đột phá cho các căn bệnh phức tạp.",
        },
        {
          'en': "Rigorous quality control and adherence to international regulatory standards ensure patient safety worldwide.",
          'vi': "Kiểm soát chất lượng nghiêm ngặt và tuân thủ các tiêu chuẩn quản lý quốc tế đảm bảo an toàn cho bệnh nhân trên toàn thế giới.",
        },
      ],
      'quiz': [
        {
          'question': "What has grown tremendously over the past decade?",
          'options': ["Clinical technology", "Agricultural output", "Automobile sales", "Textile production"],
          'answer_idx': 0,
        }
      ]
    },
    AppConstants.langJa: {
      'title': "日本の仕事文化とコミュニケーション (Văn hóa làm việc Nhật Bản)",
      'level': "JLPT N3 • Intermediate",
      'paragraphs': [
        {
          'en': "日本の職場[しょくば]では、「報告[ほうこく]・連絡[れんらく]・相談[そうだん]」（ホウレンソウ）が非常に大切[たいせつ]です。",
          'vi': "Tại nơi làm việc của Nhật Bản, quy tắc 'Báo cáo - Liên lạc - Thảo luận' (Hou-Ren-So) là vô cùng quan trọng.",
        },
        {
          'en': "同僚[どうりょう]や上司[じょうし]と円滑[えんかつ]に仕事を進[すす]めるために、こまめな情報共有[じょうほうきょうゆう]が求[もと]められます。",
          'vi': "Để công việc diễn ra trôi chảy với đồng nghiệp và cấp trên, việc chủ động chia sẻ thông tin thường xuyên luôn được đề cao.",
        },
      ],
      'quiz': [
        {
          'question': "「ホウレンソウ」の『ソウ』は何を表していますか？",
          'options': ["相談 (Thảo luận)", "掃除 (Dọn dẹp)", "早期 (Thời kỳ đầu)", "想像 (Tưởng tượng)"],
          'answer_idx': 0,
        }
      ]
    },
    AppConstants.langZh: {
      'title': "现代职场中的团队合作 (Hợp tác nhóm nơi công sở hiện đại)",
      'level': "HSK 3 • Intermediate",
      'paragraphs': [
        {
          'en': "在现代[xiàndài]企业[qǐyè]中，良好[liánghǎo]的沟通[gōutōng]是团队[tuánduì]成功[chénggōng]的关键[guānjiàn]。",
          'vi': "Trong các doanh nghiệp hiện đại, giao tiếp tốt chính là chìa khóa then chốt cho thành công của một tập thể.",
        },
        {
          'en': "大家[dàjiā]共同[gòngtóng]努力[nǔlì]，不仅[bùjǐn]能提高[tígāo]工作[gōngzuò]效率[xiàolǜ]，还能互相[hùxiāng]学习[xuéxí]。",
          'vi': "Mọi người cùng nhau nỗ lực không chỉ nâng cao hiệu suất làm việc mà còn có thể học hỏi lẫn nhau.",
        },
      ],
      'quiz': [
        {
          'question': "团队成功的关键是什么？(Chìa khóa thành công của tập thể là gì?)",
          'options': ["良好的沟通 (Giao tiếp tốt)", "经常加班 (Thường xuyên tăng ca)", "单独工作 (Làm việc đơn độc)", "少说话 (Ít nói)"],
          'answer_idx': 0,
        }
      ]
    },
  };

  void _showWordLookupSheet(String word) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    word,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.volume_up, color: Color(0xFF2563EB)),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Nghĩa tiếng Việt: Thuộc về nghiên cứu và ứng dụng điều trị lâm sàng.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 6),
              const Text(
                'Từ loại: Tính từ (Adjective) • Cấp độ: B1 / TOEIC',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Đã lưu "$word" vào kho từ vựng ôn tập FSRS!')),
                    );
                  },
                  icon: const Icon(Icons.bookmark_add),
                  label: const Text('Lưu vào kho từ vựng cá nhân (UR-VOC-002)'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final article = _articles[_currentLang]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Luyện đọc (Reading)'),
        actions: [
          IconButton(
            icon: Icon(_showTranslation ? Icons.translate : Icons.g_translate),
            tooltip: 'Bật/Tắt dịch song ngữ (UR-REA-004)',
            onPressed: () => setState(() => _showTranslation = !_showTranslation),
          ),
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
            // Article Header
            Text(
              article['title'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                article['level'],
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: theme.primaryColor),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),

            // Paragraphs with interactive 1-tap word lookup
            ...(article['paragraphs'] as List).map((p) {
              return Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 4,
                      runSpacing: 6,
                      children: (p['en'] as String).split(' ').map((word) {
                        return InkWell(
                          onTap: () => _showWordLookupSheet(word),
                          borderRadius: BorderRadius.circular(4),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                            child: Text(
                              word,
                              style: const TextStyle(fontSize: 16, height: 1.5),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    if (_showTranslation) ...[
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          p['vi'],
                          style: TextStyle(fontSize: 13, color: Colors.grey[700], fontStyle: FontStyle.italic),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }),

            const SizedBox(height: 10),

            // Reading Comprehension Quiz (UR-REA-003)
            const Text(
              'Câu hỏi đọc hiểu (Comprehension Quiz)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article['quiz'][0]['question'],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(
                      (article['quiz'][0]['options'] as List).length,
                      (idx) {
                        final opt = article['quiz'][0]['options'][idx];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 14,
                            child: Text(String.fromCharCode(65 + idx), style: const TextStyle(fontSize: 12)),
                          ),
                          title: Text(opt, style: const TextStyle(fontSize: 13)),
                          onTap: () {
                            final isCorrect = idx == article['quiz'][0]['answer_idx'];
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(isCorrect ? '✅ Chính xác!' : '❌ Chưa chính xác, hãy đọc lại đoạn 1 nhé!'),
                                backgroundColor: isCorrect ? Colors.green : Colors.red,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
