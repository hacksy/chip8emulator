class Chip8VRAM {
  final List<int> data = List<int>.filled(0, 0x0, growable: true);
  final int width = 64;
  final int height = 32;

  Chip8VRAM() {
    reset();
  }

  reset() {
    data.clear();
    data.addAll(List.generate(width * height, (index) => 0x0));
  }

  void setPixel(int x, int y, int value) {
    if ([0x0, 0x1].contains(value)) {
      data[y * height + x] = value;
    } else {
      throw (Exception('Invalid value'));
    }
  }

  int getPixel(int x, int y) {
    return data.elementAt(y * height + x);
  }
}

const backgroundColor = [0xff, 0xff, 0xff, 0xff];
const foregroundColor = [0, 0, 0, 0xff];

extension Colors on List<int> {
  List<int> colors() {
    List<int> colors = List<int>.empty(growable: true);
    forEach((element) {
      colors.addAll(element == 0 ? backgroundColor : foregroundColor);
    });
    return colors;
  }
}
