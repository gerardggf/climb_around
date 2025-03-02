import 'package:flutter/widgets.dart';

/// Maybe it's not the best option since it makes the [SizedBox] no longer constant...
extension IntToSizedBoxExtension on int {
  SizedBox get h => SizedBox(
        height: toDouble(),
      );
  SizedBox get w => SizedBox(
        width: toDouble(),
      );
}

/// Maybe it's not the best option since it makes the [SizedBox] no longer constant...
extension DoubleToSizedBox on double {
  SizedBox get h => SizedBox(
        height: this,
      );
  SizedBox get w => SizedBox(width: this);
}
