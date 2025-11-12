// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pelatihan_sertifikasi/model/todo_model.dart';
import 'package:pelatihan_sertifikasi/repository/todo_repository.dart';

part 'update_todo_state.dart';

class UpdateTodoCubit extends Cubit<UpdateTodoState> {
  UpdateTodoCubit() : super(UpdateTodoInitial());

  final todoRepository = TodoRepository();

  Future<void> updateTodo(String id, TodoModel todo) async {
    emit(UpdateTodoStateLoading());
    try {
      final updatedTodo = await todoRepository.updateTodo(id, todo);
      emit(UpdateTodoStateSuccess(todo: updatedTodo));
    } catch (e) {
      emit(UpdateTodoStateError(message: e.toString()));
    }
  }
}
