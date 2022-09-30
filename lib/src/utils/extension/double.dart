import 'package:intl/intl.dart';

import 'generic.dart';

extension DoubleUtils on double? {
  double get orZero {
    if (isNullOrEmpty) {
      return 0;
    }
    return this!;
  }

  String? get comasFixZero {
    if (isNullOrEmpty) {
      return null;
    }
    final format = NumberFormat("###,###", "en_US");
    return format.format(this!);
  }

  String? get comasFixOne {
    if (isNullOrEmpty) {
      return null;
    }
    final format = NumberFormat("###,###.#", "en_US");
    return format.format(this!);
  }

  String? get comasFixTwo {
    if (isNullOrEmpty) {
      return null;
    }
    final format = NumberFormat("###,###.##", "en_US");
    return format.format(this!);
  }
}
