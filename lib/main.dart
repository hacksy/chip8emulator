import 'package:chip8rommanager/features/chip8/feature/cubits/chip8_cubit.dart';
import 'package:chip8rommanager/features/chip8/feature/presentation/chip8_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<Chip8Cubit>(
          create: (_) => Chip8Cubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Chip8',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Chip8App(),
      ),
    );
  }
}
