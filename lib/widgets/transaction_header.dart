import 'package:flutter/material.dart';

import 'package:ego/util/app_colors.dart';

class TransactionHeader extends StatelessWidget {
  const TransactionHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const TextStyle actionTextStyle = TextStyle(
      color: kSwatch5,
      fontSize: 13,
      fontWeight: FontWeight.w800,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Transactions",
            style: actionTextStyle,
          ),
          TextButton(
            style: TextButton.styleFrom(
              primary: kSwatch5,
              onSurface: Colors.red,
            ),
            onPressed: () {},
            child: const Text(
              "View All",
              style: actionTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
