part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserStateLoading extends UserState {}

final class UserStateSuccess extends UserState {
  final List<UserModel> users;

  UserStateSuccess({required this.users});
}

final class UserStateError extends UserState {
  final String message;

  UserStateError({required this.message});
}
