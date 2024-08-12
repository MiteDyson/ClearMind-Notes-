// lib/models/journal_entry.dart

class JournalEntry {
  final String content;
  final String mood;

  JournalEntry({required this.content, required this.mood, required id});

  get id => null;

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'mood': mood,
    };
  }
}
