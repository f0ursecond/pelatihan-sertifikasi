import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pelatihan_sertifikasi/feature/user/repository/user_repository.dart';
import 'package:pelatihan_sertifikasi/model/user_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  UserRepository userRepository = UserRepository();

  Future<void> getUsers() async {
    emit(UserStateLoading());
    try {
      List<UserModel> users = await userRepository.getUsers();
      print(users);
      emit(UserStateSuccess(users: users));
    } catch (e) {
      emit(UserStateError(message: e.toString()));
    }
  }
}
