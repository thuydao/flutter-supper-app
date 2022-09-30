extension ListExtension<T> on List<T>? {
  bool get isNullOrEmpty {
    if (this == null) {
      return true;
    }
    if (this is List) {
      return !this!.isNotEmpty;
    }
    return false;
  }
}
