part of 'todo_list_cubit.dart';

class TodosListState extends Equatable {
  final List<Todo> todos;

  TodosListState({required this.todos});
  factory TodosListState.initial() {
    return TodosListState(todos: []);
  }

  @override
  List<Object> get props => [todos];

  TodosListState copyWith({List<Todo>? todos}) {
    return TodosListState(todos: todos ?? this.todos);
  }
}
