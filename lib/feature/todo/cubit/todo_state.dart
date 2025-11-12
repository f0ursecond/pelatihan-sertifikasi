part of 'todo_cubit.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoStateLoading extends TodoState {}

final class TodoStateSuccess extends TodoState {
  final List<TodoModel> todos;
  TodoStateSuccess({required this.todos});
}

final class TodoStateError extends TodoState {
  final String message;
  TodoStateError({required this.message});
}
