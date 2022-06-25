import 'package:flutter/material.dart';
import 'package:ego/utilities/constants.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.txName,
    required this.txDate,
    required this.type,
    required this.amount,
  }) : super(key: key);

  final String txName;
  final DateTime txDate;
  final String type;
  final double amount;

  @override
  Widget build(BuildContext context) {
    bool isIncome = type == "income";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              txName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(
              height: 3.0,
            ),
            Text(
              dateFormat.format(txDate),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            )
          ]),
          Text(
            "${isIncome ? "+" : "-"}\$${numberFormat.format(amount)}",
            style: TextStyle(
              color: isIncome ? kGreen : kRed,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
