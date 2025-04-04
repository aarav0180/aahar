
extension ListExtension<T> on List<T> {

  List<T> addOrUpdate(T item, bool Function(T) keySelector,
      {bool searchFromLast = false}) {
    /// find the index of the item to be updated
    final existingItemIndex =
    searchFromLast ? lastIndexWhere(keySelector) : indexWhere(keySelector);

    /// if item is not found, add it to the list and return
    if (existingItemIndex == -1) return this..add(item);

    /// if item exists, remove it and insert an updated item at the same index
    removeAt(existingItemIndex);
    insert(existingItemIndex, item);

    return this;
  }

  List<T> toUnique({bool growable = false}) =>
      toSet().toList(growable: growable);

  Map<K, Set<V>> groupSetsByTo<K, V>(K Function(T element) keyOf, V Function(T element) valueOf) {
    var result = <K, Set<V>>{};
    for (var element in this) {
      (result[keyOf(element)] ??= <V>{}).add(valueOf(element));
    }
    return result;
  }

}


