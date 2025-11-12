import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pelatihan_sertifikasi/feature/todo/add_edit_todo_screen.dart';
import 'package:pelatihan_sertifikasi/feature/todo/cubit/delete_todo_cubit.dart';
import 'package:pelatihan_sertifikasi/feature/todo/cubit/todo_cubit.dart';
import 'package:pelatihan_sertifikasi/feature/todo/detail_todo_screen.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  late TodoCubit _todoCubit;
  late DeleteTodoCubit _deleteTodoCubit;

  @override
  void initState() {
    _todoCubit = context.read<TodoCubit>();
    _todoCubit.getTodo();

    _deleteTodoCubit = context.read<DeleteTodoCubit>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildMainView();
  }

  Widget _buildMainView() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo List",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditTodoScreen()));
              },
              icon: Icon(Icons.add),
            ),
          )
        ],
      ),
      body: BlocListener<DeleteTodoCubit, DeleteTodoState>(
        listener: (context, state) {
          if (state is DeleteTodoStateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Todo berhasil dihapus')),
            );
            _todoCubit.getTodo();
          } else if (state is DeleteTodoStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal: ${state.message}')),
            );
          } else if (state is DeleteTodoStateLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Loading...')),
            );
          }
        },
        child: BlocBuilder<TodoCubit, TodoState>(
          builder: (context, state) {
            if (state is TodoStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TodoStateSuccess) {
              return RefreshIndicator(
                onRefresh: () async {
                  _todoCubit.getTodo();
                },
                child: ListView.separated(
                  itemCount: state.todos.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider();
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final todo = state.todos[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailTodoScreen(
                              id: todo.id ?? '',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(todo.title ?? ''),
                                SizedBox(height: 8),
                                Text(todo.description ?? ''),
                              ],
                            ),
                            Row(
                              children: [
                                // Container(
                                //   padding: EdgeInsets.all(8),
                                //   decoration: BoxDecoration(
                                //     shape: BoxShape.circle,
                                //     color: todo.isDone ?? false ? Colors.lightGreenAccent : Colors.redAccent,
                                //   ),
                                //   child: Icon(todo.isDone ?? false ? Icons.check : Icons.close),
                                // ),
                                Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 12),
                                IconButton(
                                  onPressed: () {
                                    _deleteTodoCubit.deleteTodo(id: todo.id ?? '');
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is TodoStateError) {
              return RefreshIndicator(
                onRefresh: () async {
                  _todoCubit.getTodo();
                },
                child: Center(
                  child: Text(state.message),
                ),
              );
            } else {
              return SizedBox.shrink();
            }
            // return ListView.separated(
            //   itemCount: 5,
            //   separatorBuilder: (BuildContext context, int index) {
            //     return Divider();
            //   },
            //   itemBuilder: (BuildContext context, int index) {
            //     return Padding(
            //       padding: const EdgeInsets.all(12),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text('Title'),
            //               SizedBox(height: 8),
            //               Text('Description'),
            //             ],
            //           ),
            //           Row(
            //             children: [
            //               Container(
            //                 padding: EdgeInsets.all(8),
            //                 decoration: BoxDecoration(
            //                   shape: BoxShape.circle,
            //                   color: Colors.lightGreenAccent,
            //                 ),
            //                 child: Icon(Icons.check),
            //               ),
            //               SizedBox(width: 12),
            //               Icon(Icons.more_vert)
            //             ],
            //           )
            //         ],
            //       ),
            //     );
            //   },
            // );
          },
        ),
      ),
    );
  }
}
