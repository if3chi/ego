import 'package:flutter/material.dart';
import 'package:ego/util/app_colors.dart';
import 'package:ego/widgets/ego_text.dart';

class FormButton extends StatelessWidget {
  const FormButton(
      {Key? key,
      this.buttonAction,
      this.text = 'Cancel',
      this.color = kSwatch0})
      : super(key: key);

  final String text;
  final Color color;
  final VoidCallback? buttonAction;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(2),
        backgroundColor: MaterialStateProperty.all(color),
        padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 18, vertical: 8)),
      ),
      onPressed: buttonAction ?? () => Navigator.pop(context),
      child: EgoText.action(text),
    );
  }
}
