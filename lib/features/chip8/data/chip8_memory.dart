import 'dart:typed_data';

class Chip8Memory {
  ByteData _memory = ByteData(4096);

  void loadRom(Uint8List romData) {
    _memory = ByteData(4096);
    for (var i = 0; i < romData.length; i++) {
      setMemoryAt(0x200 + i, romData[i]);
    }
  }

  // Helpers
  void setMemoryAt(int offset, int data) {
    _memory.setUint8(offset, data);
  }

  int getOpcodeAt(int programCounter) {
    final opcode = _memory.getUint16(programCounter);
    return opcode;
  }

  int getMemoryAt(int position) => _memory.getUint8(position);
}
