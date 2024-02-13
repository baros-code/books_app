import 'dart:io';

extension FileExt on File {
  double getFileSizeInKb() {
    final bytes = lengthSync();
    return bytes.toDouble() / 1000;
  }
}
