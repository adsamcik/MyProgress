import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:markmyprogress/misc/get.dart';

class LinearLabelProgressIndicator extends ProgressIndicator {
  final double minHeight;
  final String textValue;

  /// Creates a linear progress indicator.
  ///
  /// {@macro flutter.material.progressIndicator.parameters}
  const LinearLabelProgressIndicator({
    Key key,
    double value,
    this.textValue,
    Color backgroundColor,
    Animation<Color> valueColor,
    this.minHeight,
    String semanticsLabel,
    String semanticsValue,
  })  : assert(minHeight == null || minHeight > 0),
        super(
          key: key,
          value: value,
          backgroundColor: backgroundColor,
          valueColor: valueColor,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        );

  @override
  State<StatefulWidget> createState() => _LinearLabelProgressIndicatorState();
}

class _LinearLabelProgressIndicatorState extends State<LinearLabelProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    var theme = Get.theme(context);
    var progressBarBackgroundColor = HSLColor.fromColor(theme.colorScheme.background);
    var sign = (0.5 - progressBarBackgroundColor.lightness);
    const lightnessStepValue = 0.1;
    var lightnessStep = sign >= 0 ? lightnessStepValue : -lightnessStepValue;
    var lightness = max(min(progressBarBackgroundColor.lightness, 1.0 - lightnessStepValue), lightnessStepValue);
    progressBarBackgroundColor = progressBarBackgroundColor.withLightness(lightness - lightnessStep);

    var progressBarForegroundColor = progressBarBackgroundColor.withLightness(lightness + lightnessStep).toColor();

    return Stack(
      children: <Widget>[
        SizedBox(
          height: 30,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(4.0),
              child: LinearProgressIndicator(
                value: widget.value,
                semanticsValue: widget.semanticsValue,
                semanticsLabel: widget.semanticsLabel,
                backgroundColor: progressBarBackgroundColor.toColor(),
                valueColor: AlwaysStoppedAnimation<Color>(progressBarForegroundColor),
              )),
        ),
        Positioned.fill(
          child: LayoutBuilder(
            builder: (context, constraints) {
              var textStyle = Get.theme(context).textTheme.subtitle1.copyWith(fontWeight: FontWeight.bold);

              var renderParagraph = RenderParagraph(
                TextSpan(text: widget.textValue, style: textStyle),
                maxLines: 1,
                textDirection: TextDirection.ltr,
              );
              renderParagraph.layout(constraints);
              const padding = 16.0;
              const textProgressPadding = 4.0;
              var textWidth = renderParagraph.getMinIntrinsicWidth(textStyle.fontSize).ceilToDouble();

              var textOffsetHorizontal = max(
                  min(constraints.biggest.width * widget.value + textProgressPadding,
                      constraints.biggest.width - textWidth - padding),
                  padding);

              return Padding(
                padding: EdgeInsets.only(
                  left: textOffsetHorizontal,
                ),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.textValue,
                      textAlign: TextAlign.left,
                      style: textStyle,
                    )),
              );
            },
          ),
        )
      ],
    );
  }
}
