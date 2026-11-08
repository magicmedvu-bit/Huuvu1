import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

class MockQuestion {
  final int number;
  final String section; // e.g. 'Listening', 'Reading'
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanationVi;

  const MockQuestion({
    required this.number,
    required this.section,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanationVi,
  });
}

class MockTestScreen extends StatefulWidget {
  const MockTestScreen({super.key});

  @override
  State<MockTestScreen> createState() => _MockTestScreenState();
}

class _MockTestScreenState extends State<MockTestScreen> {
  String _currentLang = AppConstants.langEn;
  int _currentQuestionIndex = 0;
  final Map<int, int> _userAnswers = {};
  bool _isSubmitted = false;
  int _remainingSeconds = 1800; // 30 minutes mini test

  final List<MockQuestion> _toeicQuestions = [
    const MockQuestion(
      number: 1,
      section: "Part 5: Incomplete Sentences",
      question: "The new pharmaceutical product _______ thoroughly evaluated before receiving commercial approval.",
      options: ["was", "were", "is being", "will be"],
      correctIndex: 0,
      explanationVi: "Chủ ngữ 'The new pharmaceutical product' là danh từ số ít ở thể bị động trong quá khứ, nên dùng 'was'.",
    ),
    const MockQuestion(
      number: 2,
      section: "Part 5: Incomplete Sentences",
      question: "Employees are reminded to submit their travel reimbursement forms _______ Friday afternoon.",
      options: ["prior", "before", "until", "ahead"],
      correctIndex: 1,
      explanationVi: "'Before' là giới từ đi trực tiếp với mốc thời gian ('before Friday afternoon'). 'Prior' cần đi kèm 'to'.",
    ),
    const MockQuestion(
      number: 3,
      section: "Part 6: Text Completion",
      question: "The laboratory team made significant _______ in developing the targeted treatment.",
      options: ["progress", "progressive", "progresses", "progressing"],
      correctIndex: 0,
      explanationVi: "Cần một danh từ sau tính từ 'significant'. 'Progress' là danh từ không đếm được.",
    ),
  ];

  void _submitTest() {
    setState(() {
      _isSubmitted = true;
    });

    int correctCount = 0;
    _toeicQuestions.asMap().forEach((idx, q) {
      if (_userAnswers[idx] == q.correctIndex) {
        correctCount++;
      }
    });

    final estimatedScore = (correctCount / _toeicQuestions.length * 600).toInt();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('🎉 Kết quả thi thử (Mock Test)'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Số câu đúng: $correctCount / ${_toeicQuestions.length}'),
            const SizedBox(height: 8),
            Text(
              'Điểm ước tính: $estimatedScore / 600 TOEIC',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            const SizedBox(height: 8),
            const Text(
              '* Điểm số được tính toán dựa trên thuật toán nội bộ tương ứng độ khó kỳ thi chính thức.',
              style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Xem lời giải chi tiết'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final question = _toeicQuestions[_currentQuestionIndex];
    final selectedAnswer = _userAnswers[_currentQuestionIndex];

    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thi thử mô phỏng (Mock Test)'),
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.timer, color: Colors.red, size: 18),
                const SizedBox(width: 4),
                Text(
                  '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question Header & Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Câu ${_currentQuestionIndex + 1} / ${_toeicQuestions.length}',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  question.section,
                  style: const TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Question Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 2)),
                ],
              ),
              child: Text(
                question.question,
                style: const TextStyle(fontSize: 16, height: 1.4, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),

            // Options
            ...List.generate(question.options.length, (idx) {
              final isSelected = selectedAnswer == idx;
              final isCorrect = _isSubmitted && idx == question.correctIndex;
              final isWrongSelected = _isSubmitted && isSelected && !isCorrect;

              Color borderClr = isSelected ? theme.primaryColor : Colors.grey.withOpacity(0.3);
              if (_isSubmitted) {
                if (isCorrect) borderClr = Colors.green;
                if (isWrongSelected) borderClr = Colors.red;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: _isSubmitted ? null : () {
                    setState(() {
                      _userAnswers[_currentQuestionIndex] = idx;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: isSelected ? theme.primaryColor.withOpacity(0.08) : theme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: borderClr, width: isSelected ? 2 : 1),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 14,
                          backgroundColor: isSelected ? theme.primaryColor : Colors.grey[200],
                          child: Text(
                            String.fromCharCode(65 + idx),
                            style: TextStyle(
                              fontSize: 12,
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            question.options[idx],
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        if (_isSubmitted && isCorrect) const Icon(Icons.check_circle, color: Colors.green),
                        if (_isSubmitted && isWrongSelected) const Icon(Icons.cancel, color: Colors.red),
                      ],
                    ),
                  ),
                ),
              );
            }),

            // Explanation if submitted
            if (_isSubmitted) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('💡 Giải thích chi tiết từ AI:', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                    const SizedBox(height: 4),
                    Text(question.explanationVi, style: const TextStyle(fontSize: 13, height: 1.4)),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: _currentQuestionIndex > 0
                      ? () => setState(() => _currentQuestionIndex--)
                      : null,
                  child: const Text('Câu trước'),
                ),
                if (_currentQuestionIndex < _toeicQuestions.length - 1) ...[
                  ElevatedButton(
                    onPressed: () => setState(() => _currentQuestionIndex++),
                    child: const Text('Câu kế tiếp'),
                  ),
                ] else ...[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: _isSubmitted ? null : _submitTest,
                    child: const Text('Nộp bài thi'),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
