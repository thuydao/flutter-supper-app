import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'generic.dart';

extension Convert on String? {
  String get nullSafe {
    if (this == null) {
      return "";
    }
    return this!;
  }

  int? get toInt {
    if (this == null) {
      return null;
    }
    return int.tryParse(this!);
  }

  double? get toDouble {
    if (this == null) {
      return null;
    }
    return double.tryParse(this!);
  }
}

extension Line on String? {
  int get lineLength => '\n'.allMatches(this ?? '').length + 1;
}

extension HexColor on String {
  Color get color => Color(int.parse('0xff$this'));
}

extension StringUtils on String? {
  String append(String add) {
    if (isNullOrEmpty) {
      return '';
    } else {
      return this! + add;
    }
  }

  String? get removeAllWhiteSpace {
    if (!isNullOrEmpty) {
      return this!.replaceAll(' ', '');
    }
    return null;
  }

  String get orEmpty {
    if (!isNullOrEmpty) {
      return this!;
    }
    return '';
  }

  bool equalsIgnoreCase(String? other) =>
      (this == null && other == null) ||
      (this != null &&
          other != null &&
          this!.toLowerCase() == other.toLowerCase());

  String? get comasFixZero {
    if (isNullOrEmpty) {
      return null;
    }
    final format = NumberFormat("###,###", "en_US");
    return format.format(double.parse(this!));
  }

  String? get comasFixOne {
    if (isNullOrEmpty) {
      return null;
    }
    final format = NumberFormat("###,###.#", "en_US");
    return format.format(this!.toDouble);
  }

  String? get comasFixTwo {
    if (isNullOrEmpty) {
      return null;
    }
    final format = NumberFormat("###,###.##", "en_US");
    return format.format(this!.toDouble);
  }
}

extension URLParse on String? {
  Map<String, String> get queries {
    if (isNullOrEmpty) {
      return {};
    }
    return Uri.parse(this!).queryParameters;
  }

  String? queryWithName(String name) {
    if (isNullOrEmpty) {
      return null;
    }
    return queries[name];
  }

  String? pathWithName(String name) {
    if (isNullOrEmpty) {
      return null;
    }
    final RegExp regExp =
        new RegExp(r"(?<=" + name + "\\/)(.*?)((?=\\/)|(?=\\?)|(?=\$|\\s))");
    return regExp.firstMatch(this!)?.group(0);
  }

  // String? valueOfQuery(String query) {
  //   if (isNullOrEmpty) {
  //     return null;
  //   }
  //   final RegExp regExp = new RegExp(r"((?<=\?" +
  //       query +
  //       "=)|(?<=\\&" +
  //       query +
  //       "=))(.*?)((?=\\&)|(?=\$|\\s))");
  //   return regExp.firstMatch(this!)?.group(0);
  // }
}
