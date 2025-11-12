// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pelatihan_sertifikasi/repository/todo_repository.dart';
import 'package:pelatihan_sertifikasi/model/todo_model.dart';

part 'detail_todo_state.dart';

class DetailTodoCubit extends Cubit<DetailTodoState> {
  DetailTodoCubit() : super(DetailTodoInitial());

  final TodoRepository todoRepository = TodoRepository();

  Future detailTodo({required String id}) async {
    emit(DetailTodoStateLoading());
    try {
      final todo = await todoRepository.detailTodo(id: id);
      emit(DetailTodoStateSuccess(todo: todo));
    } catch (e) {
      emit(DetailTodoStateError(message: e.toString()));
    }
  }
}
