import 'package:flutter/material.dart';
import 'package:ego/util/constants.dart';
import 'package:ego/util/app_colors.dart';
import 'package:ego/models/transaction.dart';

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
          Flexible(
            flex: 2,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                txName,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
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
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade300,
                ),
              )
            ]),
          ),
          Flexible(
            child: Column(
              children: type == Transaction.debt
                  ? [
                      AmountText(isIncome: isIncome, amount: amount),
                      vSpaceMicro,
                      Text(
                        type,
                        style: TextStyle(
                          color: kSwatch5.withOpacity(0.5),
                          fontSize: 8,
                        ),
                      )
                    ]
                  : [AmountText(isIncome: isIncome, amount: amount)],
            ),
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
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: isIncome ? kGreen : kRed,
        fontSize: 12.5,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
