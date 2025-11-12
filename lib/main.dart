import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pelatihan_sertifikasi/feature/todo/cubit/create_todo_cubit.dart';
import 'package:pelatihan_sertifikasi/feature/todo/cubit/delete_todo_cubit.dart';
import 'package:pelatihan_sertifikasi/feature/todo/cubit/detail_todo_cubit.dart';
import 'package:pelatihan_sertifikasi/feature/todo/cubit/todo_cubit.dart';
import 'package:pelatihan_sertifikasi/feature/todo/cubit/update_todo_cubit.dart';
import 'package:pelatihan_sertifikasi/feature/todo/todo_screen.dart';
import 'package:pelatihan_sertifikasi/feature/user/cubit/user_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit(),
        ),
        BlocProvider(
          create: (context) => TodoCubit(),
        ),
        BlocProvider(
          create: (context) => DetailTodoCubit(),
        ),
        BlocProvider(
          create: (context) => CreateTodoCubit(),
        ),
        BlocProvider(
          create: (context) => DeleteTodoCubit(),
        ),
        BlocProvider(
          create: (context) => UpdateTodoCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: TodoScreen(),
      ),
    );
  }
}
