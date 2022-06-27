import 'package:flutter/material.dart';
import 'package:ego/models/transaction.dart';
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
    bool isIncome = Transaction.isIncome(type);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              txName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(
              height: 3.0,
            ),
            Text(
              dateFormat.format(txDate),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade300,
              ),
            )
          ]),
          Column(
            children: type == Transaction.debt
                ? [
                    AmountText(isIncome: isIncome, amount: amount),
                    const SizedBox(height: 2),
                    Text(
                      type,
                      style: TextStyle(
                        color: kSwatch5.withOpacity(0.5),
                        fontSize: 8,
                      ),
                    )
                  ]
                : [AmountText(isIncome: isIncome, amount: amount)],
          )
        ],
      ),
    );
  }
}

class AmountText extends StatelessWidget {
  const AmountText({
    Key? key,
    required this.isIncome,
    required this.amount,
  }) : super(key: key);

  final bool isIncome;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${isIncome ? "+" : "-"}\$${numberFormat.format(amount)}",
      style: TextStyle(
        color: isIncome ? kGreen : kRed,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
