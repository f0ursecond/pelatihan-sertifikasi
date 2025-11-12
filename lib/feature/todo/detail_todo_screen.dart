import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pelatihan_sertifikasi/feature/todo/cubit/detail_todo_cubit.dart';

class DetailTodoScreen extends StatefulWidget {
  final String id;
  const DetailTodoScreen({super.key, required this.id});

  @override
  State<DetailTodoScreen> createState() => _DetailTodoScreenState();
}

class _DetailTodoScreenState extends State<DetailTodoScreen> {
  late DetailTodoCubit _detailTodoCubit;

  @override
  void initState() {
    super.initState();
    _detailTodoCubit = context.read<DetailTodoCubit>();
    _detailTodoCubit.detailTodo(id: widget.id); // 🔥 Panggil di sini, bukan di build
  }

  @override
  Widget build(BuildContext context) {
    return _buildMainView();
  }

  Widget _buildMainView() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Todo List",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<DetailTodoCubit, DetailTodoState>(
        builder: (context, state) {
          if (state is DetailTodoStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DetailTodoStateSuccess) {
            final todo = state.todo;
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todo.title ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  Text(todo.description ?? ''),
                ],
              ),
            );
          } else if (state is DetailTodoStateError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: Text('Error: ${state.message}')),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
