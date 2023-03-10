import 'package:flutter/material.dart';

import 'package:ego/util/app_colors.dart';
import 'package:ego/services/greeter.dart';

class TopBar extends StatelessWidget {
  TopBar({Key? key}) : super(key: key);

  final String _goodDay = Greeter.hello();

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
              const Text("Hello, If3chi",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                      letterSpacing: 2)),
              Text(_goodDay,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1,
                      color: kSwatch5))
            ],
          ),
          //
          const CircleAvatar(
              radius: 28, backgroundImage: AssetImage('assets/images/face.png'))
        ],
      ),
    );
  }
}
