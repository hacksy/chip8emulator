import 'dart:async';
import 'dart:ui' as ui;

import 'package:chip8rommanager/features/chip8/feature/cubits/chip8_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chip8Screen extends StatelessWidget {
  Chip8Screen({super.key});
  final chunkImages = StreamController<List<int>>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<Chip8Cubit, Chip8State>(
      listener: (context, state) {
        if (state is RunningChip8State) {
          print('=xxxx');
          chunkImages.add(state.screen);
        }
      },
      child: Container(
        color: Colors.red,
        child: Image(
          width: 64 * 5,
          height: 32 * 5,
          fit: BoxFit.contain,
          image: Chip8ScreenProvider(
            width: 64,
            height: 32,
            chunkImages: chunkImages.stream,
          ),
        ),
      ),
    );
  }
}

class Chip8ScreenProvider extends ImageProvider<Chip8ScreenProvider> {
  Chip8ScreenProvider({
    required this.height,
    required this.width,
    this.chunkImages,
  });

  final Stream<List<int>>? chunkImages;
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
      chunkImages: chunkImages,
    );
  }
}

class Chip8ImageStreamCompleter extends ImageStreamCompleter {
  Chip8ImageStreamCompleter({
    required this.height,
    required this.width,
    Stream<List<int>>? chunkImages,
  }) {
    if (chunkImages != null) {
      chunkImages.listen((event) {
        updateImage(event);
      });
    }
  }

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
