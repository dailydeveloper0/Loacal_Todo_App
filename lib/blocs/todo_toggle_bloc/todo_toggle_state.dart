part of 'todo_toggle_bloc.dart';

enum TodoToggleStatus {
  initial,
  changing,
  success,
  error,
}

class TodoToggleState extends Equatable {
  final TodoToggleStatus status;
  final Todo? todo;

  const TodoToggleState({required this.status, this.todo});
  factory TodoToggleState.initial() {
    return const TodoToggleState(status: TodoToggleStatus.initial);
  }

  @override
  List<Object?> get props => [status, todo];

  TodoToggleState copyWith({TodoToggleStatus? status, Todo? todo}) {
    return TodoToggleState(
        status: status ?? this.status, todo: todo ?? this.todo);
  }
}
