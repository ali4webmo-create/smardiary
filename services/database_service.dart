import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  static Database? _db;
  static String? _dbPath;

  static Future<void> initialize(String path) async {
    _dbPath = path;
    _db = await openDatabase(path);
    // ایجاد جداول در صورت عدم وجود (همان ساختار دسکتاپ)
    await _createTablesIfNeeded();
  }

  static Future<void> _createTablesIfNeeded() async {
    if (_db == null) return;
    await _db!.execute('''
      CREATE TABLE IF NOT EXISTS daily_memories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date_shamsi TEXT,
        content TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
    await _db!.execute('''
      CREATE TABLE IF NOT EXISTS news_events (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date_shamsi TEXT,
        title TEXT,
        description TEXT,
        source TEXT,
        link TEXT,
        is_important INTEGER DEFAULT 0,
        is_rss INTEGER DEFAULT 0,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
    await _db!.execute('''
      CREATE TABLE IF NOT EXISTS work_events (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        date_shamsi TEXT,
        start_time TEXT,
        end_time TEXT,
        description TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
    await _db!.execute('''
      CREATE TABLE IF NOT EXISTS follow_ups (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        remind_date TEXT,
        is_done INTEGER DEFAULT 0,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    ''');
    await _db!.execute('''
      CREATE TABLE IF NOT EXISTS rss_sources (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        url TEXT,
        is_active INTEGER DEFAULT 1
      )
    ''');
    await _db!.execute('''
      CREATE TABLE IF NOT EXISTS settings (
        key TEXT PRIMARY KEY,
        value TEXT
      )
    ''');
    // تنظیمات پیش‌فرض
    await _db!.execute("INSERT OR IGNORE INTO settings (key, value) VALUES ('theme', 'Leather')");
  }

  static Database get db {
    if (_db == null) throw Exception('Database not initialized');
    return _db!;
  }

  static Future<void> importDatabaseFromFile(String filePath) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newPath = join(appDir.path, 'sarresid.db');
    await File(filePath).copy(newPath);
    _dbPath = newPath;
    // بستن و باز کردن مجدد
    if (_db != null) await _db!.close();
    _db = await openDatabase(newPath);
    // اطمینان از وجود جداول
    await _createTablesIfNeeded();
  }

  static Future<void> close() async {
    if (_db != null) await _db!.close();
  }

  // ====== متدهای عمومی CRUD ======

  static Future<List<Map<String, dynamic>>> query(String sql,
      [List<Object?>? args]) async {
    return await db.rawQuery(sql, args);
  }

  static Future<int> insert(String table, Map<String, dynamic> values) async {
    return await db.insert(table, values);
  }

  static Future<int> update(String table, Map<String, dynamic> values,
      {String? where, List<Object?>? whereArgs}) async {
    return await db.update(table, values,
        where: where, whereArgs: whereArgs);
  }

  static Future<int> delete(String table,
      {String? where, List<Object?>? whereArgs}) async {
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  // ====== متدهای اختصاصی ======

  static Future<List<Map<String, dynamic>>> getMemoriesByDate(String date) async {
    return await query(
        'SELECT * FROM daily_memories WHERE date_shamsi = ? ORDER BY id DESC',
        [date]);
  }

  static Future<List<Map<String, dynamic>>> getNewsByDate(String date) async {
    return await query(
        'SELECT * FROM news_events WHERE date_shamsi = ? ORDER BY id DESC',
        [date]);
  }

  static Future<List<Map<String, dynamic>>> getWorkEventsByDate(String date) async {
    return await query(
        'SELECT * FROM work_events WHERE date_shamsi = ? ORDER BY id DESC',
        [date]);
  }

  static Future<List<Map<String, dynamic>>> getFollowUps({bool? isDone}) async {
    String sql = 'SELECT * FROM follow_ups';
    if (isDone != null) sql += ' WHERE is_done = ${isDone ? 1 : 0}';
    sql += ' ORDER BY remind_date ASC';
    return await query(sql);
  }

  static Future<List<Map<String, dynamic>>> searchAll(String keyword) async {
    final like = '%$keyword%';
    final memories = await query(
        'SELECT * FROM daily_memories WHERE content LIKE ?', [like]);
    final news = await query(
        'SELECT * FROM news_events WHERE title LIKE ? OR description LIKE ?',
        [like, like]);
    final works = await query(
        'SELECT * FROM work_events WHERE description LIKE ?', [like]);
    final tasks = await query(
        'SELECT * FROM follow_ups WHERE title LIKE ?', [like]);
    return [...memories, ...news, ...works, ...tasks];
  }
}