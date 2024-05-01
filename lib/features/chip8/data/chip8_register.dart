import 'dart:typed_data';

class Chip8Register {
  int _i = 0;
  final Uint8List _v = Uint8List(16);
  void setI(int i) {
    _i = i;
  }

  int get I => _i;
  int getVX(int x) => _v[x];
  void setVX(int x, int y) => _v[x] = y;
}
