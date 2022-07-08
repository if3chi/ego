import 'package:flutter/material.dart';
import 'package:ego/util/app_colors.dart';
import 'package:ego/widgets/ego_text.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Notify {
  static void show(
      {required BuildContext context,
      required String action,
      String title = ''}) {
    Flushbar(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(8),
      borderRadius: const BorderRadius.all(Radius.circular(8.0)),
      backgroundGradient: const LinearGradient(
          colors: [kSecondaryColor, kPrimaryColor], stops: [0.6, 1]),
      boxShadows: const [
        BoxShadow(color: Colors.black45, offset: Offset(3, 3), blurRadius: 3),
      ],
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
      duration: const Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP,
      titleText: Text(title,
          style: TextStyle(
              fontSize: title.isNotEmpty ? 14 : 0, fontWeight: FontWeight.w800),
          textAlign: TextAlign.center),
      messageText: EgoText.alert('Transaction $action Successfully!'),
    ).show(context);
  }

  static void alert(BuildContext context, Function actionFunction, index) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromRight,
      isCloseButton: false,
      backgroundColor: kSwatch0.withOpacity(0.3),
      isOverlayTapDismiss: false,
      descStyle: const TextStyle(fontWeight: FontWeight.normal),
      descTextAlign: TextAlign.center,
      animationDuration: const Duration(milliseconds: 300),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: const TextStyle(
        color: kRedColor,
      ),
      alertAlignment: Alignment.center,
    );

    Alert(
      context: context,
      style: alertStyle,
      title: "This action is IRREVERSIBLE",
      desc: "Are you sure, you want to delete this TRANSACTION?",
      buttons: [
        DialogButton(
          color: Colors.transparent,
          border: Border.fromBorderSide(BorderSide(
              color: Colors.white.withOpacity(0.4), style: BorderStyle.solid)),
          onPressed: () => Navigator.pop(context),
          child: EgoText.action("Cancel"),
        ),
        DialogButton(
          color: kRedColor,
          onPressed: () {
            Navigator.pop(context);
            actionFunction(context, index);
          },
          child: EgoText.action("Delete"),
        )
      ],
    ).show();
  }
}
