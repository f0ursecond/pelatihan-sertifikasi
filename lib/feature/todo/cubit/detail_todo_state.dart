part of 'detail_todo_cubit.dart';

@immutable
sealed class DetailTodoState {}

final class DetailTodoInitial extends DetailTodoState {}

final class DetailTodoStateLoading extends DetailTodoState {}

final class DetailTodoStateSuccess extends DetailTodoState {
  final TodoModel todo;
  DetailTodoStateSuccess({required this.todo});
}

final class DetailTodoStateError extends DetailTodoState {
  final String message;
  DetailTodoStateError({required this.message});
}
