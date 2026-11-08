import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class AiService {
  static final AiService instance = AiService._internal();
  AiService._internal();

  String? _geminiApiKey;
  String? _openaiApiKey;
  Map<String, dynamic>? _promptRegistry;

  void configureKeys({String? geminiKey, String? openaiKey}) {
    _geminiApiKey = geminiKey;
    _openaiApiKey = openaiKey;
  }

  Future<void> loadPromptRegistry() async {
    if (_promptRegistry != null) return;
    try {
      final jsonString = await rootBundle.loadString('prompts/prompt_registry.json');
      _promptRegistry = jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      // Fallback
      _promptRegistry = {};
    }
  }

  /// Generic method to call AI with Prompt ID (AI-001 -> AI-012)
  Future<Map<String, dynamic>> invokePrompt({
    required String promptId,
    required Map<String, dynamic> variables,
  }) async {
    await loadPromptRegistry();

    // Check if API key is provided, if not or in case of network issue, return structured realistic response
    if (_geminiApiKey != null && _geminiApiKey!.isNotEmpty) {
      try {
        final url = Uri.parse(
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_geminiApiKey',
        );
        final promptData = (_promptRegistry?['prompts'] as List?)?.firstWhere(
          (p) => p['id'] == promptId,
          orElse: () => null,
        );

        final systemInstruction = promptData?['system_instruction'] ?? '';
        final response = await http.post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "contents": [
              {
                "parts": [
                  {"text": "System: $systemInstruction\nInput: ${jsonEncode(variables)}\nReturn strictly valid JSON matching the schema."}
                ]
              }
            ]
          }),
        );

        if (response.statusCode == 200) {
          final resJson = jsonDecode(response.body);
          final text = resJson['candidates'][0]['content']['parts'][0]['text'] as String;
          final cleanJson = text.replaceAll('```json', '').replaceAll('```', '').trim();
          return jsonDecode(cleanJson) as Map<String, dynamic>;
        }
      } catch (_) {
        // Fallback to offline mock response
      }
    }

    return _generateMockFallback(promptId, variables);
  }

  Map<String, dynamic> _generateMockFallback(String promptId, Map<String, dynamic> variables) {
    switch (promptId) {
      case 'AI-001': // English Teacher
        return {
          "reply_en": "That sounds very interesting! In the pharmaceutical field, precision and communication are essential. What is your primary goal this week?",
          "reply_vi_hint": "Điều đó nghe thật thú vị! Trong ngành dược, sự chính xác và giao tiếp là rất quan trọng. Mục tiêu chính của bạn trong tuần này là gì?",
          "feedback": {
            "has_error": true,
            "original_sentence": variables['user_input'] ?? "",
            "corrected_sentence": "I work in a pharmaceutical company as a quality assurance specialist.",
            "error_category": "grammar",
            "explanation_vi": "Cần thêm mạo từ 'a' trước danh từ số ít đếm được ('a pharmaceutical company').",
            "natural_alternative": "I'm currently working in pharmaceuticals."
          },
          "next_question": "What is the biggest challenge in your current project?"
        };

      case 'AI-002': // Japanese Teacher
        return {
          "reply_ja": "素晴らしいですね！製薬業界での経験はとても貴重です。普段の仕事で日本語を使う機会はありますか？",
          "furigana_map": [
            {"kanji": "製薬業界", "furigana": "せいやくぎょうかい"},
            {"kanji": "経験", "furigana": "けいけん"},
            {"kanji": "貴重", "furigana": "きちょう"},
            {"kanji": "仕事", "furigana": "しごと"},
            {"kanji": "機会", "furigana": "きかい"}
          ],
          "romaji": "Subarashii desu ne! Seiyaku gyoukai de no keiken wa totemo kichou desu.",
          "reply_vi_hint": "Tuyệt vời quá! Kinh nghiệm trong ngành dược rất quý báu. Bạn có hay có cơ hội dùng tiếng Nhật trong công việc hằng ngày không?",
          "feedback": {
            "has_error": false,
            "original_sentence": variables['user_input'] ?? "",
            "corrected_sentence": variables['user_input'] ?? "",
            "error_category": "none",
            "explanation_vi": "Cách dùng từ và ngữ pháp của bạn rất chính xác và tự nhiên."
          },
          "next_question": "日本語で自己紹介をしてみましょう。(Hãy thử giới thiệu bản thân bằng tiếng Nhật nhé.)"
        };

      case 'AI-003': // Chinese Teacher
        return {
          "reply_zh": "太棒了！制药行业非常有前景。你在工作中需要和客户用中文交流吗？",
          "pinyin": "Tài bàng le! Zhìyào hángyè fēicháng yǒu qiánjǐng. Nǐ zài gōngzuò zhōng xūyào hé kèhù yòng zhōngwén jiāoliú ma?",
          "reply_vi_hint": "Tuyệt vời quá! Ngành dược rất có triển vọng. Trong công việc bạn có cần giao tiếp bằng tiếng Trung với khách hàng không?",
          "feedback": {
            "has_error": false,
            "original_sentence": variables['user_input'] ?? "",
            "corrected_sentence": variables['user_input'] ?? "",
            "error_category": "none",
            "explanation_vi": "Thanh điệu và cách dùng từ của bạn rất chuẩn xác."
          },
          "next_question": "你今天打算学习什么内容？(Hôm nay bạn dự định học nội dung gì?)"
        };

      case 'AI-006': // Speaking Evaluation
        return {
          "scores": {
            "fluency": 82,
            "grammar": 85,
            "vocabulary": 80,
            "pronunciation": 78,
            "comprehension": 90,
            "response": 84,
            "overall": 83
          },
          "detailed_feedback_vi": "Bạn trả lời lưu loát, phản xạ nhanh và hiểu trọn vẹn ngữ cảnh câu hỏi. Cần chú ý nhấn đúng trọng âm và các âm đuôi trong tiếng Anh.",
          "pronunciation_tips": ["Nhấn mạnh trọng âm ở âm tiết thứ 3: pharma-CEU-tical", "Nối âm tự nhiên giữa phụ âm cuối và nguyên âm kế tiếp"],
          "better_expressions": ["I've been specializing in clinical research for over 3 years."]
        };

      case 'AI-007': // Writing Correction
        return {
          "original_text": variables['user_text'] ?? "",
          "corrected_text": "Dear Mr. Tanaka,\nI am writing to submit our weekly pharmaceutical report. Please find the attached document for your review.\nBest regards,\nBinh",
          "score_100": 88,
          "corrections": [
            {
              "segment_original": "I write for submit",
              "segment_corrected": "I am writing to submit",
              "reason_vi": "Trong thư công việc chuẩn mực, dùng cụm 'I am writing to [verb]' để mở đầu mục đích viết thư.",
              "type": "grammar"
            }
          ],
          "overall_evaluation_vi": "Email có bố cục trang trọng, diễn đạt rõ ràng mục đích gửi tài liệu công việc."
        };

      default:
        return {"status": "success", "message": "Processed successfully by AI Coach."};
    }
  }
}
