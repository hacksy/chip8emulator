import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Chip8Screen extends StatelessWidget {
  const Chip8Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Image(
      width: 64 * 10,
      height: 32 * 10,
      fit: BoxFit.contain,
      image: Chip8ScreenProvider(),
    );
  }
}

class Chip8ScreenProvider extends ImageProvider<Chip8ScreenProvider> {
  @override
  Future<Chip8ScreenProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<Chip8ScreenProvider>(this);
  }
}
