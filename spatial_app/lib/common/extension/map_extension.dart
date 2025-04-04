extension MapExtension<K, V> on Map<K, V> {

  bool any(bool Function(K k, V v) func) {
    for (var ent in entries) {
      final contains = func(ent.key, ent.value);
      if (contains) return true;
    }
    return false;
  }

  Map<K, V> add([Map<K, V>? map]) {
    return {
      ...this,
      if(map != null)...map,
    };
  }

  Map<K, V> copy() {
    return Map.from(this);
  }

  Map<K, V> removeKeys(List<K> keysToRemove) {
    return this.copy()..removeWhere((k, _) => keysToRemove.contains(k));
  }

}
