import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/repositories/todo_repository.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoRepository todoRepository;
  TodosBloc({required this.todoRepository}) : super(TodosState.initial()) {
    on<CreateTodoEvent>(_createTodo);
    on<UpdateTodoEvent>(_updateTodo);
    on<DeleteTodoEvent>(_deleteTodo);
    on<LoadTodos>(_loadTodos);
  }

  void _createTodo(CreateTodoEvent event, Emitter<TodosState> emit) async {
    state.copyWith(status: TodosStatus.loading);
    int result = await todoRepository.createTodo(event.todo);
    // add(LoadTodos());
    state.copyWith(status: TodosStatus.success);
  }

  void _updateTodo(UpdateTodoEvent event, Emitter<TodosState> emit) async {
    state.copyWith(status: TodosStatus.loading);
    int result = await todoRepository.updateTodo(event.todo);
    // add(LoadTodos());
    state.copyWith(status: TodosStatus.success);
  }

  void _deleteTodo(DeleteTodoEvent event, Emitter<TodosState> emit) async {
    state.copyWith(status: TodosStatus.loading);
    todoRepository.deleteTodo(event.id);
    // add(LoadTodos());
    state.copyWith(status: TodosStatus.success);
  }

  void _loadTodos(LoadTodos event, Emitter<TodosState> emit) async {
    state.copyWith(status: TodosStatus.loading);
    List<Map<String, dynamic>> result = await todoRepository.getTodos();
    // add(LoadTodos());
    List<Todo> newTodos = result.map((e) => Todo.fromMap(e)).toList();
    state.copyWith(status: TodosStatus.success, todos: newTodos);
  }
}
