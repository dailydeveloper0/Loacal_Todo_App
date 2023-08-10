part of 'todos_bloc.dart';

enum TodosStatus { initial, loading, success, error }

class TodosState extends Equatable {
  final TodosStatus status;
  final List<Todo>? todos;

  const TodosState({required this.status, this.todos});
  factory TodosState.initial() {
    return const TodosState(status: TodosStatus.initial);
  }

  @override
  List<Object> get props => [status, todos!];

  TodosState copyWith({TodosStatus? status, List<Todo>? todos}) {
    return TodosState(
        status: status ?? this.status, todos: todos ?? this.todos);
  }
}
