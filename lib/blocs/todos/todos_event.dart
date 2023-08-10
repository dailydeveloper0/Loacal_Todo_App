part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {}

class CreateTodoEvent extends TodosEvent {
  final Todo todo;

  CreateTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}
class UpdateTodoEvent extends TodosEvent{
   final Todo todo;

  UpdateTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class DeleteTodoEvent extends TodosEvent{
   final int id;

  DeleteTodoEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class LoadTodos extends TodosEvent{
    @override
  List<Object> get props => [];
}
