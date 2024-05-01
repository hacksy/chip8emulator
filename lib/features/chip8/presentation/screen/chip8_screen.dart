import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Chip8Screen extends StatelessWidget {
  const Chip8Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Image(
      width: 64,
      height: 32,
      fit: BoxFit.contain,
      image: Chip8ScreenProvider(
        width: 64,
        height: 32,
      ),
    );
  }
}

class Chip8ScreenProvider extends ImageProvider<Chip8ScreenProvider> {
  Chip8ScreenProvider({
    required this.height,
    required this.width,
  });
  final int height;
  final int width;
  @override
  Future<Chip8ScreenProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<Chip8ScreenProvider>(this);
  }

  @override
  ImageStreamCompleter loadImage(
      Chip8ScreenProvider key, ImageDecoderCallback decode) {
    return Chip8ImageStreamCompleter(
      height: height,
      width: width,
    );
  }
}

class Chip8ImageStreamCompleter extends ImageStreamCompleter {
  Chip8ImageStreamCompleter({
    required this.height,
    required this.width,
  });

  final int height;
  final int width;

  void updateImage(List<int> pixels) async {
    final buffer =
        await ui.ImmutableBuffer.fromUint8List(Uint8List.fromList(pixels));
    final id = await ui.ImageDescriptor.raw(
      buffer,
      width: width,
      height: height,
      pixelFormat: ui.PixelFormat.rgba8888,
    ).instantiateCodec();
    final frame = await id.getNextFrame();

    final imageInfo = ImageInfo(
      image: frame.image,
    );
    setImage(imageInfo);
  }
}
