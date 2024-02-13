extension IterableExt<E> on Iterable<E> {
  Map<T, List<E>> groupBy<T>(T Function(E) key) {
    final map = <T, List<E>>{};
    for (final element in this) {
      (map[key(element)] ??= []).add(element);
    }
    return map;
  }
}
