import 'package:flutter/material.dart';
import '../../../core/constants/app_constants.dart';

class ChatMessage {
  final String sender; // 'user' or 'ai'
  final String text;
  final String? translationVi;
  final String? furiganaOrPinyin;
  final Map<String, String>? errorCorrection; // original, corrected, category, explanation

  const ChatMessage({
    required this.sender,
    required this.text,
    this.translationVi,
    this.furiganaOrPinyin,
    this.errorCorrection,
  });
}

class AiTeacherScreen extends StatefulWidget {
  final bool isEmbedded;
  const AiTeacherScreen({super.key, this.isEmbedded = false});

  @override
  State<AiTeacherScreen> createState() => _AiTeacherScreenState();
}

class _AiTeacherScreenState extends State<AiTeacherScreen> {
  String _currentLang = AppConstants.langEn;
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isRecording = false;

  final List<ChatMessage> _messages = [
    const ChatMessage(
      sender: 'ai',
      text: "Hello! I am your AI English Coach. What would you like to practice today? We can practice workplace conversation or discuss your daily activities.",
      translationVi: "Xin chào! Tôi là Trợ lý AI Tiếng Anh của bạn. Hôm nay bạn muốn luyện tập chủ đề gì? Chúng ta có thể luyện giao tiếp công sở hoặc nói về công việc hằng ngày.",
    ),
    const ChatMessage(
      sender: 'user',
      text: "I am work in pharmaceutical company since three years.",
      errorCorrection: {
        'original': "I am work in pharmaceutical company since three years.",
        'corrected': "I have been working in a pharmaceutical company for three years.",
        'category': "Grammar & Preposition",
        'explanation': "Dùng thì hiện tại hoàn thành tiếp diễn (have been working) để diễn tả hành động bắt đầu trong quá khứ và vẫn đang tiếp diễn. Dùng 'for' thay vì 'since' trước khoảng thời gian (three years), và thêm mạo từ 'a' trước danh từ đếm được.",
        'natural': "I've been working at a pharma firm for 3 years now.",
      },
    ),
    const ChatMessage(
      sender: 'ai',
      text: "That is great! What is your typical day like as a pharmaceutical professional? What tasks do you handle most often?",
      translationVi: "Thật tuyệt! Một ngày làm việc điển hình của bạn trong ngành dược như thế nào? Nhiệm vụ nào bạn thường xử lý nhất?",
    ),
  ];

