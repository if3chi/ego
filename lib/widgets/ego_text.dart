import 'package:ego/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:ego/util/app_colors.dart';

class EgoText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign alignment;


  EgoText.headline(this.text,
      {Key? key, String? font, Color? color, TextAlign align = TextAlign.start})
      : style = headlineStyle.copyWith(fontFamily: font, color: color),
        alignment = align,
        super(key: key);

  EgoText.subheading(this.text,
      {Key? key,
      Color color = kPrimaryColor,
      TextAlign align = TextAlign.start})
      : style = subheadingStyle.copyWith(color: color),
        alignment = align,
        super(key: key);

  EgoText.caption(this.text,
      {Key? key, Color? color, TextAlign align = TextAlign.start})
      : style = captionStyle.copyWith(color: color),
        alignment = align,
        super(key: key);

  EgoText.error(this.text,
      {Key? key, Color color = kRedColor, TextAlign align = TextAlign.start})
      : style = errorStyle.copyWith(color: color),
        alignment = align,
        super(key: key);

  EgoText.action(
    this.text, {
    Key? key,
    Color color = kSwatch5,
    TextAlign align = TextAlign.start,
  })  : style = actionStyle.copyWith(color: color),
        alignment = align,
        super(key: key);

  EgoText.body(this.text,
      {Key? key,
      Color color = kMediumGreyColor,
      TextAlign align = TextAlign.start})
      : style = bodyStyle.copyWith(color: color),
        alignment = align,
        super(key: key);

  EgoText.alert(this.text,
      {Key? key, Color? color, TextAlign align = TextAlign.center})
      : style = alertStyle.copyWith(color: color),
        alignment = align,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: alignment,
    );
  }
}
