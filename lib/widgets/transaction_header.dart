import 'package:flutter/material.dart';
import 'package:ego/utilities/constants.dart';

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
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: Column(
        children: [
          Row(
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
          )
        ],
      ),
    );
  }
}
