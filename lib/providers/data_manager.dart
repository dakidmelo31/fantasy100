import 'package:flutter/material.dart';
import 'package:hospital/pages/chat/gemini_chat.dart';
import 'package:hospital/utils/globals.dart';
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
      CREATE TABLE IF NOT EXISTS chats (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT NOT NULL,
        sentAt int,
        image TEXT NULL,
        isMe int NOT NULL
      )
    ''');
  }

  Future<void> insertMsg(String content,
      {String image = '', int isMe = 1}) async {
    final db = await database;
    await db
        .insert('chats', {
          'content': content,
          'sentAt': DateTime.now().millisecondsSinceEpoch,
          "image": image,
          "isMe": isMe
        })
        .then((value) => debugPrint("$value"))
        .catchError((onError) {
          toast(message: "error inserting chat");
          debugPrint("Error: $onError");
        });
  }

  Future<void> updateData(int id, String content,
      {String image = '', int isMe = 1}) async {
    final db = await database;
    await db.update(
        'chats',
        {
          'content': content,
          'sentAt': DateTime.now().millisecondsSinceEpoch,
          "image": image,
          "isMe": isMe
        },
        where: 'id = ?',
        whereArgs: [id]);
  }

  loadChats() async {
    final db = await database;
    var data = await db.query("chats");
    List<Message> msg = [];
    for (Map<String, dynamic> item in data) {
      msg.add(Message(
          isCurrentUser: item['isMe'] == 1,
          content: item['content'],
          sentAt: DateTime.fromMillisecondsSinceEpoch(item['sentAt'])));
    }
    return msg;
  }

  Future<Map<String, dynamic>?> selectMsg(int id) async {
    final db = await database;
    final result = await db.query('chats', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<List<Map<String, dynamic>>> selectAllData() async {
    final db = await database;
    final result = await db.query('chats');
    return result;
  }

  Future<void> deleteData(int id) async {
    final db = await database;
    await db.delete('chats', where: 'id = ?', whereArgs: [id]);
  }
}
