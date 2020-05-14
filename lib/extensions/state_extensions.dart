import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension StateExtensions<T extends StatefulWidget> on State<T> {
  Future<R> navigate<R>(WidgetBuilder builder) async => await Navigator.push<R>(
        context,
        MaterialPageRoute<R>(builder: builder),
      );
}
