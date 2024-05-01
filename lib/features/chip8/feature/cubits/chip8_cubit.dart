import 'dart:async';
import 'dart:typed_data';

import 'package:chip8rommanager/features/chip8/data/chip8_repository.dart';
import 'package:chip8rommanager/features/chip8/data/chip8_vram.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'chip8_state.dart';

class Chip8Cubit extends Cubit<Chip8State> {
  Chip8Cubit() : super(EmptyChip8State());
  Chip8Repository chip8repository = Chip8Repository();
  late Timer? clockTimer;
  void loadRom(Uint8List data) {
    clockTimer = Timer.periodic(
        const Duration(microseconds: 1666700), (_) => _executeTick());

    chip8repository.loadRom(data);
    //cpu.loadFonts();
  }

  void _executeTick() {
    for (int i = 0; i <= 1; i++) {
      _executeOpcode();
    }
    emit(RunningChip8State(screen: chip8repository.vram.data.colors()));
  }

  void _executeOpcode() {
    chip8repository.executeOpcode();
  }
}
