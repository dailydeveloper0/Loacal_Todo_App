import 'package:todo/helpers/sql_helper.dart';

import '../model/todo.dart';

class TodoRepository {
  Future<int> createTodo(Todo todo) async {
    return await SQLHelper.createTodo(todo.toMap());
  }

  Future<int> updateTodo(Todo todo) async {
    return await SQLHelper.updateTodo(todo.id!, todo.toMap());
  }

  void deleteTodo(int id) {
    SQLHelper.deleteTodo(id);
  }

  Future<List<Map<String, dynamic>>> getTodos() async {
    return await SQLHelper.getTodos();
  }

  Future<Map<String, dynamic>> getTodo(int id) async {
    return await SQLHelper.getTodo(id);
  }
}
