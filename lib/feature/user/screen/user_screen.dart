import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pelatihan_sertifikasi/feature/user/cubit/user_cubit.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserCubit userCubit = UserCubit();

  @override
  void initState() {
    super.initState();
    userCubit.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        bloc: userCubit,
        builder: (context, state) {
          print(state);
          if (state is UserStateSuccess) {
            if (state.users.isEmpty) {
              return const Center(child: Text('No users found'));
            } else {
              return ListView.builder(
                itemCount: state.users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(state.users[index].name ?? ''),
                    subtitle: Text(state.users[index].address ?? ''),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(state.users[index].avatar ?? ''),
                    ),
                  );
                },
              );
            }
          } else if (state is UserStateError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
