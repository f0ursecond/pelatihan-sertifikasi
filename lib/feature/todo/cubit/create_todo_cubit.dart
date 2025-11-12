// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pelatihan_sertifikasi/feature/user/repository/todo_repository.dart';
import 'package:pelatihan_sertifikasi/model/todo_model.dart';

part 'create_todo_state.dart';

class CreateTodoCubit extends Cubit<CreateTodoState> {
  CreateTodoCubit() : super(CreateTodoInitial());

  final TodoRepository todoRepository = TodoRepository();

  Future<void> createTodo(TodoModel todo) async {
    emit(CreateTodoStateLoading());
    try {
      final createdTodo = await todoRepository.createTodo(todo);
      emit(CreateTodoStateSuccess(todo: createdTodo));
    } catch (e) {
      emit(CreateTodoStateError(message: e.toString()));
    }
  }
}
