import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_card.freezed.dart';

class DataCard extends StatefulWidget {
  final List<CardRow> rows;

  DataCard({
    Key key,
    this.rows,
  }) : super(key: key);

  @override
  _DataCardState createState() => _DataCardState();
}

class _DataCardState extends State<DataCard> {
  List<Widget> _buildIconValueRow(CardRow row) {
    var children = <Widget>[];

    if (row.icon != null) {
      children.add(Icon(row.icon));
      children.add(SizedBox(width: 16));
    }
    children.add(Text(row.title));

    return [
      Expanded(child: Row(children: children)),
      Expanded(child: Text(row.value)),
    ];
  }

  Widget _buildRowWrapper(Iterable<Widget> children, [void Function() onTap]) => InkWell(
      onTap: onTap,
      child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: children.toList(),
          )));

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.rows.map((e) => _buildRowWrapper(_buildIconValueRow(e), e.onTap)).toList(),
    ));
  }
}

@freezed
abstract class CardRow with _$CardRow {
  factory CardRow({
    @required String title,
    @required String value,
    IconData icon,
    void Function() onTap,
  }) = _CardRowImpl;
}
