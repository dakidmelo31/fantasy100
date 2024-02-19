import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class GeminiManager {
  static final GeminiManager _instance = GeminiManager._internal();

  factory GeminiManager() => _instance;

  GeminiManager._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'gemini.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS data (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        data TEXT NOT NULL,
        query TEXT NOT NULL,
        timestamp DATETIME NOT NULL
      )
    ''');
  }

  Future<void> insertData(String data, String query) async {
    final db = await database;
    await db.insert('data', {
      'data': data,
      'query': query,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  Future<void> updateData(int id, String data, String query) async {
    final db = await database;
    await db.update(
        'data',
        {
          'data': data,
          'query': query,
          'timestamp': DateTime.now().toIso8601String(),
        },
        where: 'id = ?',
        whereArgs: [id]);
  }

  Future<Map<String, dynamic>?> selectData(int id) async {
    final db = await database;
    final result = await db.query('data', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> selectAllData() async {
    final db = await database;
    final result = await db.query('data');
    return result;
  }

  Future<void> deleteData(int id) async {
    final db = await database;
    await db.delete('data', where: 'id = ?', whereArgs: [id]);
  }
}
