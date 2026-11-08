import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'AI Language Coach';
  static const String appSubtitle = 'Học Tiếng Anh - Tiếng Nhật - Tiếng Trung với AI';

  // Supported Languages
  static const String langEn = 'en';
  static const String langJa = 'ja';
  static const String langZh = 'zh';

  // Target Benchmarks Phase 1
  static const String benchmarkEn = 'TOEIC 600';
  static const String benchmarkJa = 'JLPT N3';
  static const String benchmarkZh = 'HSK 3';

  // Language display metadata
  static const Map<String, Map<String, dynamic>> languages = {
    langEn: {
      'name': 'Tiếng Anh',
      'code': 'en',
      'benchmark': 'TOEIC 600',
      'script': 'Latin / IPA',
      'color': Color(0xFF1E88E5), // Blue
      'accent': Color(0xFF90CAF9),
      'icon': '🇬🇧',
      'teacherName': 'English Coach AI',
    },
    langJa: {
      'name': 'Tiếng Nhật',
      'code': 'ja',
      'benchmark': 'JLPT N3',
      'script': 'Kanji / Furigana',
      'color': Color(0xFFE53935), // Red
      'accent': Color(0xFFEF9A9A),
      'icon': '🇯🇵',
      'teacherName': 'Sensei AI (日本語)',
    },
    langZh: {
      'name': 'Tiếng Trung',
      'code': 'zh',
      'benchmark': 'HSK 3',
      'script': 'Hán tự / Pinyin',
      'color': Color(0xFFFB8C00), // Orange / Amber
      'accent': Color(0xFFFFCC80),
      'icon': '🇨🇳',
      'teacherName': 'Lǎoshī AI (普通话)',
    },
  };

  // Audio Speeds (UR-LIS-002)
  static const List<double> audioSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5];

  // 4 Core Skills
  static const String skillListening = 'listening';
  static const String skillSpeaking = 'speaking';
  static const String skillReading = 'reading';
  static const String skillWriting = 'writing';

  // FSRS States
  static const String fsrsNew = 'new';
  static const String fsrsLearning = 'learning';
  static const String fsrsReview = 'review';
  static const String fsrsKnown = 'known';
}
