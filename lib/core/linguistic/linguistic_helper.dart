class FuriganaChunk {
  final String kanji;
  final String? reading;

  const FuriganaChunk({required this.kanji, this.reading});

  bool get hasFurigana => reading != null && reading!.isNotEmpty;
}

class LinguisticHelper {
  /// Parses Japanese text with Furigana syntax e.g. "私[わたし]は日本[にほん]に行[い]く"
  static List<FuriganaChunk> parseJapaneseFurigana(String text) {
    final List<FuriganaChunk> result = [];
    final regex = RegExp(r'([一-龯々]+)\[([ぁ-んァ-ヶ]+)\]');

    int lastIndex = 0;
    for (final match in regex.allMatches(text)) {
      if (match.start > lastIndex) {
        result.add(FuriganaChunk(kanji: text.substring(lastIndex, match.start)));
      }
      final kanji = match.group(1)!;
      final reading = match.group(2)!;
      result.add(FuriganaChunk(kanji: kanji, reading: reading));
      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      result.add(FuriganaChunk(kanji: text.substring(lastIndex)));
    }

    return result;
  }

  /// Converts Pinyin with numbers (e.g. "ni3 hao3") to accented characters ("nǐ hǎo")
  static String formatPinyinWithTones(String input) {
    final toneMap = {
      'a': ['ā', 'á', 'ǎ', 'à', 'a'],
      'e': ['ē', 'é', 'ě', 'è', 'e'],
      'i': ['ī', 'í', 'ǐ', 'ì', 'i'],
      'o': ['ō', 'ó', 'ǒ', 'ò', 'o'],
      'u': ['ū', 'ú', 'ǔ', 'ù', 'u'],
      'v': ['ǖ', 'ǘ', 'ǚ', 'ǜ', 'ü'],
    };

    final words = input.split(' ');
    final converted = words.map((w) {
      final match = RegExp(r'([a-zA-Z]+)([1-5])').firstMatch(w);
      if (match == null) return w;

      String syllable = match.group(1)!;
      int tone = int.parse(match.group(2)!) - 1; // 0-based

      if (tone < 0 || tone > 4) return syllable;

      // Find primary vowel to place tone mark
      for (final vowel in ['a', 'e', 'o', 'u', 'i', 'v']) {
        if (syllable.contains(vowel)) {
          final replacement = toneMap[vowel]![tone];
          return syllable.replaceFirst(vowel, replacement);
        }
      }
      return syllable;
    });

    return converted.join(' ');
  }

  /// Highlight English syllable stress (e.g., /prəˌnʌnsiˈeɪʃn/)
  static String formatEnglishIPA(String ipa) {
    return ipa.replaceAll('ˈ', ' ˈ').trim();
  }
}
