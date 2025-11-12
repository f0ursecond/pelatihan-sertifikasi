// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pelatihan_sertifikasi/feature/user/repository/todo_repository.dart';

part 'delete_todo_state.dart';

class DeleteTodoCubit extends Cubit<DeleteTodoState> {
  DeleteTodoCubit() : super(DeleteTodoInitial());

  final todoRepository = TodoRepository();

  Future<void> deleteTodo({required String id}) async {
    emit(DeleteTodoStateLoading());
    try {
      await todoRepository.deleteTodo(id);
      emit(DeleteTodoStateSuccess());
    } catch (e) {
      emit(DeleteTodoStateError(message: e.toString()));
    }
  }
}
