import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/todo_toggle_bloc/todo_toggle_bloc.dart';
import 'package:todo/blocs/todos/todos_bloc.dart';
import 'package:todo/cubits/todo_list_cubit/todo_list_cubit.dart';
import 'package:todo/model/todo.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late List<Todo> todos;
  void _showForm(int? id, BuildContext context) {
    if (id != null) {
      var todo = todos.firstWhere((element) => element.id == id);
      _titleController.text = todo.title;
      _descriptionController.text = todo.description;
    }

    //Show bottom sheet

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return Container(
            padding: EdgeInsets.only(
              top: 15,
              left: 15,
              right: 15,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Title",
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Description",
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<TodosBloc>().add(
                          CreateTodoEvent(
                            todo: Todo(
                              title: _titleController.text,
                              description: _descriptionController.text,
                            ),
                          ),
                        );
                    _titleController.text = '';
                    _descriptionController.text = '';
                    Navigator.of(context).pop();
                  },
                  child: Text(id == null ? "Add" : "Update"),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    todos = context.watch<TodosListCubit>().state.todos;
    return Scaffold(
        appBar: AppBar(
          title: Text("Todo Organizer"),
        ),
        body: BlocConsumer<TodosBloc, TodosState>(
          listener: (context, TodosState state) {
            if (state.status == TodosStatus.loading ||
                state.status == TodosStatus.initial) {
              showDialog(
                  context: context,
                  useRootNavigator: false,
                  builder: (_) {
                    return const Center(child: CircularProgressIndicator());
                  });
            } else {
              Navigator.of(context).pop();
            }
          },
          builder: (context, TodosState state) {
            return Container(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      onDismissed: (DismissDirection direction) {
                        context
                            .read<TodosBloc>()
                            .add(DeleteTodoEvent(id: todos[index].id!));
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(Icons.delete, size: 40),
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(Icons.delete, size: 40),
                      ),
                      key: UniqueKey(),
                      child: Card(
                        elevation: 10,
                        color: Colors.brown,
                        child: ListTile(
                          leading: Checkbox(
                            value: todos[index].isCompeleted,
                            onChanged: (value) {
                              todos[index].isCompeleted = value!;
                              context
                                  .read<TodoToggleBloc>()
                                  .add(ChangeStatus(todo: todos[index]));
                            },
                          ),
                          title: Text(
                            todos[index].title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(todos[index].description),
                        ),
                      ),
                    );
                  }),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showForm(null, context);
          },
          child: const Icon(Icons.add),
        ));
  }
}
