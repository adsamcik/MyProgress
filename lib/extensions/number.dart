import 'dart:math';

extension PrecisionDouble on double {
  double toPrecision(int fractionDigits) {
    var mod = pow(10, fractionDigits.toDouble());
    return ((this * mod).round().toDouble() / mod);
  }
}
