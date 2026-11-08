import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

class GrammarRuleItem {
  final String title;
  final String level;
  final String formula;
  final String explanationVi;
  final List<String> examples;
  final String commonMistakes;
  final String exerciseQuestion;
  final List<String> exerciseOptions;
  final int correctOptionIndex;

  const GrammarRuleItem({
    required this.title,
    required this.level,
    required this.formula,
    required this.explanationVi,
    required this.examples,
    required this.commonMistakes,
    required this.exerciseQuestion,
    required this.exerciseOptions,
    required this.correctOptionIndex,
  });
}

class GrammarScreen extends StatefulWidget {
  const GrammarScreen({super.key});

  @override
  State<GrammarScreen> createState() => _GrammarScreenState();
}

class _GrammarScreenState extends State<GrammarScreen> {
  String _currentLang = AppConstants.langEn;

  final Map<String, List<GrammarRuleItem>> _grammarDatabase = {
    AppConstants.langEn: [
      const GrammarRuleItem(
        title: "Present Perfect Continuous (Hiện tại hoàn thành tiếp diễn)",
        level: "B1 • TOEIC 600",
        formula: "S + have/has + been + V-ing",
        explanationVi: "Diễn tả hành động bắt đầu trong quá khứ, tiếp diễn liên tục đến hiện tại và có thể kéo dài sang tương lai, nhấn mạnh vào tính liên tục hoặc kết quả còn đọng lại.",
        examples: [
          "I have been working at this pharmaceutical firm for 3 years.",
          "How long have you been studying Japanese?"
        ],
        commonMistakes: "Nhầm lẫn giữa 'since' (mốc thời gian: since 2021) và 'for' (khoảng thời gian: for 3 years).",
        exerciseQuestion: "She _______ at the laboratory since 8:00 AM.",
        exerciseOptions: ["is working", "has been working", "works", "worked"],
        correctOptionIndex: 1,
      ),
      const GrammarRuleItem(
        title: "Conditional Type 2 (Câu điều kiện loại 2)",
        level: "B1 • TOEIC 600",
        formula: "If + S + V-past, S + would/could + V-inf",
        explanationVi: "Diễn tả giả định không có thật hoặc khó xảy ra ở hiện tại.",
        examples: [
          "If I had more time, I would study Chinese every day.",
          "If he were the manager, he would approve the proposal."
        ],
        commonMistakes: "Dùng 'would' ở cả mệnh đề If, hoặc quên dùng 'were' thay cho 'was' trong văn phong học thuật.",
        exerciseQuestion: "If we _______ higher budget, we could hire more specialists.",
        exerciseOptions: ["have", "had", "will have", "would have"],
        correctOptionIndex: 1,
      ),
    ],
    AppConstants.langJa: [
      const GrammarRuleItem(
        title: "Phân biệt trợ từ は và が (Trợ từ chủ đề vs Trợ từ chủ ngữ)",
        level: "N5 - N4 - N3",
        formula: "A は B です / A が B をします",
        explanationVi: "「は」dùng để nêu chủ đề muốn nói đến (thông tin mới nằm ở vế sau). 「が」dùng để nhấn mạnh chính chủ thể hành động hoặc trong mệnh đề phụ.",
        examples: [
          "私[わたし]は薬局[やっきょく]で働[はたら]いています。(Tôi làm việc tại nhà thuốc.)",
          "だれが来[き]ましたか？ (Ai đã đến vậy? - Nhấn mạnh người đến)"
        ],
        commonMistakes: "Dùng 'は' trong câu nghi vấn hỏi 'Ai, Cái gì' (Phải dùng だれが、なにが).",
        exerciseQuestion: "田中さん _______ このプロジェクトの責任者です。",
        exerciseOptions: ["は", "を", "に", "へ"],
        correctOptionIndex: 0,
      ),
      const GrammarRuleItem(
        title: "Mẫu câu xin phép / Không được làm: 〜てもいいですか / 〜てはいけません",
        level: "JLPT N4 - N3",
        formula: "V-て + もいいですか / V-て + はいけません",
        explanationVi: "Dùng để hỏi xin phép lịch sự hoặc đưa ra lời cấm đoán trong môi trường công việc.",
        examples: [
          "ここで写真[しゃしん]を撮[と]ってもいいですか。(Tôi có thể chụp ảnh ở đây được không?)",
          "会議中[かいぎちゅう]に電話[でんわ]をしてはいけません。(Không được gọi điện trong giờ họp.)"
        ],
        commonMistakes: "Chia sai thể て của động từ nhóm 1 (e.g. 書く -> 書いて).",
        exerciseQuestion: "ここでたばこを吸っ _______ いけません。",
        exerciseOptions: ["ても", "ては", "たら", "てもいい"],
        correctOptionIndex: 1,
      ),
    ],
    AppConstants.langZh: [
      const GrammarRuleItem(
        title: "Câu chữ 把 (Bǎ) - Biểu thị hành động tác động làm thay đổi vị trí/trạng thái",
        level: "HSK 3",
        formula: "S + 把 + Tân ngữ + Động từ + Thành phần khác",
        explanationVi: "Nhấn mạnh kết quả hoặc sự xử lý đối với tân ngữ.",
        examples: [
          "请把报告发给我。(Xin hãy gửi báo cáo cho tôi.)",
          "我把药吃完了。(Tôi đã uống hết thuốc rồi.)"
        ],
        commonMistakes: "Để tân ngữ phía sau động từ chính thay vì đứng ngay sau chữ 把.",
        exerciseQuestion: "请 _______ 这份文件打印一下。",
        exerciseOptions: ["被", "把", "在", "向"],
        correctOptionIndex: 1,
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final rules = _grammarDatabase[_currentLang] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ngữ pháp (Grammar Hub)'),
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
                  Text(AppConstants.languages[_currentLang]!['icon'], style: const TextStyle(fontSize: 18)),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: rules.length,
        itemBuilder: (context, index) {
          final rule = rules[index];
          return _buildGrammarCard(theme, rule);
        },
      ),
    );
  }

