import 'dart:math';

class ConversionUtils {
  static String getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return '0 Bytes';
    const suffixes = [' Bytes', ' KB', ' MB', ' GB', ' TB'];
    final i = (log(bytes) / log(1000)).floor();
    return ((bytes / pow(1000, i)).toStringAsFixed(decimals)) + suffixes[i];
  }
}
