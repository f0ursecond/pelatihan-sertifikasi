part of 'update_todo_cubit.dart';

@immutable
sealed class UpdateTodoState {}

final class UpdateTodoInitial extends UpdateTodoState {}

final class UpdateTodoStateLoading extends UpdateTodoState {}

final class UpdateTodoStateSuccess extends UpdateTodoState {
  final TodoModel todo;
  UpdateTodoStateSuccess({required this.todo});
}

final class UpdateTodoStateError extends UpdateTodoState {
  final String message;
  UpdateTodoStateError({required this.message});
}