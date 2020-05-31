import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  Future<R> navigate<R>(WidgetBuilder builder) async => await Navigator.push<R>(
        this,
        MaterialPageRoute<R>(builder: builder),
      );
}
