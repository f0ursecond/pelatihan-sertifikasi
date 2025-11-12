// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pelatihan_sertifikasi/feature/user/repository/todo_repository.dart';
import 'package:pelatihan_sertifikasi/model/todo_model.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final TodoRepository todoRepository;

  TodoCubit({TodoRepository? todoRepository})
      : todoRepository = todoRepository ?? TodoRepository(),
        super(TodoInitial());

  Future getTodo() async {
    emit(TodoStateLoading());
    try {
      final todos = await todoRepository.getTodo();
      emit(TodoStateSuccess(todos: todos));
    } catch (e) {
      emit(TodoStateError(message: e.toString()));
    }
  }
}
