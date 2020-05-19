import 'package:rational/rational.dart';

Rational minRational(Rational a, Rational b) => a > b ? b : a;

Rational maxRational(Rational a, Rational b) => a > b ? a : b;

String rationalToJson(Rational rational) => rational.toDecimalString();

Rational rationalFromJson(dynamic value) => Rational.parse(value.toString());
