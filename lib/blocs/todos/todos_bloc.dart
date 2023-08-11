import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/repositories/todo_repository.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoRepository todoRepository;
  // late StreamSubscription _todoStreamSubscription;
  TodosBloc({required this.todoRepository}) : super(TodosState.initial()) {
    // _todoStreamSubscription =
    //     todoRepository.stream.listen((List<Map<String, dynamic>> data){
    //       //Continue from here

    //     });
    on<CreateTodoEvent>(_createTodo);
    on<UpdateTodoEvent>(_updateTodo);
    on<DeleteTodoEvent>(_deleteTodo);
    // on<LoadTodos>(_loadTodos);
    // add(LoadTodos());
  }

  void _createTodo(CreateTodoEvent event, Emitter<TodosState> emit) async {
    emit(state.copyWith(status: TodosStatus.loading));
    await Future.delayed(Duration(seconds: 3));
    int result = await todoRepository.createTodo(event.todo);
    // add(LoadTodos());
    emit(state.copyWith(status: TodosStatus.success));
  }

  void _updateTodo(UpdateTodoEvent event, Emitter<TodosState> emit) async {
    emit(state.copyWith(status: TodosStatus.loading));
    int result = await todoRepository.updateTodo(event.todo);
    // add(LoadTodos());
    emit(state.copyWith(status: TodosStatus.success));
  }

  void _deleteTodo(DeleteTodoEvent event, Emitter<TodosState> emit) async {
    emit(state.copyWith(status: TodosStatus.loading));
    await todoRepository.deleteTodo(event.id);
    // add(LoadTodos());
    emit(state.copyWith(status: TodosStatus.success));
  }

  // void _loadTodos(LoadTodos event, Emitter<TodosState> emit) async {
  //   emit(state.copyWith(status: TodosStatus.loading));
  //   todoRepository.getTodos();

  //   List<Todo> newTodos = result.map((e) => Todo.fromMap(e)).toList();

  //   emit(state.copyWith(status: TodosStatus.success, todos: newTodos));
  //   ;
  // }
}
