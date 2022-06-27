import 'package:flutter/material.dart';
import 'package:ego/services/greeter.dart';
import 'package:ego/utilities/constants.dart';

class TopBar extends StatelessWidget {
  TopBar({Key? key}) : super(key: key);

  final String _day = Greeter.timeOfDay();

  @override
  Widget build(BuildContext context) {
    double paddingSize = 26.0;

    return Padding(
      padding: EdgeInsets.only(top: paddingSize, bottom: paddingSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good $_day!",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 1,
                    color: kSwatch4),
              ),
              const Text(
                "If3chi",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          //
          const CircleAvatar(
            radius: 36,
            backgroundImage: AssetImage(
              'assets/images/face.png',
            ),
          )
        ],
      ),
    );
  }
}
