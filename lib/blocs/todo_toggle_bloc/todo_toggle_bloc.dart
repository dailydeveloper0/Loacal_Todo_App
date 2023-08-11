import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo/blocs/todos/todos_bloc.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/repositories/todo_repository.dart';

part 'todo_toggle_event.dart';
part 'todo_toggle_state.dart';

class TodoToggleBloc extends Bloc<TodoToggleEvent, TodoToggleState> {
  final TodoRepository todoRepository;
  TodoToggleBloc({required this.todoRepository})
      : super(TodoToggleState.initial()) {
    on<ChangeStatus>((event, emit) async {
      emit(state.copyWith(status: TodoToggleStatus.changing));
      await todoRepository.updateTodo(event.todo);
      
      emit(state.copyWith(status: TodoToggleStatus.success));
    });
  }
}
