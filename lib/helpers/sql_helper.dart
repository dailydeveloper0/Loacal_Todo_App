import 'package:sqflite/sqflite.dart';

class SQLHelper {
  static Future<Database> db() async {
    return await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""CREATE TABLE todos(
        id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT,
        isCompeleted INTEGER,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )""");
      },
    );
  }

  static Future<int> createTodo(Map<String, dynamic> newTodo) async {
    final db = await SQLHelper.db();
    try {
      int result = await db.insert('todos', newTodo);
    
      db.close();
      return result;
    } catch (e) {
      print(e.toString());
      db.close();
      return -1;
    }
  }

  static Future<int> updateTodo(
      int id, Map<String, dynamic> updatedTodo) async {
    final db = await SQLHelper.db();
    try {
      int result = await db
          .update('todos', updatedTodo, where: "id = ?", whereArgs: [id]);
      db.close();
      return result;
    } catch (e) {
      print(e.toString());
      db.close();
      return -1;
    }
  }

  static Future<void> deleteTodo(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('todos', where: "id = ?", whereArgs: [id]);
    } catch (e) {
      print(e.toString());
      db.close();
    }
  }

  static Future<List<Map<String, dynamic>>> getTodos() async {
    final db = await SQLHelper.db();
    try {
      List<Map<String, dynamic>> result = await db.query('todos');
      db.close();
      return result;
    } catch (e) {
      print(e.toString());
      db.close();
      return [];
    }
  }

  static Future<Map<String, dynamic>> getTodo(int id) async {
    final db = await SQLHelper.db();
    try {
      List<Map<String, dynamic>> result = await db.query(
        'todos',
        where: "id = ?",
        whereArgs: [id],
        limit: 1,
      );
      db.close();
      return result[0];
    } catch (e) {
      print(e.toString());
      db.close();
      return {};
    }
  }
}
