part of 'create_todo_cubit.dart';

@immutable
sealed class CreateTodoState {}

final class CreateTodoInitial extends CreateTodoState {}

final class CreateTodoStateLoading extends CreateTodoState {}

final class CreateTodoStateSuccess extends CreateTodoState {
  final TodoModel todo;
  CreateTodoStateSuccess({required this.todo});
}

final class CreateTodoStateError extends CreateTodoState {
  final String message;
  CreateTodoStateError({required this.message});
}

