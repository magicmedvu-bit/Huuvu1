import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Local Database Service managing Offline Caching & Synchronization
class DatabaseService {
  static final DatabaseService instance = DatabaseService._internal();
  DatabaseService._internal();

  static const String keyUserVocabulary = 'user_vocab_cache';
  static const String keyLearningProgress = 'learning_progress_cache';
  static const String keyDailyPlan = 'daily_plan_cache';
  static const String keyErrorPatterns = 'error_patterns_cache';

  Future<void> saveLocalVocab(List<Map<String, dynamic>> vocabList) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyUserVocabulary, jsonEncode(vocabList));
  }

  Future<List<Map<String, dynamic>>> getLocalVocab() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(keyUserVocabulary);
    if (data == null) return [];
    return (jsonDecode(data) as List).cast<Map<String, dynamic>>();
  }

  Future<void> recordStudySession({
    required String languageCode,
    required int durationSeconds,
    required String mode,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final key = 'progress_${languageCode}_$today';

    int currentSeconds = prefs.getInt(key) ?? 0;
    currentSeconds += durationSeconds;
    await prefs.setInt(key, currentSeconds);
  }

  Future<int> getTodayStudyDuration(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now().toIso8601String().substring(0, 10);
    final key = 'progress_${languageCode}_$today';
    return prefs.getInt(key) ?? 0;
  }
}
