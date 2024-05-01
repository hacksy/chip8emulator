import 'dart:io';

import 'package:chip8rommanager/features/chip8/presentation/screen/chip8_keyboard.dart';
import 'package:chip8rommanager/features/chip8/presentation/screen/chip8_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class Chip8App extends StatelessWidget {
  const Chip8App({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Chip8Screen(),
          const Chip8Keyboard(),
          ElevatedButton(
            onPressed: _loadRom,
            child: const Text('Load Rom'),
          ),
        ],
      ),
    );
  }

  void _loadRom() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      final data = file.readAsBytesSync();
    }
  }
}
