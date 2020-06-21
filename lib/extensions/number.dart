import 'dart:math';

import 'package:rational/rational.dart';

extension PrecisionDouble on double {
  double toPrecision(int fractionDigits) {
    var mod = pow(10, fractionDigits.toDouble());
    return ((this * mod).round().toDouble() / mod);
  }
}

extension PrecisionRational on Rational {
  String toStringWithPrecision(int decimalPlaces) {
    var regex = RegExp('^-?\\d+(?:\.\\d{0,' + decimalPlaces.toString() + '})?');
    return regex.stringMatch(toDecimalString());
  }
}
