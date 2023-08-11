import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/repositories/todo_repository.dart';

part 'todo_list_state.dart';

class TodosListCubit extends Cubit<TodosListState> {
  final TodoRepository todoRepository;

  late StreamSubscription _todoRepoStreamSubscription;
  TodosListCubit({required this.todoRepository})
      : super(TodosListState.initial()) {
    _todoRepoStreamSubscription =
        todoRepository.stream.listen((List<Map<String, dynamic>> data) {
      final newTodos = data.map((e) => Todo.fromMap(e)).toList();

      emit(state.copyWith(todos: newTodos));
    });
  }
}
