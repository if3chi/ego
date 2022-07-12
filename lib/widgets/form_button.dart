import 'package:flutter/material.dart';
import 'package:ego/util/app_colors.dart';
import 'package:ego/widgets/ego_text.dart';

class FormButton extends StatelessWidget {
  const FormButton(
      {Key? key,
      this.buttonAction,
      this.text = 'Cancel',
      this.color = kSwatch5,
      this.outlined = false})
      : super(key: key);

  final String text;
  final Color color;
  final bool outlined;
  final VoidCallback? buttonAction;

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 18, vertical: 8);

    ButtonStyle outlineStyle = OutlinedButton.styleFrom(
        elevation: 2,
        backgroundColor: Colors.transparent,
        side: const BorderSide(color: Colors.white),
        padding: padding);

    return ElevatedButton(
      style: outlined
          ? outlineStyle
          : ElevatedButton.styleFrom(
              elevation: 3,
              primary: color,
              shadowColor: color,
              padding: padding),
      onPressed: buttonAction ?? () => Navigator.pop(context),
      child: EgoText.action(text),
    );
  }
}
