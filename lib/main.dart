import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/todo_toggle_bloc/todo_toggle_bloc.dart';
import 'package:todo/blocs/todos/todos_bloc.dart';
import 'package:todo/cubits/todo_list_cubit/todo_list_cubit.dart';
import 'package:todo/pages/home_page/home_page.dart';
import 'package:todo/repositories/todo_repository.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => TodoRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TodosBloc(
              todoRepository: context.read<TodoRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => TodoToggleBloc(
              todoRepository: context.read<TodoRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => TodosListCubit(
              todoRepository: context.read<TodoRepository>(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Todo Organizer",
          theme: ThemeData(
            primarySwatch: Colors.brown,
          ),
          home: HomePage(),
        ),
      ),
    );
  }
}
