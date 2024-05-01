import 'dart:typed_data';

import 'package:chip8rommanager/features/chip8/data/chip8_extension.dart';
import 'package:chip8rommanager/features/chip8/data/chip8_memory.dart';
import 'package:chip8rommanager/features/chip8/data/chip8_register.dart';
import 'package:chip8rommanager/features/chip8/data/chip8_vram.dart';

class Chip8Repository {
  Chip8Repository();
  Chip8Memory memory = Chip8Memory();
  Chip8Register register = Chip8Register();
  Chip8VRAM vram = Chip8VRAM();
  static const initialAddress = 0x200;

  int _currentaddress = initialAddress;

  void loadRom(Uint8List romData) {
    memory.loadRom(romData);
  }

  void executeOpcode() {
    final opcode = memory.getOpcodeAt(_currentaddress);
    _increment();
    _parseOpcodes(opcode);
  }

  void _parseOpcodes(int opcode) {
    switch (opcode) {
      case 0x00e0:
        vram.reset();
        break;
    }

    if (opcode.a == 0x01) {
      _currentaddress = opcode.nnn;
      return;
    }
    if (opcode.a == 0x06) {
      register.setVX(opcode.x, opcode.nn);
      return;
    }
    if (opcode.a == 0x07) {
      register.setVX(opcode.x, register.getVX(opcode.x) + opcode.nn);
      return;
    }
    if (opcode.a == 0x0A) {
      register.setI(opcode.nnn);
      return;
    }
    if (opcode.a == 0x0d) {
      const width = 8;
      final x = opcode.x;
      final y = opcode.y;
      final n = opcode.n;
      final i = register.I;
      final vx = register.getVX(x) % vram.width;
      final vy = register.getVX(y) % vram.height;
      register.setVX(0xF, 0);
      for (var z = 0; z < n; z++) {
        final sprite = memory.getMemoryAt(i + z);
        final paintY = (vy + z) % vram.height;
        var bitmask = 0x80;

        for (var m = 0; m < width; m++) {
          final paintX = (vx + m) % vram.width;
          bool currentPixel = vram.getPixel(paintX, paintY) == 1;
          bool shouldDraw = sprite & bitmask > 0;
          if (shouldDraw && currentPixel) {
            register.setVX(0xF, 1);
            shouldDraw = false;
          } else if (!shouldDraw && currentPixel) {
            shouldDraw = true;
          }
          vram.setPixel(paintX, paintY, shouldDraw ? 1 : 0);
          bitmask = bitmask >> 1;
        }
      }
      return;
    }
  }

  void _increment() {
    _currentaddress = _currentaddress + 2;
    if (_currentaddress >= 4096) {
      _currentaddress = 0x200;
    }
  }

  void decrement() {
    _currentaddress = _currentaddress - 2;
    if (_currentaddress < 0) {
      _currentaddress = 0;
    }
  }
}
