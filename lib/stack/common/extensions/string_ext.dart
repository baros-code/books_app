extension StringExt on String? {
  bool isNullOrEmpty() => this == null || this!.trim().isEmpty;

  String capitalize() {
    if (this == null || this!.isEmpty) return this ?? '';
    return '${this?[0].toUpperCase()}${this?.substring(1).toLowerCase()}';
  }
}
