import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:clearmind_app/models/journal_entry.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'journal_entries.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE entries(id INTEGER PRIMARY KEY AUTOINCREMENT, content TEXT, mood TEXT)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertJournalEntry(JournalEntry entry) async {
    final db = await database;
    await db.insert(
      'entries',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<JournalEntry>> getJournalEntries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('entries');
    return List.generate(maps.length, (i) {
      return JournalEntry(
        id: maps[i]['id'],
        content: maps[i]['content'],
        mood: maps[i]['mood'],
      );
    });
  }

  Future<void> deleteJournalEntry(int id) async {
    final db = await database;
    await db.delete(
      'entries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
