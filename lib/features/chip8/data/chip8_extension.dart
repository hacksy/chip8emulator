extension OpcodeExtensions on int {
  int get nnn => this & 0x0FFF; // ?NNN
  int get nn => this & 0x00FF; // ??NN
  int get n => this & 0x000F; // ???N
  int get x => (this & 0x0F00) >> 8; // ?X??
  int get y => (this & 0x00F0) >> 4; // ??Y?
  int get a => this >> 12; // a???

  String get hex => toRadixString(16);
}
