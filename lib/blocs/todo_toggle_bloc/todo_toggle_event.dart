part of 'todo_toggle_bloc.dart';

abstract class TodoToggleEvent extends Equatable {}

class ChangeStatus extends TodoToggleEvent {
  final Todo todo;

  ChangeStatus({required this.todo});

  @override
  List<Object> get props => [todo];
}
