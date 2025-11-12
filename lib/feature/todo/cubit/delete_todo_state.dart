part of 'delete_todo_cubit.dart';

@immutable
sealed class DeleteTodoState {}

final class DeleteTodoInitial extends DeleteTodoState {}

final class DeleteTodoStateLoading extends DeleteTodoState {}

final class DeleteTodoStateSuccess extends DeleteTodoState {}

final class DeleteTodoStateError extends DeleteTodoState {
  final String message;
  DeleteTodoStateError({required this.message});
}
