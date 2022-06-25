import 'package:flutter/material.dart';
import 'package:ego/utilities/constants.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double paddingSize = 12.0;
    return Padding(
      padding: EdgeInsets.only(top: paddingSize, bottom: paddingSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Good Morning!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    letterSpacing: 1,
                    color: kSwatch4),
              ),
              Text(
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
