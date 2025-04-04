
extension ToImmutableListExtension<T> on Iterable<T> {
  List<T> toImmutableList() => toList(growable: false);

  Iterable<T> multiply(int count){
    return Iterable.generate(count, (index) => this).expand((e) => e);
  }

}


