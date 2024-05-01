part of 'chip8_cubit.dart';

abstract class Chip8State extends Equatable {
  @override
  List<Object?> get props => [];
}

class EmptyChip8State extends Chip8State {}

class RunningChip8State extends Chip8State {
  final List<int> screen;
  RunningChip8State({
    required this.screen,
  });

  @override
  List<Object?> get props => [screen];
}
