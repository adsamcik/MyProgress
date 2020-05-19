import 'package:rational/rational.dart';

Rational minRational(Rational a, Rational b) => a > b ? b : a;

Rational maxRational(Rational a, Rational b) => a > b ? a : b;

String rationalToJson(Rational rational) => rational.toDecimalString();

Rational rationalFromJson(String value) => Rational.parse(value);
