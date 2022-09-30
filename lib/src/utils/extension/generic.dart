extension NullCheck<T> on T? {
  bool get isNullOrEmpty {
    if (this == null) {
      return true;
    }
    if (this is String) {
      if (this == "") {
        return true;
      }
    }

    return false;
  }
}