  void _sendMessage() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(sender: 'user', text: text));
      _inputController.clear();
    });

    _scrollToBottom();

    // Simulate AI response with smart correction
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        if (_currentLang == AppConstants.langJa) {
          _messages.add(const ChatMessage(
            sender: 'ai',
            text: "いいですね！仕事でよく使う日本語のフレーズを練習しましょう。(Hãy cùng luyện các mẫu câu tiếng Nhật thường dùng trong công việc nhé!)",
            furiganaOrPinyin: "いいですね！仕事[しごと]でよく使[つか]う日本語[にほんご]のフレーズを練習[れんしゅう]しましょう。",
            translationVi: "Hay lắm! Cùng luyện tập các cụm từ tiếng Nhật bạn thường dùng trong công việc nhé.",
          ));
        } else if (_currentLang == AppConstants.langZh) {
          _messages.add(const ChatMessage(
            sender: 'ai',
            text: "很好！我们来练习一下关于工作的常用句子吧。",
            furiganaOrPinyin: "Hěn hǎo! Wǒmen lái liànxí yīxià guānyú gōngzuò de chángyòng jùzi ba.",
            translationVi: "Rất tốt! Chúng ta hãy cùng luyện những câu nói thông dụng về công việc nhé.",
          ));
        } else {
          _messages.add(const ChatMessage(
            sender: 'ai',
            text: "Great answer! Tell me more about the project you are currently working on. What challenges are you facing?",
            translationVi: "Câu trả lời rất tốt! Hãy kể thêm cho tôi về dự án bạn đang thực hiện. Bạn đang đối mặt với những thử thách nào?",
          ));
        }
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final langInfo = AppConstants.languages[_currentLang]!;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !widget.isEmbedded,
        title: Row(
          children: [
            Text(langInfo['icon'], style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  langInfo['teacherName'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Mục tiêu: ${langInfo['benchmark']}',
                  style: TextStyle(fontSize: 11, color: theme.primaryColor),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // Language Switcher dropdown (EN / JA / ZH)
          PopupMenuButton<String>(
            initialValue: _currentLang,
            onSelected: (code) {
              setState(() {
                _currentLang = code;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: AppConstants.langEn, child: Text('🇬🇧 Tiếng Anh (TOEIC 600)')),
              const PopupMenuItem(value: AppConstants.langJa, child: Text('🇯🇵 Tiếng Nhật (JLPT N3)')),
              const PopupMenuItem(value: AppConstants.langZh, child: Text('🇨🇳 Tiếng Trung (HSK 3)')),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: theme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Text(langInfo['icon']),
                  const SizedBox(width: 4),
                  const Icon(Icons.arrow_drop_down, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat message list
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),

          // Voice / Input Bar
          _buildInputBar(theme),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage msg) {
    final isAi = msg.sender == 'ai';
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: isAi ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: isAi ? MainAxisAlignment.start : MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (isAi) ...[
                CircleAvatar(
                  backgroundColor: theme.primaryColor.withOpacity(0.15),
                  radius: 16,
                  child: Icon(Icons.smart_toy, size: 18, color: theme.primaryColor),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isAi ? theme.cardColor : theme.primaryColor,
                    borderRadius: BorderRadius.circular(16).copyWith(
                      bottomLeft: isAi ? const Radius.circular(0) : null,
                      bottomRight: !isAi ? const Radius.circular(0) : null,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (msg.furiganaOrPinyin != null) ...[
                        Text(
                          msg.furiganaOrPinyin!,
                          style: TextStyle(
                            fontSize: 12,
                            color: isAi ? Colors.grey[600] : Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                      Text(
                        msg.text,
                        style: TextStyle(
                          fontSize: 15,
                          color: isAi ? null : Colors.white,
                          height: 1.4,
                        ),
                      ),
                      if (msg.translationVi != null) ...[
                        const SizedBox(height: 8),
                        Text(
                          msg.translationVi!,
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: isAi ? Colors.grey[600] : Colors.white70,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (isAi) ...[
                IconButton(
                  icon: const Icon(Icons.volume_up, size: 18, color: Colors.grey),
                  onPressed: () {
                    // Trigger TTS playback
                  },
                ),
              ],
            ],
          ),

          // Smart Error Correction Card (UR-AI-004)
          if (msg.errorCorrection != null) ...[
            const SizedBox(height: 8),
            _buildErrorCorrectionCard(msg.errorCorrection!),
          ],
        ],
      ),
    );
  }

  Widget _buildErrorCorrectionCard(Map<String, String> err) {
    return Container(
      margin: const EdgeInsets.only(left: 32, top: 4),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2), // Light Red Warning
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFCA5A5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_fix_high, color: Color(0xFFDC2626), size: 18),
              const SizedBox(width: 6),
              Text(
                'Nhận xét từ AI [${err['category']}]',
                style: const TextStyle(
                  color: Color(0xFFDC2626),
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 13, color: Color(0xFF1F2937)),
              children: [
                const TextSpan(text: 'Câu sửa: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: err['corrected'] ?? '',
                  style: const TextStyle(
                    color: Color(0xFF059669),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            err['explanation'] ?? '',
            style: const TextStyle(fontSize: 12, color: Color(0xFF4B5563)),
          ),
          if (err['natural'] != null) ...[
            const SizedBox(height: 6),
            Text(
              'Gợi ý tự nhiên: ${err['natural']}',
              style: const TextStyle(fontSize: 12, color: Color(0xFF2563EB), fontWeight: FontWeight.w500),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInputBar(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.2))),
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Voice record button (STT)
            GestureDetector(
              onTapDown: (_) => setState(() => _isRecording = true),
              onTapUp: (_) => setState(() => _isRecording = false),
              child: CircleAvatar(
                backgroundColor: _isRecording ? Colors.red : theme.primaryColor.withOpacity(0.12),
                radius: 20,
                child: Icon(
                  _isRecording ? Icons.mic : Icons.mic_none,
                  color: _isRecording ? Colors.white : theme.primaryColor,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _inputController,
                decoration: const InputDecoration(
                  hintText: 'Nhập câu hoặc giữ mic để nói...',
                  hintStyle: TextStyle(fontSize: 14),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send, color: theme.primaryColor),
              onPressed: _sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
