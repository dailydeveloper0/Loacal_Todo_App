import 'dart:async';

import 'package:todo/helpers/sql_helper.dart';

import '../model/todo.dart';

class TodoRepository {
  TodoRepository() {
    getTodos();
  }
  final StreamController<List<Map<String, dynamic>>> _controller =
      StreamController<List<Map<String, dynamic>>>();

  Stream<List<Map<String, dynamic>>> get stream => _controller.stream;

  Future<int> createTodo(Todo todo) async {
    final result = await SQLHelper.createTodo(todo.toMap());
    getTodos();
    return result;
  }

  Future<int> updateTodo(Todo todo) async {
    final result = await SQLHelper.updateTodo(todo.id!, todo.toMap());
    getTodos();
    return result;
  }

  Future<void> deleteTodo(int id)async {
    await SQLHelper.deleteTodo(id);
    getTodos();
  }

  void getTodos() async {
    final todos = await SQLHelper.getTodos();
    _controller.sink.add(todos);
  }

  Future<Map<String, dynamic>> getTodo(int id) async {
    return await SQLHelper.getTodo(id);
  }
}
