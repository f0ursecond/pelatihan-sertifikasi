import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pelatihan_sertifikasi/feature/todo/cubit/create_todo_cubit.dart';
import 'package:pelatihan_sertifikasi/model/todo_model.dart';

class AddEditTodoScreen extends StatefulWidget {
  const AddEditTodoScreen({super.key});

  @override
  State<AddEditTodoScreen> createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool _isCompleted = false;
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_validateForm);
    _descriptionController.addListener(_validateForm);
  }

  void _validateForm() {
    final isValid = _titleController.text.trim().isNotEmpty && _descriptionController.text.trim().isNotEmpty;

    if (isValid != _isFormValid) {
      setState(() => _isFormValid = isValid);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTodoCubit, CreateTodoState>(
      listener: (context, state) {
        if (state is CreateTodoStateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Todo berhasil disimpan')),
          );
          Navigator.pop(context, true);
        } else if (state is CreateTodoStateError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is CreateTodoStateLoading;
        final isButtonEnabled = _isFormValid && !isLoading;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Tambah Todo",
              style: TextStyle(fontWeight: FontWeight.w800, color: Colors.black),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField("Judul", _titleController, hint: "Masukkan judul todo"),
                const SizedBox(height: 16),
                _buildTextField("Deskripsi", _descriptionController, hint: "Masukkan deskripsi todo", maxLines: 4),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _isCompleted,
                      onChanged: (v) => setState(() => _isCompleted = v ?? false),
                    ),
                    const Text("Sudah selesai", style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isButtonEnabled ? Colors.blue : Colors.grey.shade400, // 🔵 abu-abu jika disable
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: isButtonEnabled
                        ? () {
                            final todo = TodoModel(
                              title: _titleController.text.trim(),
                              description: _descriptionController.text.trim(),
                              isDone: _isCompleted,
                            );
                            context.read<CreateTodoCubit>().createTodo(todo);
                          }
                        : null,
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                            "Simpan",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {String? hint, int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
        ),
      ],
    );
  }
}