  Widget _buildGrammarCard(ThemeData theme, GrammarRuleItem rule) {
    return Card(
      margin: const EdgeInsets.only(bottom: 20),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    rule.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    rule.level,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: theme.primaryColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Formula Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFBFDBFE)),
              ),
              child: Text(
                'Cấu trúc: ${rule.formula}',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E40AF), fontSize: 13),
              ),
            ),
            const SizedBox(height: 12),

            // Explanation
            Text(rule.explanationVi, style: const TextStyle(fontSize: 13, height: 1.4)),
            const SizedBox(height: 12),

            // Examples
            const Text('Ví dụ minh họa:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 6),
            ...rule.examples.map((ex) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  Expanded(child: Text(ex, style: const TextStyle(fontSize: 13))),
                ],
              ),
            )),
            const SizedBox(height: 10),

            // Common Mistakes
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFDE68A)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.warning_amber_rounded, color: Color(0xFFD97706), size: 18),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Lỗi thường gặp: ${rule.commonMistakes}',
                      style: const TextStyle(fontSize: 12, color: Color(0xFF92400E)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Exercise Quiz
            const Text('Bài tập áp dụng:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            const SizedBox(height: 6),
            Text(rule.exerciseQuestion, style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: List.generate(rule.exerciseOptions.length, (idx) {
                return OutlinedButton(
                  onPressed: () {
                    final isCorrect = idx == rule.correctOptionIndex;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isCorrect ? '✅ Chính xác!' : '❌ Chưa chính xác, hãy xem lại công thức nhé!'),
                        backgroundColor: isCorrect ? Colors.green : Colors.red,
                      ),
                    );
                  },
                  child: Text(rule.exerciseOptions[idx]),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
